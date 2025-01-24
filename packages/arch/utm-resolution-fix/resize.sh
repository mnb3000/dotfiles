#! /bin/sh
PATH=/usr/bin
desktopuser=$(/bin/ps -ef | /bin/grep -oP '^\w+ (?=.*vdagent( |$))') || exit 0
export DISPLAY=:0
export XAUTHORITY="$(eval echo "~$desktopuser")/.Xauthority"
xrandr --output "$(xrandr | awk '{if($0 ~/ connected/){print $1}}')" --auto
