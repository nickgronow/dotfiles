# Switch panes.
# bind-key -T root M-h select-pane -L
# bind-key -T root M-j select-pane -D
# bind-key -T root M-k select-pane -U
# bind-key -T root M-l select-pane -R
# smart pane switching with awareness of vim splits
# Smart pane switching with awareness of Vim splits.
# See: https://github.com/christoomey/vim-tmux-navigator
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
bind-key -n M-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
bind-key -n M-j if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
bind-key -n M-k if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
bind-key -n M-l if-shell "$is_vim" "send-keys C-l"  "select-pane -R"
bind-key -n C-\ if-shell "$is_vim" "send-keys C-\\" "select-pane -l"

# bind -n C-\ run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys 'C-\\') || tmux select-pane -l"

# Switch windows.
bind-key -T root M-p select-window -t :- # Previous window.
bind-key -T root M-n select-window -t :+ # Next window.

# Toggle zoom.
bind-key -T root M-f resize-pane -Z

# Resize panes.
bind-key -T root M-H resize-pane -L 2
bind-key -T root M-J resize-pane -D 1
bind-key -T root M-K resize-pane -U 1
bind-key -T root M-L resize-pane -R 2

# Enter copy mode.
bind-key -T root M-v copy-mode
bind-key -T root M-v copy-mode \; send-keys -X C-u

# Close panes.
bind-key -T root M-w kill-pane

# Window selection
bind-key -T root M-1 select-window -t:^
bind-key -T root M-2 select-window -t:2
bind-key -T root M-3 select-window -t:3
bind-key -T root M-4 select-window -t:4
bind-key -T root M-5 select-window -t:5
bind-key -T root M-6 select-window -t:6
bind-key -T root M-7 select-window -t:7
bind-key -T root M-8 select-window -t:8
bind-key -T root M-9 select-window -t:"\$"
bind-key -T root M-0 select-window -t:!
bind-key -T root M-- select-window -t:!
