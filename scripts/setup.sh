#!/bin/bash

echo "Setting up Arch Linux"
echo "Updating and installing basic packages"
# Update system and install basic necessities
sudo pacman -Syyu
sudo pacman -S --noconfirm \
    foot \
    git \
    neovim \
    base-devel \
    btop \

echo "Installing yay"
# Install yay if necessary
if ! command -v yay &> /dev/null
then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
fi

echo "Installing necessary packages for the setup"
# Install packages.
#
# This assumes archinstall's Sway desktop profile has already run, so sway
# itself plus swaybg/swayidle/swaylock/grim/slurp/brightnessctl/waybar/
# xorg-xwayland/pavucontrol/foot are deliberately not listed here. What
# archinstall does *not* give you, but this config depends on, is: lxpolkit
# (referenced by `exec lxpolkit` in sway/config), mako + libnotify (nothing
# else starts a notification daemon), and the Bluetooth audio stack below.
#
# PulseAudio itself is chosen during archinstall's audio prompt — pick
# PulseAudio, not PipeWire, since pulse/default.pa is a PulseAudio config.
yay -S --noconfirm \
    tealdeer \
    bluetuith \
    i3status-rust \
    man-db \
    neofetch \
    nodejs \
    openconnect \
    pcmanfm-gtk3 \
    wl-clipboard \
    xdg-desktop-portal-wlr \
    usbutils \
    mako \
    libnotify \
    lxpolkit \
    bluez \
    bluez-utils \
    pulseaudio-bluetooth \
    zathura \
    zathura-pdf-mupdf \
    bash-completion \
    fuzzel \
    imagemagick \
    otf-comicshanns-nerd \
    wlogout \
    nano \
    vim \
    curl \
    xournalpp \
    obsidian \
    typst \
    tinymist \
    pyright \
    texlive-basic \
    texlive-latex \
    texlive-latexrecommended \
    texlive-latexextra \
    texlive-fontsrecommended \
    texlive-fontsextra \
    texlive-mathscience \
    texlive-bibtexextra \
    texlive-langgerman \
    texlive-langenglish \
    zen-browser-bin \
    clang \
    zip \
    unzip \
    cmake \
    gdb \
    texlab


echo "Enabling Bluetooth"
# bluez ships bluetooth.service disabled, so the headset and the i3status
# bluetooth blocks have no daemon to talk to until it's enabled.
sudo systemctl enable --now bluetooth

echo "configuring git"
# git config
git config --global user.email "caspar.schucan@gmail.com"
git config --global user.name "Caspar Schucan"
git config --global core.editor "nvim"

# get directory of script
cd "$(dirname "$0")"
SCRIPT_DIR=$(pwd)

# get directory of the repository
cd ..
REPO_DIR=$(pwd)

echo "Setting up dotfiles"
# Create symlinks to config directories. ~/.config doesn't exist yet on a
# fresh install until something writes to it, and without it ln aborts with
# "target is not a directory" and links nothing.
mkdir -p $HOME/.config
ln -s $REPO_DIR/* $HOME/.config/

# ~/.config/pulse also holds PulseAudio runtime state (cookie, *.tdb databases),
# so it can't be a directory symlink like the others — that would make
# PulseAudio write those files back into this repo. Replace the symlink the
# glob above created with a real directory holding a single-file symlink.
rm -f $HOME/.config/pulse
mkdir -p $HOME/.config/pulse
ln -s $REPO_DIR/pulse/default.pa $HOME/.config/pulse/default.pa

echo "Setting up scripts"
# install command scripts
sudo ln -s $SCRIPT_DIR/bin/* /usr/local/bin/

echo "Setting up neovim"
# install vim-Plug
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install vim plugins
nvim +PlugInstall +qall

echo "Setting up bash"
# place .bashrc in home directory
rm $HOME/.bashrc
BASH_DIR=$REPO_DIR/bash
ln -s $BASH_DIR/.* $HOME/

