" James McKeever

" Init {{{
set nocompatible
set noshowmode
set laststatus=2
set modelines=1
set clipboard=unnamed
set autoread

" }}}
" UI {{{
set cursorline
set wildmenu
set lazyredraw
set showmatch					" Show matching brace
" }}}
" Git-Plug {{{
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'fneu/breezy'
Plug 'rhysd/vim-color-spring-night'
Plug 'tpope/vim-fugitive'
Plug 'sjl/gundo.vim'
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'Valloric/YouCompleteMe'
"Plug 'rdnetto/YCM-Generator', {'branch': 'stable'}
Plug 'ternjs/tern_for_vim', {'do': 'npm install'}
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'kana/vim-submode'
Plug 'djoshea/vim-autoread'
Plug 'vim-scripts/a.vim'
Plug 'fidian/hexmode'
Plug 'alvan/vim-closetag'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()
" }}}
" Lightline {{{
let g:lightline = {
      \ 'colorscheme': 'breezy',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightlineModified',
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:h:p') .'/'. expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
" }}}
" CtrlP {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Open in new tab by default
" let g:ctrlp_prompt_mappings = {
    " \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    " \ 'AcceptSelection("t")': ['<cr>'],
    " \ }
" }}}
" YouCompleteMe {{{
"let g:ycm_confirm_extra_conf = 0
let g:ycm_extra_conf_globlist = ['~/Dropbox/*','!~/*']
autocmd CompleteDone * pclose
" }}}
" NERD Commenter {{{
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'
let g:NERDCommentEmptyLines=1

" Toggle line comment <c-/>
imap <c-_> <c-o><leader>c<space>
nmap <c-_> <leader>c<space>
" }}}
" NERDTree/NERDTreeTabs {{{
" Auto start NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '\.swp$', 'venv', 'egg', 'egg-info/', 'docs', 'node_modules', '__pycache__']
let NERDTreeQuitOnOpen=1
let NERDTreeMinimalUI=1
" Shortcuts
map <c-n> :NERDTreeTabsToggle<CR>
nnoremap <leader>v :NERDTreeTabsFind<CR>
" }}}
" Submode {{{
" Timeout
let g:submode_timeout = 0

" Don't consume submode exit key
let g:submode_keep_leaving_key = 1
" }}}
" CloseTag {{{
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue,*.jsx'
let g:closetag_close_shortcut = '<leader>>'
" }}}
" Color Scheme {{{
set background=dark
set termguicolors
syntax enable
colorscheme spring-night
set t_ut=
hi CursorLine cterm=none
" }}}
" Layout {{{
set number
" }}}
" Indentation {{{
set tabstop=4
set softtabstop=0
set shiftwidth=4
set autoindent
set smartindent
set noexpandtab

" Fix python auto set
let g:python_recommended_style=0
" }}}
" Searching {{{
set ignorecase
set incsearch
set hlsearch
" Unhighlight last search '\<space>'
nnoremap <leader><space> :nohlsearch<CR>
" }}}
" Folding {{{
set foldenable
set foldlevelstart=10						" start with most folds open
set foldnestmax=10							" only next up to ten levels
" set foldmethod=indent						" fold based on indentation
set foldmethod=syntax						" fold based on syntax
" space open/closes fold
nnoremap <space> za
" }}}
" Line Shortcuts {{{
" move lines visually
nnoremap j gj
nnoremap k gk
nnoremap B ^
nnoremap E $

" highlight last entered text
nnoremap gV `[v`]
" }}}
" Other Shortcuts {{{
" map 'jk' as esc
inoremap jk <esc>
" toggle paste mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp ~/.vimrc<CR>
nnoremap <leader>eb :vsp ~/.bashrc<CR>
nnoremap <leader>sv :source ~/.vimrc<CR>

" Toggle numbers
nnoremap <leader>n :set number!<CR>

" save session
nnoremap <leader>s :mksession<CR>

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" }}}
" Tabs {{{
nnoremap <C-t> :tabnew<CR>
nnoremap <leader>tm :tabmove<CR>
" nnoremap <leader>n	gt
" nnoremap <leader>p	gT
call submode#enter_with('tabs', 'n', '', 'gn', 'gt')
call submode#enter_with('tabs', 'n', '', 'gp', 'gT')
call submode#map('tabs', 'n', '', 'n', 'gt')
call submode#map('tabs', 'n', '', 'p', 'gT')
" }}}
" Fixes {{{
" allows cursor change
if exists('$TMUX')
	let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
	let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
endif

if $TERM_PROGRAM =~ "iTerm"
	let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Fix backspace
set backspace=indent,eol,start
" }}}
" Autogroup {{{
" set filetype specific settings
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    "autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
    "            \:call <SID>StripTrailingWhitespaces()
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd FileType python setlocal foldmethod=indent
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END
" }}}
" Custom Functions {{{

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
	" save last search & cursor position
	let _s=@/
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	let @/=_s
	call cursor(l, c)
endfunction
" }}}

" vim:foldmethod=marker:foldlevel=0
