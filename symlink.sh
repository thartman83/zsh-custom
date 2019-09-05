#!/bin/zsh

# Colors
RED='\033[00;31m'
GREEN='\033[00;32m'
ENDCOLOR='\033[0m'

# Symlink the custom scripts in this folder to the custom zsh location
# Any .zsh file in this folder will be symlinked into $ZSH_CUSTOM

echo -n "Locating custom zsh directory ... "
if [[ -z "$ZSH_CUSTOM" ]]; then
    echo -e "${RED}not found.${ENDCOLOR}"
    echo -e "Please source symlink.sh rather than executing it."
    return 1
else
    echo -e "${GREEN}found${ENDCOLOR}"
fi


for f in *.zsh; do
    if [[ -f "$ZSH_CUSTOM/$f" ]]; then
        if [[ -L "$ZSH_CUSTOM/$f" ]]; then
            echo "Unlinking existing $f file"
            unlink "$ZSH_CUSTOM/$f"
        else
            echo -e "${RED}${f} is already in $ZSH_CUSTOM and is a regular file. Aborting${ENDCOLOR}"
            return 1
        fi
    fi

    echo -n "Linking $f into $ZSH_CUSTOM ... "
    ln -s "$PWD/$f" "$ZSH_CUSTOM/$f"
    echo -e "${GREEN}done${ENDCOLOR}"
done
