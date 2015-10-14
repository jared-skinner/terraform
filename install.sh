#install yaourt
mkdir ~/Builds
cd ~/Builds
wget https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
tar -xzvf yaourt.tar.gz
cd yaourt

#install stuff!
pacman -S mutt							#terminal email client
pacman -S vim							#text editor
pacman -S tmux							#terminal multiplexer
pacman -S sudo							#temporarily grant admin privilages
yaourt extra/msmtp						#email client
yaourt core/ca-certificates				#certificates
yaourt local/thinkpad-scripts			#thinkpad scripts
yaourt extra/keychain					#password management
yaourt extra/xclip						#graphical clipboard
yaourt community/pass					#password management?
yaourt community/pwgen					#password generation
yaourt extra/tree						#cool way of displaying directory structure
yaourt community/the_silver_searcher	#like awk but better and faster
yaourt extra/evince						#my pdf reader of choice
yaourt extra/gimp						#Gnu Image Manipulation Program
yaourt extra/inkscape					#vector editor

#symlink files!
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/vim/vimrc ~/.vimrc
ln -sf ~/dotfiles/git/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/X/Xdefaults ~/.Xdefaults
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
ln -sf ~/dotfiles/mutt/.muttrc ~/.muttrc
