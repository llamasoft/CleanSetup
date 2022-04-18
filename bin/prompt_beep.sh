trap '[[ -z "${START_TIME}" ]] && START_TIME="${SECONDS}"' DEBUG

command_timer() {
    local rtn=$?
    local runtime=$(( SECONDS - START_TIME ))
    local beep_threshold="${BEEP_THRESHOLD:-30}"
    local beep_count="${BEEP_COUNT:-1}"
    local beep_delay="${BEEP_DELAY:-0.1}"

    if (( runtime >= beep_threshold )); then
        while (( beep_count-- > 0 )); do
            printf "\007"
            (( beep_count > 0 )) && sleep "${beep_delay}"
        done
    fi

    START_TIME=""
    return "${rtn}"
}

PROMPT_COMMAND='command_timer'
