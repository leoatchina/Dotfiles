#!/bin/bash

# 定义日志文件
LOG_FILE="/tmp/monitor-hotplug.log"

# 删除旧的日志文件
if [ -f "$LOG_FILE" ]; then
    rm -f "$LOG_FILE"
fi

# 日志记录函数
log_message() {
    echo "$(date): $1" >> $LOG_FILE
}

# 记录脚本启动
log_message "显示器热插拔事件触发"

# 检测连接的显示器
CONNECTED_MONITORS=$(xrandr | grep " connected" | awk '{print $1}')
log_message "连接的显示器: $CONNECTED_MONITORS"

# Dell U2412M显示器的EDID片段标识（前32个字符即可）
U2412M_EDID="00ffffffffffff0010ac7aa042"

# 记录系统信息
log_message "系统信息: $(uname -a)"
log_message "xrandr版本: $(xrandr --version)"

# 调整显示器配置
XRANDR_CMD="xrandr --output eDP-1 --primary --auto"

# 用于保存DP-2的EDID信息
DP2_EDID=""

# DP-2是否已处理标志
DP2_PROCESSED=false

# 确保所有连接的显示器都启用
for OUTPUT in $CONNECTED_MONITORS; do
    # 跳过内置显示器，它已经在基本命令中处理
    if [[ "$OUTPUT" != "eDP-1" ]]; then
        # 如果是DP-2，只设置标志，稍后再单独处理
        if [[ "$OUTPUT" == "DP-2" ]]; then
            DP2_PROCESSED=true
            # 获取EDID信息 - 提取前32个字符，这通常足以识别显示器型号
            DP2_EDID=$(xrandr --props | grep -A 3 "^$OUTPUT connected" | grep -A 1 "EDID:" | grep -v "EDID:" | head -1 | tr -d '[:space:]')
            log_message "DP-2连接的显示器完整EDID: $DP2_EDID"
            
            # 确保我们得到了一些EDID数据
            if [[ -z "$DP2_EDID" ]]; then
                log_message "警告: 无法获取DP-2的EDID信息"
            else
                log_message "成功获取DP-2的EDID信息"
            fi
        else
            # 非DP-2显示器正常添加auto选项
            XRANDR_CMD+=" --output $OUTPUT --auto"
            log_message "启用显示器: $OUTPUT"
        fi 
    fi
done

# 位置配置 - 按照用户要求将显示器排列
if xrandr | grep -q "DP-1 connected"; then
    XRANDR_CMD+=" --output DP-1 --right-of eDP-1"
fi

if [[ $DP2_PROCESSED == true ]]; then
    log_message "检测DP-2是否为U2412M: 比较 '$DP2_EDID' 是否包含 '$U2412M_EDID'"
    
    # 给DP-2添加auto选项
    XRANDR_CMD+=" --output DP-2 --auto"
    log_message "启用显示器: DP-2"
    
    # 简单判断：只有U2412M放左边，其他都放右边
    if [[ -n "$DP2_EDID" && "$DP2_EDID" == *"$U2412M_EDID"* ]]; then
        # Dell U2412M显示器放左边
        log_message "成功识别到Dell U2412M显示器，放置在左侧"
        XRANDR_CMD+=" --left-of eDP-1"
    else
        # 其他所有情况都放右边
        if [[ -z "$DP2_EDID" ]]; then
            log_message "警告: DP2_EDID为空，无法确认显示器型号，默认放置在右侧"
        else
            log_message "DP-2不是U2412M显示器或无法确认，放置在右侧"
        fi
        
        if xrandr | grep -q "DP-1 connected"; then
            log_message "DP-1已连接，将DP-2放在DP-1右侧"
            XRANDR_CMD+=" --right-of DP-1"
        else
            log_message "DP-1未连接，将DP-2放在eDP-1右侧"
            XRANDR_CMD+=" --right-of eDP-1"
        fi
    fi
fi


# 确保xrandr命令不为空
if [[ -n "$XRANDR_CMD" ]]; then
    # 执行xrandr命令
    log_message "执行: $XRANDR_CMD"
    eval $XRANDR_CMD
    EXIT_CODE=$?
    if [ $EXIT_CODE -eq 0 ]; then
        log_message "xrandr命令执行成功"
    else
        log_message "错误: xrandr命令执行失败，返回代码: $EXIT_CODE"
    fi
else
    log_message "错误: xrandr命令为空，未执行任何操作"
fi

# finish
log_message "脚本执行完成"
