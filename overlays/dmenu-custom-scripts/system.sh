#!/bin/bash

# i3lock -i /home/daniels/Pictures/urknall.png
# TODO: Stop all software before logout
# https://faq.i3wm.org/question/239/how-do-i-suspendlockscreen-and-logout.1.html#post-id-1927

chosen=$(echo -e "lock\nsuspend\nlogout" | dmenu -i)
case "$chosen" in
"lock")
    # See: https://faq.i3wm.org/question/5654/how-can-i-disable-notifications-when-the-screen-locks-and-enable-them-again-when-unlocking/index.html#post-id-5655
    # suspend message display
    pkill -u "$USER" -USR1 dunst
    # guess i3lock via nix points to other PAM and therefore does not identify by password
    i3lock -c '#2E3436'
    # i3lock \
    #     --clock \
    #     --indicator \
    #     --pass-media-keys \
    #     --color=#2E3436 \
    #     --timecolor=#9CD9F0FF \
    #     --datecolor=#9CD9F0FF \
    #     --insidecolor=#2E3436FF \
    #     --ringcolor=#9CD9F0FF \
    #     --insidevercolor=#9CD9F0FF \
    #     --ringvercolor=#72B3CCFF \
    #     --veriftext="checking"
    # resume message display
    pkill -u "$USER" -USR2 dunst
    ;;
"suspend")
    # TODO: Fix that suspend is also locked
    i3lock -c '#2E3436'
    systemctl suspend
    ;;
"logout")
    i3-msg exit
    ;;
# "hibernate")
#     i3lock -c 2E3436
#     systemctl hibernate
#     ;;
*)
    exit 0
    ;;
esac
