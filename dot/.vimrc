runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous 
" options, so any other options should be set AFTER setting 'compatible'.  
" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes
    " work properly when Vim is used inside tmux and GNU screen.
    set t_ut=
endif

set background=dark
let &t_ut=''

" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set incsearch		" Incremental search
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

command Dspace %s/\s\+$//e

set backspace=2
set shell=/usr/bin/mksh
" set number
set relativenumber
set autoindent
set tabstop=8 
set softtabstop=0
set expandtab
set shiftwidth=4 
set smarttab
set nowrap
set tags=.tags

set list
set listchars=eol:¬,tab:--

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins brought to you by Vundle^TM
Bundle 'bfrg/vim-cpp-modern'
Bundle 'junegunn/fzf.vim'
Bundle 'tpope/vim-fireplace'
Bundle 'VundleVim/Vundle.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-commentary'
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'tpope/vim-vinegar'

call vundle#end()
filetype plugin indent on
filetype plugin on

colorscheme default
