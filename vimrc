" This is a vim rc file ment for a *nix system.  It has the following
" requirements:
"
" 	1. 	the molokai theme for in terminal
" 		https://github.com/tomasr/molokai

"" 	1. 	custom hybrid material theme for gvim
" 		https://github.com/tomasr/molokai
"
" 	2.  the DejaVu Sans Mono for Powerline font
"		https://github.com/powerline/fonts
"
" 	3. 	Vundle package manager
" 		https://github.com/VundleVim/Vundle.vim
"
" 	4. 	Ag (a.k.a. the silver sercher)
" 		https://github.com/ggreer/the_silver_searcher

" UI Config {{{
set modelines=1					" check end of file for folding instructions
set encoding=utf-8				" self explainitory
set number						" this sets line numbers
set showcmd						" we probably won't need this
set cursorline					" highlight current line
set wildmenu					" visual auto complete for command menu
set wildmode=list:longest		" When more than one match, list all matchas and complete till longest common string
set lazyredraw					" redraw only when we need to.
set showmatch					" when passing over a bracket, briefly jump to matching bracket.
set guioptions-=T				" remove toolbar
set guioptions-=m				" remove menu bar
set guioptions-=r				" remove right scrollbar
set guioptions-=L				" remove left scrollbar
set ruler						" keep trak for row/column
set titlestring=%{getcwd()}		" set the window title to the PWD
set nocompatible				" be iMproved, required
set hidden						" buffers remain in memory when switching to a different one
set history=10000				" : command line history
set wrap linebreak nolist		" set wrap options for when wrap is toggled
set wrap!						" default to no word wrap
set hlsearch					" highlight words when searching (turn this off with return)
set autoread					
set list						
set listchars=tab:▶\ ,eol:¬		"show tabs and eol as characters
set tabstop=4					" number of visual spaces per TAB
set softtabstop=4				" number of spaces in tab when editing
set shiftwidth=4				" this is for justification using > and <

filetype indent on				" load filetype-specific indent files
filetype off					" required

" return turns off search highlighting
nnoremap <CR> :nohlsearch<CR>

au FocusLost * silent! wa		" save all windows on lose focus
" }}}
" Folding {{{
set foldenable			" enable folding
set foldlevelstart=10	" start folding then we are 10 blocks deep
set foldnestmax=10		" 10 nested fold max
set foldmethod=syntax	" fold based on indent level

nnoremap <space> za		" space open/closes folds
" }}}
" Remaps {{{
" navigate between buffers using tab and shift+tab
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" move vertically by visual line 
nnoremap j gj
nnoremap k gk

" highlight last inserted text
nnoremap gV `[v`]

" use jk for exiting insert mode
inoremap jk <esc>

" }}}
" Leader Shortcuts {{{
" leader is comma
let mapleader=","

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" edit vimrc
nnoremap <leader>ev :vsp $MYVIMRC<CR>

" edit zshrc
nnoremap <leader>ez :vsp ~/.zshrc<CR>

" reload vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" save session
nnoremap <leader>s :mksession<CR>

" open ag.vim
nnoremap <leader>a :Ag 

" next tab
nnoremap <leader><TAB> :tabnext<CR>

" previous tab
nnoremap <leader><S-TAB> :tabprevious<CR> 

" new tab using current buffer
nnoremap <leader>n :tabe %<CR>

" close tab
nnoremap <leader>c :tabclose<CR>

" toggle wrap
nnoremap <leader>w :set wrap!<CR>
" }}}
" plugins {{{

set rtp+=~/.vim/bundle/Vundle.vim/
let path='~/.vim/bundle/'

call vundle#begin(path)
	Plugin 'kien/ctrlp.vim'				" fuzzy find on files
	Plugin 'ervandew/supertab'			" better tab completion
	Plugin 'bling/vim-airline'			" cool window decoration
	Plugin 'tpope/vim-fugitive'			" git wrapper for fim
	Plugin 'airblade/vim-gitgutter'		" self explainatory
	Plugin 'scrooloose/syntastic'		" syntax checking magic
	Plugin 'rking/ag.vim'				" better global search
	Plugin 'sjl/gundo.vim'				" tree undo history
	Plugin 'moll/vim-bbye'				" close buffers without messing with window layout
	Plugin 'tpope/vim-commentary'		" hotkeys for commenting stuff out
	Plugin 'justinmk/vim-syntax-extra'	" more syntax highlighting
	Plugin 'kshenoy/vim-signature'		" show marks
	"Plugin 'hdima/python-syntax'		" self explainatory
	"Plugin 'vim-scripts/autotags'		" autoupdate your ctags files
