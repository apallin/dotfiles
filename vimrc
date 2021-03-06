" Environment
set shell=zsh
set nocompatible
set t_Co=256
" copied from Keith's vimrc, not sure if i need these
set ttyfast    " Set that we have a fast terminal
set lazyredraw " Don't redraw vim in all situations
set autoread   " Watch for file changes and auto update
" Unfuck splits to position cursor on the right / below split. Thank you.
set splitbelow
set splitright

set encoding=utf-8
scriptencoding utf-8
filetype off " required to be set before loading bundles

" Speed up pressing O after Esc. Changes the timeout of terminal escaping
set timeout timeoutlen=1000 ttimeoutlen=100

" Hooking with system clipboard
if has("clipboard") " If the feature is available
  set clipboard=unnamed " copy to the system clipboard
endif

set shortmess=I " I - Disable the startup message

" Write undo tree to a file to resume from next time the file is opened
if has("persistent_undo")
  set undolevels=2000            " The number of undo items to remember
  set undofile                   " Save undo history to files locally
  set undodir=$HOME/.vimundo     " Set the directory of the undofile
  if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
  endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" Color schemes
Plug 'altercation/vim-colors-solarized'
Plug 'ChrisKempson/Tomorrow-Theme', { 'rtp': 'vim/'}

" Code Navigation
Plug 'rking/ag.vim'
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

" autocompletion / snippets
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --gocode-completer' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Vim enhancements
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'ervandew/supertab'
Plug 'tpope/vim-repeat' " Repeat plugin commands with '.'
" sudo write
Plug 'tpope/vim-eunuch'

" Text editing enhancements
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'seletskiy/vim-autosurround'
Plug 'vim-scripts/camelcasemotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/vim-easy-align'
Plug 'davidbeckingsale/writegood.vim'
Plug 'valloric/MatchTagAlways'

" Lang specific bundles
Plug 'vim-ruby/vim-ruby'
Plug 'wting/rust.vim'
Plug 'thoughtbot/vim-rspec'
Plug 'fatih/vim-go'
Plug 'tpope/vim-cucumber'
Plug 'godlygeek/tabular.vim'
Plug 'plasticboy/vim-markdown.vim'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-jdaddy'
Plug 'Keithbsmiley/swift.vim'
Plug 'davidhalter/jedi-vim'
Plug 'saltstack/salt-vim'

" tmux
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM APPEARANCE / BEHAVIOR CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Netrw width
let g:netrw_winsize = 25
" GVim
if has('gui_running')
  set guifont=Inconsolata-g:h14
  set guioptions=egmrt " hide the gui menubar
  set guioptions-=r " ^WAT... gotta fix this shit
endif

" Source the vimrc file after saving it
augroup VIMRC_LIVE_RELOAD
    autocmd!
    autocmd bufwritepost .vimrc source $MYVIMRC
augroup end

set nobackup
set nowritebackup
set noswapfile
" Highlight current line
set cursorline
" syntax
syntax on
filetype plugin indent on
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
" Line numbers
set number
" Mouse scrolling
set mouse=a
" keep more context when scrolling off the end of a buffer
set scrolloff=10
" Airline
set laststatus=2
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
"let g:airline_theme='badwolf'
let g:airline#extensions#branch#enabled = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = '⎇'
let g:airline#extensions#tabline#enabled = 1 "tabline

" Real time search and highlight
set incsearch
set hlsearch
set ignorecase smartcase

" Highlight trailing whitespace only after some chars
"/\S\zs\s\+$

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC TEXT EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indentations
set smartindent
set autoindent
set ts=4 sts=4 sw=4
set expandtab
set smarttab
" lang specific indentations
au BufRead,BufNewFile *.podspec,Podfile set ft=ruby " CocoaPods and Podfiles
au BufRead,BufNewFile *.json set ai filetype=javascript " JSON
au BufRead,BufNewFile *.md set ft=markdown " Markdown
autocmd FileType make setlocal noexpandtab
autocmd FileType ruby,haml,eruby,yaml,sass set ai sw=2 sts=2 et
autocmd FileType html,javascript,python set sw=4 sts=4 et

" Whitespace
set listchars=tab:\▸\ ,trail:·

" Strip trailing spaces on save
autocmd BufWritePre * :%s/\s\+$//e


set list
" Ruler
autocmd FileType python set cc=80
autocmd FileType objc set cc=120
" TODO: see if i can get rid of this or make it smarter
"highlight ColorColumn guibg=Black

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

" Toggle comments
map <silent> <leader>/ :call NERDComment(0,"toggle")<C-m>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Insert a hash rocket with <c-l>
au FileType ruby imap <c-l> <space>=><space>
au FileType go   imap <c-l> <space>:=<space>

