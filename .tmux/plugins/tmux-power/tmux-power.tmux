#!/usr/bin/env bash
#===============================================================================================================
#  Author: Wenxuan
#  Email: wenxuangm@gmail.com
#  Created: 2018-04-05 17:37
#  Repo: https://github.com/wfxr/tmux-power
#  
#  Note: lines 134-135 have been modified from the original code to display the current song playing on Spotify.
#===============================================================================================================

# $1: option
# $2: default value
tmux_get() {
    local value="$(tmux show -gqv "$1")"
    [ -n "$value" ] && echo "$value" || echo "$2"
}

# $1: option
# $2: value
tmux_set() {
    tmux set-option -gq "$1" "$2"
}

# Options
rarrow=$(tmux_get '@tmux_power_right_arrow_icon' '')
larrow=$(tmux_get '@tmux_power_left_arrow_icon' '')
upload_speed_icon=$(tmux_get '@tmux_power_upload_speed_icon' '󰕒')
download_speed_icon=$(tmux_get '@tmux_power_download_speed_icon' '󰇚')
session_icon="$(tmux_get '@tmux_power_session_icon' '')"
user_icon="$(tmux_get '@tmux_power_user_icon' '')"
time_icon="$(tmux_get '@tmux_power_time_icon' '')"
date_icon="$(tmux_get '@tmux_power_date_icon' '')"
show_upload_speed="$(tmux_get @tmux_power_show_upload_speed false)"
show_download_speed="$(tmux_get @tmux_power_show_download_speed false)"
show_web_reachable="$(tmux_get @tmux_power_show_web_reachable false)"
prefix_highlight_pos=$(tmux_get @tmux_power_prefix_highlight_pos)
time_format=$(tmux_get @tmux_power_time_format '%T')
date_format=$(tmux_get @tmux_power_date_format '%F')

# New Spotify options
spotify_icon="$(tmux_get '@tmux_power_spotify_icon' '󰓇')"
show_spotify="$(tmux_get @tmux_power_show_music_status on)"
spotify_format="$(tmux_get @tmux_power_music_status_format '#(~/spotify-now-playing.sh 2>/dev/null)')"

# short for Theme-Colour
TC=$(tmux_get '@tmux_power_theme' 'lavender')
case $TC in
    'gold' )
        TC='#ffb86c'
        ;;
    'redwine' )
        TC='#b34a47'
        ;;
    'moon' )
        TC='#00abab'
        ;;
    'forest' )
        TC='#228b22'
        ;;
    'violet' )
        TC='#9370db'
        ;;
    'snow' )
        TC='#fffafa'
        ;;
    'coral' )
        TC='#ff7f50'
        ;;
    'sky' )
        TC='#87ceeb'
        ;;
    'everforest' )
        TC='#a7c080'
        ;;
    'default' ) # Useful when your term changes colour dynamically (e.g. pywal)
        TC='colour3'
        ;;
    'lavender' )
        TC='#A0ACE4'
        ;;
esac

G01=#080808 #232
G02=#121212 #233
G03=#1c1c1c #234
G04=#A0ACE4 #235
G05=#303030 #236
G06=#A0ACE4 #237
G07=#444444 #238
G08=#4e4e4e #239
G09=#585858 #240
G10=#000000 #241
G11=#6c6c6c #242
G12=#000000 #243

FG="$G10"
BG="$G04"

# Status options
tmux_set status-interval 5  # increased to give more time between refreshes
tmux_set status on

# Basic status bar colors
tmux_set status-fg "$FG"
tmux_set status-bg "$BG"
tmux_set status-attr none

# tmux-prefix-highlight
tmux_set @prefix_highlight_fg "$BG"
tmux_set @prefix_highlight_bg "$FG"
tmux_set @prefix_highlight_show_copy_mode 'on'
tmux_set @prefix_highlight_copy_mode_attr "fg=$TC,bg=$BG,bold"
tmux_set @prefix_highlight_output_prefix "#[fg=$TC]#[bg=$BG]$larrow#[bg=$TC]#[fg=$BG]"
tmux_set @prefix_highlight_output_suffix "#[fg=$TC]#[bg=$BG]$rarrow"

# Left side of status bar
tmux_set status-left-bg "$G04"
tmux_set status-left-fg "$G12"
tmux_set status-left-length 150
user=$(whoami)
LS="#[fg=#000000,bg=$TC,bold] $user_icon $user@#h #[fg=$TC,bg=$G06,nobold]$rarrow#[fg=#000000,bg=$G06] $session_icon #S "
tmux_set status-left "$LS"

# Right side of status bar (simplified)
tmux_set status-right-bg "$BG"
tmux_set status-right-fg "$G12"
tmux_set status-right-length 150

# Right side of status bar with spotify logo, song, and clock (hour and minute only)
RS="#[fg=#000000,bg=$TC] $spotify_icon #(~/spotify-now-playing.sh) #[fg=#000000,bg=$TC] $time_icon %H:%M #[fg=$TC,bg=$G06]$larrow#[fg=#000000,bg=$TC] $date_icon %F"
tmux_set status-right "$RS"

# Window status format
tmux_set window-status-format         "#[fg=$BG,bg=$G06]$rarrow#[fg=#000000,bg=$G06] #I:#W#F #[fg=$G06,bg=$BG]$rarrow"
tmux_set window-status-current-format "#[fg=$BG,bg=$TC]$rarrow#[fg=#000000,bg=$TC,bold] #I:#W#F #[fg=$TC,bg=$BG,nobold]$rarrow"

# Pane border
tmux_set pane-border-style "fg=$G07,bg=default"
tmux_set pane-active-border-style "fg=$TC,bg=default"

# Clock mode
tmux_set clock-mode-colour "$TC"
tmux_set clock-mode-style 24

# Message and Copy mode highlight
tmux_set message-style "fg=$TC,bg=$BG"
tmux_set message-command-style "fg=$TC,bg=$BG"
tmux_set mode-style "bg=$TC,fg=$FG"

