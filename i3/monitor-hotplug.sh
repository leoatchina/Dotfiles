#!/bin/bash

# 定义日志文件
LOG_FILE="/tmp/monitor-hotplug.log"

# 日志记录函数
log_message() {
    echo "$(date): $1" >> $LOG_FILE
}

# 记录脚本启动
log_message "显示器热插拔事件触发"

# 等待系统识别显示器
sleep 2

# 检测连接的显示器
CONNECTED_MONITORS=$(xrandr | grep " connected" | awk '{print $1}')
log_message "连接的显示器: $CONNECTED_MONITORS"

# 映射表 - 包含每个显示器的EDID片段和对应的端口
declare -A MONITOR_MAP
# AOC Q27P2W 显示器 - 映射到 DP-1
MONITOR_MAP["0005e302276d"]="DP-1"
# Dell P1917S 显示器 - 映射到 DP-2
MONITOR_MAP["0010ac93d042"]="DP-2"
# 如果有U2412显示器，可以添加在这里并映射到 DP-3
# MONITOR_MAP["EDID_FRAGMENT_U2412"]="DP-3"

# 当前显示器到物理端口的映射
declare -A CURRENT_MAPPING

# 获取已连接显示器的EDID信息并与预设的映射比较
for OUTPUT in $CONNECTED_MONITORS; do
    # 跳过内置显示器
    if [[ "$OUTPUT" == "eDP-1" ]]; then
        continue
    fi
    
    # 获取EDID信息 (只取前32位中的片段作为标识)
    EDID=$(xrandr --props | grep -A 2 "^$OUTPUT connected" | grep EDID -A 1 | grep -v EDID | head -1 | tr -d '[:space:]' | cut -c17-28)
    
    if [[ -n "$EDID" ]]; then
        log_message "输出 $OUTPUT 的EDID片段: $EDID"
        
        # 检查这个EDID是否在我们的映射表中
        for MONITOR_EDID in "${!MONITOR_MAP[@]}"; do
            if [[ "$EDID" == *"$MONITOR_EDID"* ]]; then
                TARGET_OUTPUT=${MONITOR_MAP[$MONITOR_EDID]}
                CURRENT_MAPPING[$TARGET_OUTPUT]=$OUTPUT
                log_message "将 $OUTPUT (EDID片段: $EDID) 映射到 $TARGET_OUTPUT"
                break
            fi
        done
    fi
done

# 调整显示器配置
XRANDR_CMD="xrandr --output eDP-1 --primary --auto"

# 处理每个预定义的输出
for TARGET_OUTPUT in "${!MONITOR_MAP[@]}"; do
    CURRENT_OUTPUT=${CURRENT_MAPPING[${MONITOR_MAP[$TARGET_OUTPUT]}]:-""}    
    if [[ -n "$CURRENT_OUTPUT" && "$CURRENT_OUTPUT" != "${MONITOR_MAP[$TARGET_OUTPUT]}" ]]; then
        # 如果当前输出连接到不同的端口，需要更改
        log_message "需要更改: $CURRENT_OUTPUT 应该连接到 ${MONITOR_MAP[$TARGET_OUTPUT]}"
        XRANDR_CMD+=" --output $CURRENT_OUTPUT --auto --output ${MONITOR_MAP[$TARGET_OUTPUT]} --same-as $CURRENT_OUTPUT"
    elif [[ -n "$CURRENT_OUTPUT" && "$CURRENT_OUTPUT" == "${MONITOR_MAP[$TARGET_OUTPUT]}" ]]; then
        # 已经连接到正确的端口
        log_message "已正确连接: $CURRENT_OUTPUT"
        XRANDR_CMD+=" --output $CURRENT_OUTPUT --auto"
    fi
done

# 位置配置 - 按照用户要求将显示器排列
if xrandr | grep -q "DP-1 connected"; then
    XRANDR_CMD+=" --output DP-1 --right-of eDP-1"
fi

if xrandr | grep -q "DP-2 connected"; then
    if xrandr | grep -q "DP-1 connected"; then
        XRANDR_CMD+=" --output DP-2 --right-of DP-1"
    else
        XRANDR_CMD+=" --output DP-2 --right-of eDP-1"
    fi
fi

if xrandr | grep -q "DP-3 connected"; then
    XRANDR_CMD+=" --output DP-3 --left-of eDP-1"
fi

# 执行xrandr命令
log_message "执行: $XRANDR_CMD"
eval $XRANDR_CMD
