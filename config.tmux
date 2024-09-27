set -g default-terminal "screen-256color"

# set default tmux prefix to control a
set -g prefix C-a
unbind C-b
bind-key C-a send-prefix

# change keybinds to split windows
unbind %
bind | split-window -h

unbind '"'
bind - split-window -v

# change keybind to refresh tmux config
unbind r
bind r source-file ~/.tmux.conf

#  TODO: finish youtube video. https://youtu.be/U-omALWIBos?si=4Np2GlF2R9ZsRMz8&t=449

# add keybinds to resize tmux panes
bind -r j resize-pane -D 5
bind -r k resize-pane -U 5
bind -r l resize-pane -R 5
bind -r h resize-pane -L 5

# add keybinds to maximize and minimize tmux panes
bind -r m resize-pane -Z

# enable the mouse
set -g mouse on

# config tmux to use same select and copy keybinds as nvim
set-window-option -g mode-keys vi

bind-key -T copy-mode-vi 'v' send -X begin-selection # start selecting text with "v"
bind-key -T copy-mode-vi 'y' send -X copy-selection # copy text with "y"

unbind -T copy-mode-vi MouseDragEnd1Pane # don't exit copy mode after dragging with mouse

# tpm plugin
set -g @plugin 'tmux-plugins/tpm'

# list of tmux plugins
set -g @plugin 'christoomey/vim-tmux-navigator' # for navigating panes and vim/nvim with Ctrl-hjkl
set -g @plugin 'wfxr/tmux-power' # to configure tmux theme
set -g @plugin 'tmux-plugins/tmux-resurrect' # persist tmux sessions after computer restart
set -g @plugin 'tmux-plugins/tmux-continuum' # automatically saves sessions for you every 15 minutes

set -g @tmux_power_theme '#f8e09e' # use this custom yellow theme for tmux

set -g @resurrect-capture-pane-contents 'on' # allow tmux-ressurect to capture pane contents
set -g @continuum-restore 'on' # enable tmux-continuum functionality

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
