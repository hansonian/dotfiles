set nocompatible
filetype off

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimfiler.vim'
Plugin 'mattn/emmet-vim'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/zencoding-vim'
Plugin 'scrooloose/syntastic'
Plugin 'qpkorr/vim-bufkill'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vividchalk'
Plugin 'tpope/vim-commentary'
Plugin 'guns/xterm-color-table.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Rykka/colorv.vim'

call vundle#end()            " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin inunite
"
"  Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

if v:progname =~? "evim"
  finish
endif

:let mapleader = ","

" Character encoding
set termencoding=utf-8
set encoding=utf-8
set fileencodings^=utf-8

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set modelines=0
"filetype plugin on
"filetype indent on
syntax enable

" Don't redraw while executing macros (good performance config)
set lazyredraw

" allow backspacing over everything in insert mode
set backspace=eol,start,indent

if has("vms")
	set nobackup          " do not keep a backup file, use versions instead
else
	set backup            " keep a backup file
	set noswapfile
	set backupdir=~/vimbu
	set directory=~/vimbu
endif

set virtualedit=block
set visualbell t_vb=
set history=500         " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set showmode            " display the mode we're in
set incsearch           " do incremental searching
set ignorecase
set smartcase
set nojoinspaces
set numberwidth=1
set ttyfast
set whichwrap+=h,l
set display=lastline

" Use enhanced command line completion
"	set wildmode=longest:full,full
set wildmode=longest,list,full
set wildignore=.*~,*.pyc
set wildmenu
set so=7

colorscheme hansonian

" Run the entire file through the indent filter
noremap <silent> <Leader>= :call Preserve("normal gg=G")<CR>

" Change the CWD to where the current file is located
noremap <silent> <Leader>cd :cd %:p:h<CR>

" Remove trailing whitespace
noremap <silent> <Leader>rtw :call Preserve("%s/\\s\\+$//e")<CR>

" Save typing when doing a global search/replace
noremap <Leader>sr :%s//g<Left><Left>

" Don't use Ex mode, use Q for formatting
:nnoremap Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=r
" set paste

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax enable
  set hlsearch
endif

" Press space to clear search highlighting and any message already displayed.
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>

" personal settings {{{
set number
set ruler
set shiftwidth=2
"set tabstop=2
set ts=2
set terse
set nowrapscan
" set autowrite
set hidden
set confirm
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
:nmap <Leader>s :source $MYVIMRC
:nmap <Leader>v :e $MYVIMRC 
" }}}

augroup filetype_vim
	au!
	au FileType vim setlocal foldmethod=marker
	au FileType vim setlocal nofoldenable 
augroup END

" autocmd settings {{{
" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  " For all text files set 'textwidth' to 78 characters.
	" :autocmd FileType text set textwidth=78
	:autocmd FileType email set textwidth=78
	:autocmd FileType bf set foldmethod=marker
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
	augroup filetype_web
		autocmd!
		:autocmd FileType javascript,json,php,ruby,yaml setlocal et sts=2 sw=2 ts=2		
		:autocmd FileType javascript :iabbrev <buffer> iff if ( ) {}<esc>2ba
		:autocmd FileType php :iabbrev <buffer> iff if () {}<esc>2ba
		":autocmd FileType php,html :iabbrev <buffer> ---- &#8212;
		":autocmd FileType php,html :iabbrev <buffer> --- &#8211;
		":autocmd FileType php,html :iabbrev <buffer> lqq &#8220;
		":autocmd FileType php,html :iabbrev <buffer> rqq &#8221;
		:autocmd BufRead,BufNewFile *.{php,ini} setfiletype php
		:autocmd FileType python setlocal et tw=79 sts=4 sw=4 ts=8 ai
		" folding settings
		:autocmd FileType php,html setlocal foldmethod=indent 
		:autocmd FileType php,html setlocal foldnestmax=10    
		:autocmd FileType php,html setlocal nofoldenable      
		:autocmd FileType php,html setlocal foldlevel=1       
		:autocmd FileType css setlocal foldmethod=marker 
		:autocmd FileType css setlocal foldnestmax=10    
		:autocmd FileType css setlocal foldenable      
		:autocmd FileType css setlocal foldlevel=1       
	augroup END
		:au! BufRead,BufNewFile *.sass	setfiletype sass 
		:au! BufRead,BufNewFile *.scss	setfiletype sass 
		:au! BufRead,BufNewFile *.styl	setfiletype stylus 
		:au! BufRead,BufNewFile *.eco	setfiletype html 
		":au! FileType stylus,sass,html setlocal et sts=2 sw=2 ts=2		
		:au! FileType stylus,sass,html setlocal softtabstop=2 shiftwidth=2 tabstop=2 expandtab
		autocmd BufRead pwds.{txt} set foldmethod=indent
		:autocmd BufRead pwds.{txt} set nonu
		:autocmd BufRead ledger.{dat} set foldmethod=indent
		:autocmd BufRead ledger.{dat} set nonu
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")
" }}}