call vundle#end()

" }}}
" Git Gutter {{{

highlight SignColumn guibg=#073642
highlight GitGutterAdd guibg=#073642
highlight GitGutterChange guibg=#073642
highlight GitGutterDelete guibg=#073642
highlight GitGutterChangeDelete guibg=#073642

" }}}
" CtrlP Settings {{{

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
map <C-p> :CtrlP<CR>

" }}}
" Syntastic Settings {{{

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" }}}
" Backups {{{

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

"}}}
" Custom Functions {{{

au FocusLost * silent! wa

"}}}
" Custom Functions {{{
" Go away and Come back.  This script auto saves session info and loads it.

" Creates a session
function! MakeSession()
	let a:cwd_string = getcwd()
	let a:cwd_string = substitute(a:cwd_string, ':', '', 'g') 
	let a:cwd_string = substitute(a:cwd_string, '/', '_', 'g')
	let a:cwd_string = substitute(a:cwd_string, ' ', '_', 'g')
	let a:cwd_string = substitute(a:cwd_string, '\', '_', 'g')

	let b:sessiondir = "C:/Program\ Files\ (x86)/vim/sessions/" . a:cwd_string
	if (filewritable(b:sessiondir) != 2)
		exe 'silent !mkdir -p ' b:sessiondir
		redraw!
	endif
	let b:sessionfile = b:sessiondir . '_session.vim'
	exe "mksession! " . b:sessionfile
endfunction

" Updates a session, BUT ONLY IF IT ALREADY EXISTS
function! UpdateSession()
	if argc()==0
		let a:cwd_string = getcwd()
		let a:cwd_string = substitute(a:cwd_string, ':', '', 'g') 
		let a:cwd_string = substitute(a:cwd_string, '/', '_', 'g')
		let a:cwd_string = substitute(a:cwd_string, ' ', '_', 'g')
		let a:cwd_string = substitute(a:cwd_string, '\', '_', 'g')

		let b:sessiondir = "C:/Program\ Files\ (x86)/vim/sessions/" . a:cwd_string
		let b:sessionfile = b:sessiondir . "_session.vim"
		if (filereadable(b:sessionfile))
			exe "mksession! " . b:sessionfile
			echo "updating session"
		endif
	endif
endfunction

" Loads a session if it exists
function! LoadSession()
	if argc() == 0
		let a:cwd_string = getcwd()
		let a:cwd_string = substitute(a:cwd_string, ':', '', 'g') 
		let a:cwd_string = substitute(a:cwd_string, '/', '_', 'g')
		let a:cwd_string = substitute(a:cwd_string, ' ', '_', 'g')
		let a:cwd_string = substitute(a:cwd_string, '\', '_', 'g')

		let b:sessiondir = "C:/Program\ Files\ (x86)/vim/sessions/" . a:cwd_string
		let b:sessionfile = b:sessiondir . "_session.vim"
		if (filereadable(b:sessionfile))
			exe 'source ' b:sessionfile
		else
			echo "No session loaded."
		endif
	else
		let b:sessionfile = ""
		let b:sessiondir = ""
	endif
endfunction

au VimEnter * nested :call LoadSession()
au VimLeave * :call UpdateSession()
map <leader>m :call MakeSession()<CR>
"}}}
" Appearance {{{ 
if has("gui_running")
	set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 8" a pretty font for gui
	colorscheme hybrid_material
	set colorcolumn=81 " a ruler to make off the 80th column
	hi ColorColumn guibg=#1a1a1a
	hi CursorLine guibg=#303030
else
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
	colorscheme molokai
endif

syntax enable "enable syntax processing
" }}}
" Airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
let g:airline_theme='tomorrow'

set laststatus=2 " for air line so the status bar at the bottom always displays
" }}}

" vim:foldmethod=marker:foldlevel=0
