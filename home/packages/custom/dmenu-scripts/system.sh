#!/bin/bash

# TODO: Stop all software before logout
# https://faq.i3wm.org/question/239/how-do-i-suspendlockscreen-and-logout.1.html#post-id-1927
# See: https://faq.i3wm.org/question/5654/how-can-i-disable-notifications-when-the-screen-locks-and-enable-them-again-when-unlocking/index.html#post-id-5655

# guess i3lock via nix points to other PAM and therefore does not identify by password

chosen=$(echo -e "lock\nsuspend\nlogout" | dmenu -i)
case "$chosen" in
"lock")
    pkill -u "$USER" -USR1 dunst
    i3lock -c '#2E3436'
    pkill -u "$USER" -USR2 dunst
    ;;
"suspend")
    pkill -u "$USER" -USR1 dunst
    i3lock -c '#2E3436'
    systemctl suspend
    pkill -u "$USER" -USR2 dunst
    ;;
"logout")
    i3-msg exit
    ;;
# Not supported, seems to complicated and not recommended with ssh
# "hibernate")
#     pkill -u "$USER" -USR1 dunst
#     i3lock -c '#2E3436'
#     systemctl suspend
#     pkill -u "$USER" -USR2 dunst
#     ;;
*)
    exit 0
    ;;
esac
