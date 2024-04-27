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

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

set backspace=2
set shell=/bin/zsh

set relativenumber

let ext = expand('%:e')

if ext == "templ" || ext == "go"
    set tabstop=2
    set shiftwidth=8
else
    set tabstop=4
    set shiftwidth=8
endif

set autoindent
set softtabstop=0
set expandtab
set smarttab
set nowrap
set tags=.tags

set list
set listchars=eol:¬,tab:--

set nocompatible
filetype off

call plug#begin()

Plug 'bronson/vim-trailing-whitespace'
Plug 'evanleck/vim-svelte'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf.vim'
Plug 'kien/ctrlp.vim'
Plug 'pangloss/vim-javascript'
Plug 'preservim/nerdtree'
Plug 'prettier/vim-prettier'
Plug 'romgrk/doom-one.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/django.vim'
Plug 'lepture/vim-jinja'
Plug 'mhinz/vim-startify'

call plug#end()
filetype plugin indent on
filetype plugin on

autocmd BufNewFile,BufRead *.django.html :set filetype=htmldjango
autocmd BufNewFile,BufRead *.jinja.html :set filetype=jinja

let g:ctrlp_custom_ignore = '^(\.git|node_modules|\.venv|client\/node_modules)'
let g:ctrlp_show_hidden = 1
let g:NERDTreeShowHidden = 1

fun! FormatCode()
    const ext = expand('%:e')
    if ext == "svelte" || ext == "jsx" || ext == "js"
        echo "Running Prettier..."
        :Prettier
    elseif ext == "go"
        :! go fmt %
    elseif ext == "templ"
        echo "Running templ format"
        :! templ fmt %
    else
        echo "File format not recognized..."
    endif
endfunction

nnoremap <C-f> :call FormatCode()<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-t> :tabnew<CR>

nnoremap <C-g><C-s> :Git status<CR>
nnoremap <C-g><C-m> :Git commit %<CR>
nnoremap <C-g><C-d> :Git diff %<CR>
nnoremap <C-g><C-l> :Git log<CR>
nnoremap <C-g><C-b> :Git blame<CR>

set termguicolors
colorscheme retrobox
