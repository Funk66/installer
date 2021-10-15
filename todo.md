- fix dnstools
- waybar
- automount drives
- usb - mouse, webcam
- share screen
- headphones mic audio controls
- notifications - mako - pushalert.com/demo
- alacritty url click (not supported)
gestures (see dotfiles rbnis)
- hint dialog floating windows
- bluetooth - bluez, bluez-utils, blueman
- p10k change color, short path kialo
- fix gpg pinentry
dark reader atlassian kialo (minimap)

- put mozilla wayland in zshenv

fix vim vertical pipe

japanese characters

- fix alignment alacritty (black line bottom)
- remember backlight intensity

zsh PATH as variable (archwiki zsh)
- setopt PUSHD_IGNORE_DUPS
- On-demand rehash
Fish-like syntax highlighting and autosuggestions

open calendar: wofi -> firefox, terminal

don't mount boot?
- nautilus? -> configure favorites

archiving

# ideas

export TMPDIR="/tmp/$USER"
if [ ! -d "$TMPDIR" ]; then
    mkdir -m 700 "$TMPDIR"
fi

# Use evince as default document reader.
export READER="evince"
# Use alacritty as default terminal.
export TERMINAL="alacritty"

# Commands for wofi
- ykman code | wl-copy
- connect bluetooth headphones
- 
