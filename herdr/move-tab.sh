#!/bin/sh
set -eu

direction=${1:?expected previous or next}
herdr_bin=${HERDR_BIN_PATH:-herdr}
socket_path=${HERDR_SOCKET_PATH:-$HOME/.config/herdr/herdr.sock}
snapshot=$($herdr_bin api snapshot)
tabs=$(printf '%s' "$snapshot" | jq -c --arg workspace "$HERDR_ACTIVE_WORKSPACE_ID" '.result.snapshot.tabs | map(select(.workspace_id == $workspace))')
current_index=$(printf '%s' "$tabs" | jq --arg tab "$HERDR_ACTIVE_TAB_ID" 'map(.tab_id) | index($tab)')
tab_count=$(printf '%s' "$tabs" | jq 'length')

case $direction in
    previous)
        [ "$current_index" -gt 0 ] || exit 0
        insert_index=$((current_index - 1))
        ;;
    next)
        [ "$current_index" -lt $((tab_count - 1)) ] || exit 0
        insert_index=$((current_index + 2))
        ;;
    *)
        printf 'expected previous or next\n' >&2
        exit 2
        ;;
esac

jq -cn \
    --arg id "move-tab-$$" \
    --arg tab_id "$HERDR_ACTIVE_TAB_ID" \
    --argjson insert_index "$insert_index" \
    '{id: $id, method: "tab.move", params: {tab_id: $tab_id, insert_index: $insert_index}}' \
    | nc -N -U "$socket_path" >/dev/null
