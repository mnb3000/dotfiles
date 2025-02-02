#!/usr/bin/env bash
count=0

tmux list-panes -t SideJITServer -F '#{pane_id}' | while read win_id; do
  output=""

  if [[ $count = 0 ]]; then
    output="netmuxd --disable-unix --host 127.0.0.1 --plist-storage ~/projects/personal/SideJITServer/static/"
  else
    output="SideJITServer"
  fi

  tmux send-keys -t "${win_id}" '^C' C-m
  tmux send-keys -t "${win_id}" 'export USBMUXD_SOCKET_ADDRESS=127.0.0.1:27015' C-m
  tmux send-keys -t "${win_id}" 'export PYMOBILEDEVICE3_USBMUX=127.0.0.1:27015' C-m
  tmux send-keys -t "${win_id}" "sudo $output" C-m
  tmux send-keys -t "${win_id}" "$1" C-m
  ((count++))
done
