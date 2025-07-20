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
# Install packages
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
    clang


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
# Create symlinks to config directories
ln -s $REPO_DIR/* $HOME/.config/

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

