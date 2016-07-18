# Script to notify on slow commands
beep_if_long_time_past() {
    local LAST_EXIT="$?"
    LAST_COMMAND_DURATION=$(($(date +%s) - ${LAST_COMMAND_TIME}))
    [[ ${LAST_COMMAND_DURATION} -gt 10 ]] && { notify-send "Script finished with ${LAST_EXIT} in ${LAST_COMMAND_DURATION} seconds" "$previous_command"; }
    export LAST_COMMAND_TIME=
}

export PROMPT_COMMAND=beep_if_long_time_past
trap 'previous_command=$this_command; this_command=$BASH_COMMAND && [ -z ${LAST_COMMAND_TIME} ] && export LAST_COMMAND_TIME=$(date +%s) ' DEBUG