" mapping {{{
" :inoremap jj <esc>
" :inoremap <esc> <nop>
"no arrow keys so we will learn vim!
:inoremap  <Up>     <nop>
:inoremap  <Down>   <nop>
:inoremap  <Left>   <nop>
:inoremap  <Right>  <nop>
:nnoremap   <Up>     <nop>
:nnoremap   <Down>   <nop>
:nnoremap   <Left>   <nop>
:nnoremap   <Right>  <nop>
" add a timestamp to the beginning/end of the line in both modes
:inoremap		<leader>ll	<esc>I<C-R>=strftime('%Y-%m-%d %H:%M: ')<CR><esc> A
:nnoremap		<leader>ll	<esc>I<C-R>=strftime('%Y-%m-%d %H:%M: ')<CR><esc>$
:inoremap		<leader>kk	<esc>A <C-R>=strftime(' %Y-%m-%d %H:%M')<CR><esc>kJA
:nnoremap		<leader>kk	<esc>A <C-R>=strftime(' %Y-%m-%d %H:%M')<CR><esc>kJ
" :nnoremap		<leader>sf O/* {{{ */<esc>2hi
" :nnoremap		<leader>ef o/* }}} */<esc>
" upper case word in insert mode - <esc> is remapped to JK
:imap <c-u> <esc>bviw~A
" edit .vimrc 
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>
" quote word under cursor
:nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
" }}}

" abbreviations {{{
:abbr adn and
:abbr teh the
" }}}

" Mutt stuff:
" Sven's wondeful change subject macro
map ,cs 1G/^Subject: <CR>yypIX-Old-<ESC>-W

" spelling {{{
set spell
set spell spelllang=en_us
set spellfile=~/.vim/spellfile.add
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 
highlight SpellBad term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline
set dictionary+=/usr/share/dict/words
" }}}

" set wrapmargin=12
set clipboard+=unnamedplus
set laststatus=1

let g:openssl_backup=1 

"let g:user_zen_settings={'php':{'extends':'html','filters':'c'}}
"let g:user_zen_settings={'php':{'extends':'html'},'sass':{'extends':'css'},'scss':{'extends':'css'}}
let g:user_emmet_settings={'php':{'extends':'html'},'sass':{'extends':'css'},'scss':{'extends':'css'}}

nnoremap <F5> :GundoToggle<CR>
let g:gundo_preview_bottom=1
" this is for testing dropbox

" UNITE.vim

" Unite.vim map like ctrlp
nnoremap <C-p> :Unite file_rec/async<cr>
" Unite.vim map like grep
let g:unite_source_grep_command="grep"
nnoremap <space>/ :Unite grep:.<cr>
" history yanking
let g:unite_source_history_yank_enable = 1
nnoremap <space>y :Unite history/yank<cr>
" buffer switcher
nnoremap <space>s :Unite -quick-match buffer<cr>

" VimFiler :
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_as_default_explorer = 1
set fillchars=vert:│,fold:─
let g:vimfiler_tree_leaf_icon = "⋮"
let g:vimfiler_tree_opened_icon = "▼"
let g:vimfiler_tree_closed_icon = "▷"
let g:vimfiler_ignore_pattern = '^\%(.git\|.swp\|.DS_Store\)$'
let g:vimfiler_quick_look_command = 'gloobus-preview'
"nnoremap <F6> :VimFilerCurrentDir<CR>
nnoremap <F7> :VimFilerExplore<CR>

silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" use tmux rather than screen
let g:ScreenImpl = 'Tmux'

" Formats the statusline
set statusline=%f                           " file name
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%y      "filetype
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag

" Puts in the current git status
"    if count(g:pathogen_disabled, 'Fugitive') < 1   
"        set statusline+=%{fugitive#statusline()}
"    endif

" Puts in syntastic warnings
"    if count(g:pathogen_disabled, 'Syntastic') < 1  
        "set statusline+=%#warningmsg#
        "set statusline+=%{SyntasticStatuslineFlag()}
        "set statusline+=%*
"    endif

set statusline+=\ %=                        " align left
set statusline+=Line:%l/%L[%p%%]            " line X of Y [percent of file]
set statusline+=\ Col:%c                    " current column
set statusline+=\ Buf:%n                    " Buffer number
set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor

" syntastic settings, or see: https://github.com/scrooloose/syntastic
"set statusline+=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

let g:syntastic_enable_php_checker = 1
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_php_checkers = ['php']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_tidy_exec = '/home/jim/bin/tidy-html5/bin/tidy'

set omnifunc=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"autocmd FileType c set omnifunc=ccomplete#Complete

" HELPER FUNCTIONS:
"
" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
	  return 'PASTE MODE  '
  en
  return ''
endfunction

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
