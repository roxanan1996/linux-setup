#!/bin/bash

# List with basic stuff like vim, cmake, etc
declare -a essentials=(vim-gtk3 git make gcc build-essential coreutils g++ gcc gcc-multilib gdb gdbserver git git-email gnuplot qemu-system tree valgrind gnome-terminal tmux xclip spotify wine lshw dconf-editor dput network-manager-openvpn enigmail mutt sbuild debootstraap schroot ubuntu-dev-tools python3-pip debhelper gawk build-essential devscripts fakeroot libncurses5-dev ccache kernel-wedge makedumpfile xmlto docbook-utils transfig sharutils python3-launchpadlib snapcraft bash-completion fzf exuberant-ctags yara tig software-properties-common rubby-full pulseaudio libpcap-dev hydra gocr paprefs xbindkeys cscope binwalk crunch exiftool gnome-shell-extention-prefs gnome-text-editor gnome-tweaks)

# network packages
declare -a networking=(curl net-tools nmap tcpdump curl wget dirb tshark wireshark transmission traceroute)

# snaps
declare -a snaps=(bitwarden signal-desktop)

for var in ${essentials}; do
	echo "## INSTALL ${var}"
	sudo apt install $var -y
done

for var in ${networking}; do
	echo "## INSTALL ${var}"
	sudo apt install $var -y
done

for var in ${snaps}; do
	echo "## INSTALL ${var}"
	sudo snap install $var
done

# zsh powerline fonts
git clone https://github.com/powerline/fonts ~/fonts
cd ~/fonts && ./install.sh && cd -

# mattermost
curl -o- https://deb.packages.mattermost.com/setup-repo.sh | sudo bash
sudo apt install mattermost-desktop -y
sudo apt upgrade mattermost-desktop -y

# fd-find
sudo apt install fd-find -y
if [! -e ~/.local/bin] do
	mkdir ~/.local/bin
done

ln -s $(which fdfind) ~/.local/bin/fd

# keybindings
if [-e ./gnome3-keybind-backup] do
	./keybind_restore.sh restore
done

# o-my-zsh
sudo apt install zsh
chsh -s $(which zsh)

# install o-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp ./zshrc ~/.zshrc

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Tmux
git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm

# yank plugin will bind y to copy to clipboard
git clone https://github.com/tmux-plugins/tmux-yank ~/.tmux/plugins/yank

# open tmux plugin to open url from terminal
git clone https://github.com/tmux-plugins/tmux-open ~/.tmux/plugins/open

#vim
cp ./vimrc ~/.vimrc

# TODO find a way to close the windows afterwards
vim -c 'PlugInstall'

cp  ./tmux.conf ~/.tmux.conf
