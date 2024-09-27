#!/usr/bin/env bash

#===============================================================================
#  author: naestech
#  created: 2024-09-27 02:22
#===============================================================================

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

spotify_interpolation=(
    "\#{spotify_status}"
)

spotify_commands=(
    "#($CURRENT_DIR/scripts/spotify_status.sh)"
)

set_tmux_option() {
    local option=$1
    local value=$2
    tmux set-option -gq "$option" "$value"
}

do_interpolation() {
    local all_interpolated="$1"
    for ((i=0; i<${#spotify_interpolation[@]}; i++)); do
        all_interpolated=${all_interpolated//${spotify_interpolation[$i]}/${spotify_commands[$i]}}
    done
    echo "$all_interpolated"
}

update_tmux_option() {
    local option=$1
    local option_value=$(tmux show-option -gqv "$option")
    local new_option_value=$(do_interpolation "$option_value")
    set_tmux_option "$option" "$new_option_value"
}

main() {
    update_tmux_option "status-right"
    update_tmux_option "status-left"
}

main
