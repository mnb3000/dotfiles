#!/usr/bin/env bash

window_move_bindings() {
  tmux bind-key -r "<" swap-window -d -t -1
  tmux bind-key -r ">" swap-window -d -t +1

  # pane movement
  # tmux bind-key < command-prompt -p "join pane from:"  "join-pane -s '%%'"
  # tmux bind-key > command-prompt -p "send pane to:"  "join-pane -t '%%'"
}

window_navigation_bindings() {
  # Shift Alt vim keys to switch windows
  tmux bind-key -n M-H previous-window
  tmux bind-key -n M-L next-window

  tmux bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt
}

pane_split_bindings() {
  tmux bind-key "\\" split-window -h -c "#{pane_current_path}"
  tmux bind-key "|" split-window -fh -c "#{pane_current_path}"
  tmux unbind %

  tmux bind-key "-" split-window -v -c "#{pane_current_path}"
  tmux bind-key "_" split-window -fv -c "#{pane_current_path}"
  tmux unbind '"'
}

improve_new_window_binding() {
  # Open new panes and splits in the same working directory.
  tmux bind c new-window -c "#{pane_current_path}"
}

main() {
  window_move_bindings
  window_navigation_bindings
  pane_split_bindings
  improve_new_window_binding
}

main
