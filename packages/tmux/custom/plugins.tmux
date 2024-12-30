# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-yank'        # Cross-platform support for clipboard.
set -g @plugin 'tmux-plugins/tmux-resurrect'   # Save/Restore sessions
set -g @plugin 'tmux-plugins/tmux-continuum'   # Auto Save/Restore
set -g @plugin 'tmux-plugins/tmux-battery'     # Battery level data

set -g @plugin 'sainnhe/tmux-fzf'
set -g @plugin 'wfxr/tmux-fzf-url'

set -g @plugin 'christoomey/vim-tmux-navigator'
set -g @plugin 'alexwforsythe/tmux-which-key'

set -g @plugin 'laktak/extrakto'

set -g @plugin 'janoamaral/tokyo-night-tmux'

# Restore using continuum.
# set -g @continuum-restore 'on'

# fzf-url popup
set -g @fzf-url-fzf-options '-w 50% -h 50% --multi -0 --no-preview --no-border'

# extrakto termux clipboard
if 'command -v termux-clipboard-set' {
  set -g @extrakto_clip_tool termux-clipboard-set
  set -g @override_copy_command 'termux-clipboard-set'
}

# Tokyo Night Theme

set -g @tokyo-night-tmux_theme night
set -g @tokyo-night-tmux_transparent 1

# set -g @tokyo-night-tmux_show_music 1
# set -g @tokyo-night-tmux_show_netspeed 1
# set -g @tokyo-night-tmux_netspeed_iface 'en0' # Detected via default route
# set -g @tokyo-night-tmux_netspeed_refresh 2     # Update interval in seconds (default 1)

set -g @tokyo-night-tmux_show_battery_widget 1
set -g @tokyo-night-tmux_battery_name 'InternalBattery-0'  # some linux distro have 'BAT0'
set -g @tokyo-night-tmux_battery_low_threshold 21 # default

set -g @tokyo-night-tmux_show_datetime 0

set -g @tokyo-night-tmux_show_hostname 1

set -g @tokyo-night-tmux_show_path 1
set -g @tokyo-night-tmux_path_format relative # 'relative' or 'full'

set -g @tokyo-night-tmux_window_id_style digital
set -g @tokyo-night-tmux_pane_id_style hsquare
set -g @tokyo-night-tmux_zoom_id_style dsquare

set-option -g status-position top

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
# `Prefix + I` to load plugins
if "test ! -d ~/.tmux/plugins/tpm" \
   "run 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins'"
run '~/.tmux/plugins/tpm/tpm'
