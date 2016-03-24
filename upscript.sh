#!/bin/sh

# the goal of this script is to take a new installation of linux mint and be
# feeling at home in the quickest amount of time possible.

# things to update before running this script:
# 
# 1. under install virtualbox check that the distribution is correct

# TODO add support for vim-latex

# run everything from home
cd

# get sudo access
[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

################################################################################
# INSTALL PROGRAMS                                                             #
################################################################################

### TERMINAL SCIENCE ###

# urxvt for a better terminal
apt-get install rxvt-unicode-256color

# tmux for a better terminal environment
apt-get install tmux

# a better terminal shell
apt-get install zsh

# a better top
apt-get install htop

# mutt for awesome email
apt-get install mutt

# gunpg
apt-get install gnupg

# ag the silver searcher.  like grep/ack but faster
apt-get install silversearcher-ag

# fuzzy find!
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# neovim for an awesome text editor
apt-get install software-properties-common
add-apt-repository ppa:neovim-ppa/unstable
apt-get update
apt-get install neovim

# LaTeX
apt-get install texlive-full


### DEVELOPMENT ###

# python
apt-get install python

# gcc and the like
apt-get install build_essential

# cmake
apt-get install cmake

# ruby
apt-get install ruby

# best version control system ever
apt-get install git

# second best version control system ever...
apt-get install subversion


### WEB DEVELOPMENT ###

# install virtualbox for virtual machines
echo "deb http://download.virtualbox.org/virtualbox/debian trusty contrib" >> \
	/etc/apt/sources.list
apt-get update
apt-get install virtualbox-5.0

# install vagrant for creation of virtual machines for web development
wget https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb
dpkg vagrant_1.8.1_x86_64.deb

# php5
apt-get install php5-cli

# composer
php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
php composer-setup.php --install-dir=bin --filename=composer

# laravel homestead for a snazzy environment to work in
vagrant box add laravel/homestead

### GRAPHICS ###

# gnu image manipulation program (free photoshop!)
apt-get install gimp

# a vector editor
apt-get install inkscape

# a snazzy program for use with a wacom pen
apt-get install mypaint


################################################################################
# CONFIGURATION                                                                #
################################################################################

# left handed!
echo "xmodmap -e \"pointer = 3 2 1\"" >> ~/.Xmodmap

# install oh my zsh!
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# get dot files and link em up
git clone https://www.github.com/jared-skinner/dotfiles ~/dotfiles

# git
ln -sf ~/dotfiles/git/gitconfig ~/.gitconfig

# mutt
ln -sf ~/dotfiles/mutt/muttrc ~/.muttrc

# gpg
ln -sf ~/dotfiles/gnupg/gpg.conf ~/.gpg.conf
ln -sf ~/dotfiles/gnupg/gpg-agent.conf ~/.gpg-agenr.conf

ln -sf ~/dotfiles/tex/ ~/.gitconfig

# tmux
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

ln -sf ~/dotfiles/X/ ~/.gitconfig

# nvim
ln -sf ~/dotfiles/nvim/ ~/.config/nvim/init.vim nvimrc
cp ~/dotfiles/nvim/hm.vim /usr/share/nvim/runtime/colors/
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


# zsh
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc

# create ssh key for local ssh-ing
ssh-keygen -t rsa -C "jaredds66@gmail.com"

# create place to put files laravel projects
mkdir ~/homestead

# homestead (remove old yml file and replace with new)
rm ~/.homestead/Homestead.yaml
ln -sf ~/dotfiles/laravel/Homestead.yaml ~/.homestead/Homestead.yaml
echo "192.168.10.10 homestead.app" >> /etc/hosts
