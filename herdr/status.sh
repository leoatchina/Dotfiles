#!/bin/sh
set -eu

context=
herdr_bin=${HERDR_BIN_PATH:-herdr}
active_workspace=${HERDR_ACTIVE_WORKSPACE_ID:-}
active_tab=${HERDR_ACTIVE_TAB_ID:-}
active_pane=${HERDR_ACTIVE_PANE_ID:-}

if [ -n "$active_workspace" ] && [ -n "$active_tab" ] && [ -n "$active_pane" ] && command -v "$herdr_bin" >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
    snapshot=$($herdr_bin api snapshot 2>/dev/null || true)
    if [ -n "$snapshot" ]; then
        workspace_name=$(printf '%s' "$snapshot" | jq -r --arg workspace "$active_workspace" '.result.snapshot.workspaces[] | select(.workspace_id == $workspace) | .label // empty' | sed -n '1p')
        tab_number=$(printf '%s' "$snapshot" | jq -r --arg tab "$active_tab" '.result.snapshot.tabs[] | select(.tab_id == $tab) | .number // empty')
        pane_index=$(printf '%s' "$snapshot" | jq -r --arg tab "$active_tab" --arg pane "$active_pane" '.result.snapshot.panes | map(select(.tab_id == $tab)) | map(.pane_id) | index($pane) // empty')
        if [ -n "$workspace_name" ] && [ -n "$tab_number" ] && [ -n "$pane_index" ]; then
            context=$(printf '%s | W%s:P%s | ' "$workspace_name" "$tab_number" "$((pane_index + 1))")
        fi
    fi
fi

read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
total_before=$((user + nice + system + idle + iowait + irq + softirq + steal))
idle_before=$((idle + iowait))
sleep 0.5
read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
total_after=$((user + nice + system + idle + iowait + irq + softirq + steal))
idle_after=$((idle + iowait))
total_delta=$((total_after - total_before))
idle_delta=$((idle_after - idle_before))

cpu_usage=$(awk -v total="$total_delta" -v idle="$idle_delta" 'BEGIN { if (total > 0) printf "%.0f", (total - idle) * 100 / total; else print "0" }')
memory_usage=$(awk '/MemTotal:/ { total = $2 } /MemAvailable:/ { available = $2 } END { printf "%.1fG/%.1fG", (total - available) / 1048576, total / 1048576 }' /proc/meminfo)

printf '%sC:%s%% | M:%s\n' "$context" "$cpu_usage" "$memory_usage"
