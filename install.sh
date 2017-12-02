#!/usr/bin/env bash

confirm() {
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            exit
            ;;
    esac
}

echo "
 ___        __ _       _ _       ____
|_ _|_ __  / _(_)_ __ (_) |_ ___|  _ \ ___  _ __  _   _
 | || '_ \| |_| | '_ \| | __/ _ \ |_) / _ \| '_ \| | | |
 | || | | |  _| | | | | | ||  __/  __/ (_) | | | | |_| |
|___|_| |_|_| |_|_| |_|_|\__\___|_|   \___/|_| |_|\__, |
                                                  |___/
"

confirm "Install InfinitePony in /usr/local/bin/ [y/N]"

ISINSTALLED="$(whereis ponysay)"
if [[ "$ISINSTALLED" = "ponysay:" ]]
then
    tput setaf 3
    echo "You must install ponysay to make InfinitePony works (Install ponysay here : https://github.com/erkin/ponysay#readme)"
    tput sgr 0
    exit 1
else
    if [[ $EUID -ne 0 ]]; then
        tput setaf 3
        echo "This script must be run as root" 1>&2
        tput sgr 0
        exit 1
    else
        if [ -e infinitepony ]
        then
            cp infinitepony /usr/local/bin
            tput setaf 2
            echo "Enjoy ponies with infinitepony command !"
            tput sgr 0
            exit 0
        else
            tput setaf 3
            echo "Missing infinitepony, please clone the entire repository" 1>&2
            tput sgr 0
            exit 1
        fi
    fi
fi
