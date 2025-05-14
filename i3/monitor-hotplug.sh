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

# Dell U2412M显示器的EDID片段标识
U2412M_EDID="0010ac7aa042"

# 调整显示器配置
XRANDR_CMD="xrandr --output eDP-1 --primary --auto"

# 确保所有连接的显示器都启用
for OUTPUT in $CONNECTED_MONITORS; do
    # 跳过内置显示器，它已经在基本命令中处理
    if [[ "$OUTPUT" != "eDP-1" ]]; then
        XRANDR_CMD+=" --output $OUTPUT --auto"
        # 如果是DP-2，记录其EDID信息（用于后续位置决策）
        if [[ "$OUTPUT" == "DP-2" ]]; then
            # 获取EDID信息
            DP2_EDID=$(xrandr --props | grep -A 2 "^$OUTPUT connected" | grep EDID -A 1 | grep -v EDID | head -1 | tr -d '[:space:]' | cut -c17-28)
            log_message "DP-2连接的显示器EDID片段: $DP2_EDID"
        fi
    fi
done

# 位置配置 - 按照用户要求将显示器排列
if xrandr | grep -q "DP-1 connected"; then
    XRANDR_CMD+=" --output DP-1 --right-of eDP-1"
fi

if xrandr | grep -q "DP-2 connected"; then
    # 简单判断：只有U2412M放左边，其他都放右边
    if [[ "$DP2_EDID" == *"$U2412M_EDID"* ]]; then
        # Dell U2412M显示器放左边
        log_message "识别到Dell U2412M显示器，放置在左侧"
        XRANDR_CMD+=" --output DP-2 --left-of eDP-1"
    else
        # 其他所有情况都放右边
        log_message "显示器放置在右侧"
        if xrandr | grep -q "DP-1 connected"; then
            XRANDR_CMD+=" --output DP-2 --right-of DP-1"
        else
            XRANDR_CMD+=" --output DP-2 --right-of eDP-1"
        fi
    fi
fi

if xrandr | grep -q "DP-3 connected"; then
    XRANDR_CMD+=" --output DP-3 --left-of eDP-1"
fi

# 执行xrandr命令
log_message "执行: $XRANDR_CMD"
eval $XRANDR_CMD
