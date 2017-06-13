" vim:fdm=marker

set nocompatible              " be iMproved, required
set encoding=utf-8

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
Plug 'KabbAmine/vCoolor.vim'
Plug 'chrisbra/Colorizer'
Plug 'Mark--Karkat'
"Plug 'Valloric/MatchTagAlways'
Plug 'kristiandupont/shades-of-teal'
Plug 'tpope/vim-abolish'
Plug 'rizzatti/dash.vim'
Plug 'leafgarland/typescript-vim'
Plug 'lukaszkorecki/workflowish'

call plug#end()

" NERDTree {{{

let NERDTreeQuitOnOpen = 1
let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize=80

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

" }}}

" General {{{

" This file contains settings shared between vsvim and vim.
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

" }}}

" Appearance {{{

syntax on

set showcmd
set showmode

" Always show the tab bar
set showtabline=2

" Hide toolbar
set guioptions-=T   

" Hide left-hand scrollbar (NERDTree)
set guioptions-=L   

" Colors
set t_Co=256
set background=dark
colorscheme shades-of-teal
set guifont=DejaVu_Sans_Mono:h11 " Smaller font is set on Windows. See the Platform normalization section below.

set relativenumber
set number

set laststatus=2
set statusline=%<%f\ %h%m%r\ %y%=%{v:register}\ %-14.(%l,%c%V%)\ %P

" }}}

" Platform normalization {{{

if has("win32")
  "Windows options here

  " Use shift-$ to go to beginning of line
  noremap § ^

  " Ctrl-V is paste
  map <C-V>		"+gP
  cmap <C-V>		<C-R>+

  " Use CTRL-S for saving, also in Insert mode
  noremap <C-S>		:update<CR>
  vnoremap <C-S>		<C-C>:update<CR>
  inoremap <C-S>		<C-O>:update<CR>

  " CTRL-F4 is Close window
  noremap <C-F4> <C-W>c
  inoremap <C-F4> <C-O><C-W>c
  cnoremap <C-F4> <C-C><C-W>c
  onoremap <C-F4> <C-C><C-W>c

  nnoremap <A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
  nnoremap <A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>
  nnoremap <A-S-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
  nnoremap <A-S-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>

  " Set a smaller font on Windows..
  set guifont=DejaVu_Sans_Mono:h9

else
  if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
      " Mac options here

      " Allow ctrl-alt-* combos by treating alt as meta
      "set macmeta

      " Use shift-$ to go to beginning of line
      noremap § ^

      nnoremap ‹ :set paste<CR>m`o<Esc>``:set nopaste<CR>
      nnoremap ∆ :set paste<CR>m`O<Esc>``:set nopaste<CR>
      nnoremap › m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
      nnoremap ˝ m`:silent -g/\m^\s*$/d<CR>``:noh<CR>

    endif
  endif
endif

 " }}}

" vimrc editing and sourcing {{{

" Make it easy to edit this file (mnemonic for the key sequence is 'e'dit 'v'imrc)
nmap <silent> <leader>ev :e $MYVIMRC<cr>

" Make it easy to edit the shared file (mnemonic for the key sequence is 'e'dit 's'hared)
nmap <silent> <leader>es :e $HOME/.sharedvimrc<cr>

" And to source this file as well (mnemonic for the key sequence is 's'ource 'v'imrc)
nmap <silent> <leader>sv :so $MYVIMRC<cr>

" }}}

" Key normalization with other editors {{{

" Clipboard {{{

set paste               " Paste from a OSX or from vim

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

" crtl+up/down scrolls screen like in other editors
noremap <C-up> <C-Y>
noremap <C-down> <C-E>

" Map ctrl+backspace to delete previous word in insert mode
imap <C-BS> <C-W>

" Plain old tab switching
nnoremap <C-Tab> :tabnext<CR>
nnoremap <C-S-Tab> :tabprevious<CR>

inoremap <C-Tab> <C-O>:tabnext<CR>
inoremap <C-S-Tab> <C-O>:tabprevious<CR>

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

" }}}

" Misc key bindings

" Type jk or kj to exit insert mode instead of pressing escape 
inoremap jk <esc>
inoremap kj <esc>

" Map F8 to Tagbar
nmap <F8> :TagbarToggle<CR>

" Change hue with F11 and Shift F11
noremap <F11> :call RotateHue(10)<cr>
noremap <S-F11> :call RotateHue(-10)<cr>

" Map <leader> d to look up work under cursor.
:nmap <silent> <leader>d <Plug>DashSearch

" Map F3 to NERDTree
silent! map <S-l> :NERDTreeToggle<CR>
silent! nmap <C-l> :NERDTreeFind<CR>

" Move to windows with space + h/j/k/l {{{
noremap <silent> <leader>h :wincmd h<cr>
noremap <silent> <leader>j :wincmd j<cr>
noremap <silent> <leader>k :wincmd k<cr>
noremap <silent> <leader>l :wincmd l<cr>
" }}}

" Close windows with g + c + h/j/k/l {{{
noremap <silent> gcj :wincmd j<cr>:close<cr>
noremap <silent> gck :wincmd k<cr>:close<cr>
noremap <silent> gch :wincmd h<cr>:close<cr>
noremap <silent> gcl :wincmd l<cr>:close<cr>
" }}}

" Close the current window
noremap <silent> gcc :close<cr>

" Ctrl+K: new tab of current buffer like Code Browser
noremap <C-K> :tab sp<cr>

" Switch buffer
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

nnoremap <F5> :buffers<CR>:buffer<Space>

