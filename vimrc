" vim:fdm=marker

set nocompatible              " be iMproved, required

" Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'rstacruz/sparkup', {'rtp': 'vim/', 'for': 'html' }
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'camelcasemotion'
Plug 'isRuslan/vim-es6'
"Plug 'scrooloose/syntastic'
Plug 'paradigm/vim-multicursor'
Plug 'bkad/camelcasemotion'
Plug 'Lokaltog/vim-easymotion'
Plug 'moll/vim-node'
Plug 'bigfish/vim-js-context-coloring', { 'do': 'npm install --update' }
Plug 'mxw/vim-jsx'
Plug 'tomasr/molokai'
Plug 'marijnh/tern'
Plug 'helino/vim-json', { 'for': 'json' }
Plug 'majutsushi/tagbar'
Plug 'embear/vim-foldsearch'
Plug 'tpope/vim-surround'
Plug 'kien/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'terryma/vim-expand-region'
Plug 'huerotation.vim'
Plug 'fholgado/minibufexpl.vim'
Plug 'KabbAmine/vCoolor.vim'
Plug 'chrisbra/Colorizer'
Plug 'Mark--Karkat'
Plug 'Valloric/MatchTagAlways'
Plug 'kristiandupont/shades-of-teal'

call plug#end()

" NERDTree {{{

" Map F3 to NERDTree
silent! nmap <C-l> :NERDTreeToggle<CR>
"silent! map <F3> :NERDTreeFind<CR>
"let g:NERDTreeMapActivateNode="<F3>"
"let g:NERDTreeMapPreview="<F4>"

let NERDTreeQuitOnOpen = 1
let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize=50

" }}}

" Tagbar {{{

" Map F8 to Tagbar
nmap <F8> :TagbarToggle<CR>

" }}}

" CtrlP {{{
" Use git or silver searcher for autocompletion
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif
" }}}

" Airline {{{

" let g:airline#extensions#tabline#enabled = 1

" }}}

" huerotation {{{

" Yes, this is silly. Use F11 to change colors. Just to get some variation.
noremap <F11> :call RotateHue(10)<cr>
noremap <S-F11> :call RotateHue(-10)<cr>

" }}}

" }}}

:source $HOME/.sharedvimrc


" Detect filetypes
filetype plugin indent on

" Allow hidden, unsaved buffers.
set hidden

" Don't update the display while executing macros
set lazyredraw

set wildignore+=*.swp
set wildignore+=**/.git
set wildignore+=*.DS_Store
set wildignore+=bundle.js
set wildignore+=**/node_modules   " ignores node_modules
set wildignore+=**/tmp/cache      " ignores tmp/cache

" No annoying .swp files, please. I save frequently enough.
set noswapfile

" Clipboard {{{

" Use system clipboard per default
set clipboard+=unnamed  " use the clipboards of vim and OSX
set paste               " Paste from a OSX or from vim

" do not overwrite the default register when changing text
noremap c "_c
noremap cc "_cc
noremap C "_C

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" }}}

" Appearance {{{

syntax on

" 3 lines above and below cursor when scrolling
set scrolloff=3

set showmode
set showcmd

set t_Co=256
set background=dark
colorscheme shades-of-teal
set guifont=DejaVu_Sans_Mono:h13

set relativenumber
set number

set laststatus=2
set statusline=%<%f\ %h%m%r\ %y%=%{v:register}\ %-14.(%l,%c%V%)\ %P

" Open as full-screen as possible.
set lines=999 columns=9999  

" }}}

" Window management {{{

" Move the cursor to the window left of the current one
noremap <silent> gh :wincmd h<cr>

" Move the cursor to the window below the current one
noremap <silent> gj :wincmd j<cr>

" Move the cursor to the window above the current one
noremap <silent> gk :wincmd k<cr>

" Move the cursor to the window right of the current one
noremap <silent> gl :wincmd l<cr>

" Close the window below this one
noremap <silent> gcj :wincmd j<cr>:close<cr>

" Close the window above this one
noremap <silent> gck :wincmd k<cr>:close<cr>

" Close the window to the left of this one
noremap <silent> gch :wincmd h<cr>:close<cr>

" Close the window to the right of this one
noremap <silent> gcl :wincmd l<cr>:close<cr>

" Close the current window
noremap <silent> gcc :close<cr>

" Move the current window to the right of the main Vim window
noremap <silent> gml <C-W>L

" Move the current window to the top of the main Vim window
noremap <silent> gmk <C-W>K

" Move the current window to the left of the main Vim window
noremap <silent> gmh <C-W>H

" Move the current window to the bottom of the main Vim window
noremap <silent> gmj <C-W>J

" Ctrl+K: new tab of current buffer like Code Browser
noremap <C-K> :tab sp<cr>

" Always show the tab bar
set showtabline=2

" Plain old tab switching
nnoremap <C-Tab> :tabnext<CR>
nnoremap <C-S-Tab> :tabprevious<CR>

" Go to tab by number
noremap <D-1> 1gt
noremap <D-2> 2gt
noremap <D-3> 3gt
noremap <D-4> 4gt
noremap <D-5> 5gt
noremap <D-6> 6gt
noremap <D-7> 7gt
noremap <D-8> 8gt
noremap <D-9> 9gt
noremap <D-0> :tablast<cr>

" Switch buffer
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

nnoremap <F5> :buffers<CR>:buffer<Space>

" }}}

set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase characters
set incsearch           " incremental search

set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab       " Expand TABs to spaces

noremap § ^   " Use shift-$ to go to beginning of line

"make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

noremap <C-up> <C-Y>
noremap <C-down> <C-E>

set guioptions-=T   " Hide toolbar
set guioptions-=L   " Hide left-hand scrollbar (NERDTree)

" Use Space as leader 
" (from http://www.reddit.com/r/vim/comments/1vdrxg/space_is_a_big_key_what_do_you_map_it_to/cerq68d)
map <Space> <leader>

" Make it easy to edit this file (mnemonic for the key sequence is 'e'dit 'v'imrc)
nmap <silent> ,ev :e $MYVIMRC<cr>

" Make it easy to edit the shared file (mnemonic for the key sequence is 'e'dit 's'hared)
nmap <silent> ,es :e $HOME/.sharedvimrc<cr>

" And to source this file as well (mnemonic for the key sequence is 's'ource 'v'imrc)
nmap <silent> ,sv :so $MYVIMRC<cr>