" Better navigation for beginning / end of line
nnoremap H ^
nnoremap L $

" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>

" Clear the search buffer when hitting return
function! RemoveHighlights()
  nnoremap <leader>h :nohlsearch<cr>
endfunction
call RemoveHighlights()

" Select all
function! SelectAll()
  nnoremap <leader>a gg\|VG
endfunction
call SelectAll()

" Tagbar toggle (open methods and props list in a sidebar)
map <leader>2 :TagbarToggle<CR>

" When using p, adjust indent to the current line
nmap p ]p

" Turn on spell check
nmap <leader>s :setlocal spell spelllang=en_us<cr>

" Search a given pattern in Dash.app
nmap <silent> <leader>d <Plug>DashSearch

" Open Tig (git log)
nnoremap <leader>l :!tig<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Resolves conflict with ultisnips.
" Navigating thru selections possible via Ctrl+N and Ctrl+P
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" JSON
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! PrettyJson()
    :'<,'>!jsonf -s=false
endfunction
vmap <leader>f :call PrettyJson()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <C-p> :FZF<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-SURROUND
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <leader># Surround a word with #{ruby interpolation}
map <leader># ysiw#
vmap <leader># c#{<C-R>"}<ESC>

" <leader>" Surround a word with "quotes"
map <leader>" ysiw"
vmap <leader>" c"<C-R>""<ESC>

" <leader>' Surround a word with 'single quotes'
map <leader>' ysiw'
vmap <leader>' c'<C-R>"'<ESC>

" <leader>) or <leader>( Surround a word with (parens)
" The difference is in whether a space is put in
map <leader>( ysiw(
map <leader>) ysiw)
vmap <leader>( c( <C-R>" )<ESC>
vmap <leader>) c(<C-R>")<ESC>

" <leader>[ Surround a word with [brackets]
map <leader>] ysiw]
map <leader>[ ysiw[
vmap <leader>[ c[ <C-R>" ]<ESC>
vmap <leader>] c[<C-R>"]<ESC>

" <leader>{ Surround a word with {braces}
map <leader>} ysiw}
map <leader>{ ysiw{
vmap <leader>} c{ <C-R>" }<ESC>
vmap <leader>{ c{<C-R>"}<ESC>

map <leader>` ysiw`

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delimitmate
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let delimitMate_expand_cr = 1
" By default it expands ` as well, nobody wants that in the world
let delimitMate_quotes = "\" '"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INSTANT MARKDOWN
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:instant_markdown_autostart = 0


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FILE EXPLORER
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle Vexplore with Leader-1
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <leader>1 :call ToggleVExplorer()<CR>

" Use tree-mode as default view
let g:netrw_liststyle=3
" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1
" Change directory to the current buffer when opening files.
"set autochdir

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compile and run
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd Filetype ruby   nmap <leader>r :w\|:!ruby %<cr>
autocmd Filetype python nmap <leader>r :w\|:!python %<cr>
autocmd Filetype java   nmap <leader>r :w\|:!javac %<cr> :!java %:r<cr>
autocmd Filetype swift  nmap <leader>r :w\|:!swift %<cr>
autocmd Filetype sh,bash,zsh nmap <leader>r :w\|:!%<cr>

" Golang... I'm shhhpeshial
autocmd FileType go     nmap <leader>r <Plug>(go-run)
autocmd FileType go     nmap <leader>t :w\|:!go test<cr>
autocmd FileType go     nmap <leader>c <Plug>(go-coverage)
" Definition in a split / vertical
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruby - RUNNING TESTS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd Filetype ruby   map <Leader>t :w\|:call RunCurrentSpecFile()<CR>
autocmd Filetype ruby   map <Leader>s :w\|:call RunNearestSpec()<CR>
autocmd Filetype ruby   map <Leader>e :w\|:call RunLastSpec()<CR>
autocmd Filetype ruby   map <Leader>a :w\|:call RunAllSpecs()<CR>

autocmd Filetype cucumber map <leader>t :w\|:!cucumber %<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rust - racer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden
let g:racer_cmd = "$HOME/code/playground/racer/target/release/racer"
let $RUST_SRC_PATH="$HOME/code/playground/racer/src/"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-GO
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_fmt_command = "goimports"
" remove the automatic top bar method info
"let g:go_auto_type_info = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_build_constraints = 1

"Show a list of interfaces which is implemented by the type under your cursor with <leader>s
au FileType go nmap <Leader>i <Plug>(go-implements)

"Show type info for the word under your cursor with <leader>i (useful if you have disabled auto showing type info via g:go_auto_type_info)
au FileType go nmap <Leader>d <Plug>(go-info)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" clang_complete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'
