execute pathogen#infect('/Users/andrewcato/.dotfiles/vim/bundle/{}')

syntax enable
filetype plugin indent on

set colorcolumn=120
set number
set wrap
set linebreak
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent
set showmatch

set guifont=Operator\ Mono\ Lig:h14

let NERDTreeShowHidden=1
set noshowmode

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

let mapleader=" "
map <Leader>s :source ~/.vimrc<CR>
nnoremap <Leader><Leader> :e#<CR>
nnoremap <Leader>r :CommandTFlush<CR>
nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>j :NERDTreeFind<CR>

let NERDTreeMapActivateNode='<right>'
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp']

let g:airline_theme='dark'
let g:airline#extensions#tabline#enabled = 1

set hidden
set history=100

autocmd BufWritePre * :%s/\s\+$//e
