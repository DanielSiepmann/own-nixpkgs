activeString=""
action=$(echo -e "enable\ndisable\n" | dmenu -l 2 -i -p "$activeString")
case "$action" in
"enable")
    sudo /bin/ln -s /etc/php/7.2/mods-available/xdebug.ini /etc/php/7.2/cli/conf.d/20-xdebug.ini || true
    sudo /bin/ln -s /etc/php/7.2/mods-available/xdebug.ini /etc/php/7.2/fpm/conf.d/20-xdebug.ini || true

    sudo /bin/ln -s /etc/php/7.3/mods-available/xdebug.ini /etc/php/7.3/cli/conf.d/20-xdebug.ini || true
    sudo /bin/ln -s /etc/php/7.3/mods-available/xdebug.ini /etc/php/7.3/fpm/conf.d/20-xdebug.ini || true

    sudo /bin/ln -s /etc/php/7.4/mods-available/xdebug.ini /etc/php/7.4/cli/conf.d/20-xdebug.ini || true
    sudo /bin/ln -s /etc/php/7.4/mods-available/xdebug.ini /etc/php/7.4/fpm/conf.d/20-xdebug.ini || true

    sudo /bin/ln -s /etc/php/8.0/mods-available/xdebug.ini /etc/php/8.0/cli/conf.d/20-xdebug.ini || true
    sudo /bin/ln -s /etc/php/8.0/mods-available/xdebug.ini /etc/php/8.0/fpm/conf.d/20-xdebug.ini || true

    sudo /bin/ln -s /etc/php/8.1/mods-available/xdebug.ini /etc/php/8.1/cli/conf.d/20-xdebug.ini || true
    sudo /bin/ln -s /etc/php/8.1/mods-available/xdebug.ini /etc/php/8.1/fpm/conf.d/20-xdebug.ini || true

    sudo /bin/ln -s /etc/php/8.2/mods-available/xdebug.ini /etc/php/8.2/cli/conf.d/20-xdebug.ini || true
    sudo /bin/ln -s /etc/php/8.2/mods-available/xdebug.ini /etc/php/8.2/fpm/conf.d/20-xdebug.ini || true
    ;;
"disable")
    sudo /usr/bin/unlink /etc/php/7.2/cli/conf.d/20-xdebug.ini || true
    sudo /usr/bin/unlink /etc/php/7.2/fpm/conf.d/20-xdebug.ini || true

    sudo /usr/bin/unlink /etc/php/7.3/cli/conf.d/20-xdebug.ini || true
    sudo /usr/bin/unlink /etc/php/7.3/fpm/conf.d/20-xdebug.ini || true

    sudo /usr/bin/unlink /etc/php/7.4/cli/conf.d/20-xdebug.ini || true
    sudo /usr/bin/unlink /etc/php/7.4/fpm/conf.d/20-xdebug.ini || true

    sudo /usr/bin/unlink /etc/php/8.0/cli/conf.d/20-xdebug.ini || true
    sudo /usr/bin/unlink /etc/php/8.0/fpm/conf.d/20-xdebug.ini || true

    sudo /usr/bin/unlink /etc/php/8.1/cli/conf.d/20-xdebug.ini || true
    sudo /usr/bin/unlink /etc/php/8.1/fpm/conf.d/20-xdebug.ini || true

    sudo /usr/bin/unlink /etc/php/8.2/cli/conf.d/20-xdebug.ini || true
    sudo /usr/bin/unlink /etc/php/8.2/fpm/conf.d/20-xdebug.ini || true
    ;;
*)
    exit 0
    ;;
esac

sudo /bin/systemctl reload php7.2-fpm.service || true
sudo /bin/systemctl reload php7.3-fpm.service || true
sudo /bin/systemctl reload php7.4-fpm.service || true
sudo /bin/systemctl reload php8.0-fpm.service || true
sudo /bin/systemctl reload php8.1-fpm.service || true
sudo /bin/systemctl reload php8.2-fpm.service || true
pkill -SIGRTMIN+10 i3blocks || true
notify-send "switching xdebug: $action"
