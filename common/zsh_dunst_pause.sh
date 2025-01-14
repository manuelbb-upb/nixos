function dunst_pause {
    COUNT_WAITING=$(dunstctl count waiting)
    COUNT_DISPLAYED=$(dunstctl count displayed)
    ENABLED='{"text": "󰂜", "tooltip": "notifications <span color='"'#a6da95'"'>on</span>", "class": "on" }'
    DISABLED='{"text": "󰪑", "tooltip": "notifications <span color='"'#ee99a0'"'>off</span>", "class": "off" }'

    if (( COUNT_DISPLAYED != 0 )); then
        ENABLED='{"text": "󰂚$COUNT_DISPLAYED", "tooltip": "$COUNT_DISPLAYED notifications", "class": "on" }'
    fi

    if (( COUNT_WAITING != 0 )); then
        DISABLED='{"text": "󰂛$COUNT_WAITING", "tooltip": "\(silent\) $COUNT_WAITING notifications", "class": "off" }'
    fi

    if dunstctl is-paused | rg -q 'false'; then
        echo "$ENABLED"
    else
        echo "$DISABLED"
    fi
}
