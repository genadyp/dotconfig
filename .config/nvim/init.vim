" => Package Manager {{{
" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs 
        \https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.config/nvim/bundle')

Plug 'KeitaNakamura/neodark.vim'
Plug 'chrisbra/Colorizer'
Plug 'itchyny/lightline.vim'
Plug 'rking/ag.vim'

Plug 'philip-karlsson/bolt.nvim', {'do' : ':UpdateRemotePlugins'}
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}

Plug 'ervandew/supertab', {'on':[]}
Plug 'godlygeek/tabular', {'on':[]}
Plug 'tpope/vim-repeat', {'on': []}
Plug 'tpope/vim-surround', {'on':[]}
Plug 'airblade/vim-rooter', {'on': []}
augroup load_insert_mode_plugins
  autocmd!
  autocmd InsertEnter * call plug#load('supertab', 'tabular', 'vim-repeat', 'vim-surround', 'vim-rooter')
augroup END

Plug 'majutsushi/tagbar', {'on': []}
augroup load_buf_win_enter_plugins
  autocmd!
  autocmd BufWinEnter * call plug#load('tagbar')
augroup END

" Plugins lazy loaded upon filetypes
Plug 'ddollar/nerdcommenter', {'for' : ['c', 'cpp', 'vim', 'python', 'sh', 'cmake']}
Plug 'Raimondi/delimitMate', {'for' : ['c', 'cpp', 'h', 'vim']}
Plug 'rhysd/vim-clang-format', {'for' : ['c', 'cpp', 'h']}
Plug 'Rip-Rip/clang_complete', {'for' : ['c', 'cpp', 'h']}
Plug 'lyuts/vim-rtags', {'for' : ['c', 'cpp', 'h']}
Plug 'zchee/deoplete-jedi', {'for' : ['python']}
Plug 'arakashic/chromatica.nvim', {'for' : ['c', 'cpp', 'h']}

call plug#end()
"}}}
" => General {{{
let s:is_nvim = has('nvim')
let s:is_vim = has('vim')
let s:is_windows = has('win32') || has('win64')
let s:is_unix = has('unix')
let s:is_gui_running = has('gui_running')

let g:loaded_zipplugin = 1
let g:loaded_gzip = 1
let g:loaded_vimballPlugin = 1
let g:loaded_rrhelper = 1
let g:did_install_default_menus = 1

" Enable filetype plugins
if has('autocmd') | filetype plugin on | filetype indent on | endif

" Set language for all propts to English
if s:is_windows | silent exec 'language english' | endif

" Sets how many lines of history VIM has to remember
set history=200

" Set to auto read when a file is changed from the outside
set autoread

set timeoutlen=40 ttimeoutlen=50

" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Redefine the shell redirection operator to receive both the stderr messages and stdout messages
set shellredir=>%s\ 2>&1

" On windows enable shellslash so that all paths are expanded with forward slash
if s:is_windows | set shellslash | endif

" Use Ag over grep. 
if executable('ag') | set grepprg=ag\ --nogroup\ --nocolor | set grepformat=%f:%l:%m | endif

" Set utf8 as standard encoding and en_US as the standard language
if s:is_vim
  if has('multi_byte') | set encoding=utf8 | endif
endif

" Use Unix as the standard file type
set fileformats=unix,dos,mac

" Use system clipboard
if has('clipboard') | set clipboard=unnamedplus | endif

" shortens messages to avoid 'press a key' prompt
set shortmess+=aoOtTI

" enable mouse in normal, visual and insert mode
set mouse=a

" specify model for mouse rightclick
set mousemodel=popup
"}}}
" => VIM user interface {{{
" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" Turn on the WiLd menu
if has('wildmenu') | set wildmenu | endif

" Ignore compiled files
if has('wildignore') | set wildignore=*.o,*~,*.pyc | endif

"Always show current position
set ruler

" don't show VIM mode. Show command.
set noshowmode showcmd cmdheight=1

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

"display tabs and trailing spaces
set list listchars=tab:>-,trail:.,nbsp:.

if has('breakindent') | set breakindent | endif

" Display line number and reserve 4 columns
set number numberwidth=4

" Don't move the cursor to the start of the line on page up/down (ctrl-U/D etc)
set nostartofline

" highlight cursorline and color column
set cursorline colorcolumn=120

" Split always on right
if has('vertsplit') | set splitright | endif

" How many tenths of a second to blink when matching brackets
set mat=500

" Wrap longer lines
set wrap whichwrap+=<,>,h,l

" Linebreak on
if has('linebreak') | set linebreak | endif

" Maximum width of text that is being inserted.  A longer line will be broken after white space to get this width.
set textwidth=120

" Show matching brackets when text indicator is over them
" Below option causes neovim to hang for some reason
if s:is_vim
  set showmatch
endif

" Don't redraw while executing macros (good performance config)
set lazyredraw

" No annoying sound on errors
set noerrorbells novisualbell
set t_vb=
set tm=500

if s:is_gui_running "{{{
  set guioptions-=T
  set guioptions-=e
  set guioptions-=m
  set guioptions-=r
  set guioptions-=L
  set guitablabel=%M\ %t

  " Set window size
  set columns=159 lines=60
  winpos 388 0

  if s:is_unix
    set guifont=Source\ Code\ Pro\ for\ Powerline\ 10
  else
    set guifont=Source_Code_Pro_Medium:h11:cANSI
  endif
endif "}}}
"}}}
" => Code folding {{{
" fold by default. Add a bit extra margin to the left
if has('folding') | set foldenable | set foldcolumn=2 foldlevel=4 foldnestmax=6 | endif
"}}}
" => Searching {{{
" Highlight search results. Makes search act like search in modern browsers. Turn on regular expressions with magic
if has('extra_search') | set ignorecase hlsearch incsearch magic | endif
set inccommand=nosplit
"}}}
" => Autocomplete Settings {{{
" Settings related to autocomplete
set completeopt=menu,menuone

" Number of items displayed in autocomplete popup
set pumheight=20
"}}}
" => Autocommands {{{
if has('autocmd') "{{{
  "folding settings
  if has('folding') "{{{
    augroup vimrc
      autocmd!
      autocmd BufReadPre * setlocal foldmethod=indent
      autocmd BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
      autocmd BufWinEnter * if &ft == 'vim' | setlocal foldmethod=marker | endif
    augroup END
  endif "}}}

  if has('quickfix') "{{{
    augroup qf
      autocmd!
      autocmd FileType qf wincmd K
      autocmd FileType qf call AdjustWindowHeight(3, 20)
    augroup END

    " Quit Vim if quickfix is the last window
    autocmd BufEnter * call MyLastWindow()
  endif "}}}

  " Return to last edit position when opening files (You want this!)
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

  autocmd BufWrite *.c,*.cpp,*.h :call DeleteTrailingWS()
  autocmd BufWritePost .vimrc,vimrc,init.vim :source %

  if s:is_nvim
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
  endif
endif "}}}
"}}}
" => Colors {{{
" Enable syntax highlighting
syntax enable

if s:is_nvim | set termguicolors | endif
if s:is_vim
  if !s:is_gui_running | set termguicolors | endif
endif

" set background=dark
" let g:neodark#background = '#002b36'
colorscheme neodark
"}}}
" => Files, backups and undo {{{
" Turn backup off, since most stuff is in SVN, git etc. anyway
set nobackup nowritebackup noswapfile
"}}}
" => Tabs and indent related {{{
set autoindent cindent
set expandtab smarttab shiftwidth=4 tabstop=4 softtabstop=4
"}}}
" => Visual mode related {{{
" in visual block mode, cursor can be positioned where there is no actual character. 
" Allow cursor beyond last character
set ve=block,onemore
"}}}
" => Include plugin settings {{{
" -> Tagbar plugin {{{
if s:is_windows | let g:tagbar_ctags_bin = '$HOME\vimfiles\ctags\ctags.exe' | endif

let g:tagbar_compact = 1
let g:tagbar_left = 0
let g:tagbar_width = 60
let g:tagbar_indent = 1
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_autofocus = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_show_visibility = 1
"}}}
" -> Supertab plugin {{{
let g:SuperTabClosePreviewOnPopupClose = 1
let g:SuperTabDefaultCompletionType = "<C-x><C-u><C-p>"
let g:SuperTabDefaulyCompletionType='context'
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
"}}}
" -> Ag plugin {{{
if s:is_windows
  let g:ag_prg=expand('$HOME').'\vimfiles\bundle\ag.vim\ag.exe --column --smart-case -w --color-match --ignore-case --all-text -Q'
elseif s:is_unix
  let g:ag_prg='ag --column --smart-case -w --color-match --ignore-case --all-text -Q'
endif
"}}}
" -> clang_complete plugin {{{
"    Wiki: To use clang_complete, I needed LLVM and had dependency
"          on Python and MinGW headers. 
"          Needed ".clang_complete" file need to be at the root of project. 
"
"          Use: "dir /S *.h" > .clang_complete
"          on dos prompt to generate entries in file. File needs manual edit
"          to remove extra stuff to only keep header file paths, one per line
if s:is_windows | let g:clang_library_path='C:\DevEnv\LLVM\bin' | endif

let g:clang_use_library=1
let g:clang_user_options='|| exit 0'
let g:clang_close_preview=1

""behvaior for auto_complete
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_omnicppcomplete_compliance = 0
let g:clang_make_default_keymappings = 0
let g:clang_sort_algo="priority"

"behavior on syntax error
let g:clang_complete_copen=1
let g:clang_hl_errors=1

"enable some snippet support
let g:clang_snippets=1
let g:clang_conceal_snippets=1
let g:clang_snippets_engine='clang_complete'
let g:clang_complete_optional_args_in_snippets=1
let g:clang_auto_user_options="compile_commands.json"
"}}}
" -> Ctags {{{
"    Used below command to generate tags
"    ctags.exe --c++-kinds=+p --fields=+iakftS --file-scope=yes --extra=+q --language-force=C++ -R *
" Look for tags file in current directory and go up the tree
" until one is found
set tags=./tags,tags;
"}}}
" -> Lightline plugin {{{
let g:lightline = {
      \ 'colorscheme': 'neodark',
      \ }
"}}}
" -> Vim-rooter plugin {{{
let g:rooter_silent_chdir = 1
"}}}
" -> Chromatica plugin {{{
let g:chromatica#enable_at_startup=1
" let g:chromatica#highlight_feature_level=1
"}}}
" -> Deoplete plugin {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
"}}}
"}}}
" => Include keymap mappings {{{
" -> Moving around, tabs, windows and buffers {{{
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Smart way to move between buffers
nnoremap <silent> <C-h> :bprevious<cr>
nnoremap <silent> <C-l> :bnext<cr>

" Smart way to move between windows
nnoremap <S-Left> <C-w><Left>
nnoremap <S-Right> <C-w><Right>
nnoremap <S-Up> <C-w><Up>
nnoremap <S-Down> <C-w><Down>
inoremap <S-Left> <esc><C-w><Left>i
inoremap <S-Right> <esc><C-w><Right>i
inoremap <S-Up> <esc><C-w><Up>i
inoremap <S-Down> <esc><C-w><Down>i

" source $MYVIMRC
nnoremap <silent> <leader>ve :edit $MYVIMRC<cr>

" List open buffers
nnoremap <silent> <Leader>b :buffers<cr>:buffer<space>

" Close the current buffer
nnoremap <silent> <leader>k :Bclose<cr>

" Close all other splits
nnoremap <silent> <leader>o :only<cr>

" Close all the buffers
nnoremap <silent> <leader>ba :1,1000 bdelete!<cr>

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
"}}}
" -> Editing mappings {{{
" Go easy on hands, save one keypress to run external command
nnoremap ! :!

" Remap VIM 0 to first non-blank character
map 0 ^

" make Y behave like C and D
nnoremap Y y$

" Some convenience mappings for moving arround in line while in insert mode
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Insert ; at end of line
inoremap <leader>; <C-o>m`<C-o>A;<C-o>``
nnoremap <leader>; m`A;<esc>``

" map $ to something close and unused key
nnoremap ; $
vnoremap ; $

map <silent> <leader>q :quit<CR>

" save current buffer
map <silent> <leader>w :update<CR>

map <leader>e :edit

" Moving lines and selections with Ctrl-J and K
nnoremap <silent> <c-k> :m-2<cr>==
nnoremap <silent> <c-j> :m+<cr>==
inoremap <silent> <c-j> <esc>:m+<cr>==gi
inoremap <silent> <c-k> <esc>:m-2<cr>==gi
vnoremap <silent> <c-j> :m'>+<cr>gv=gv
vnoremap <silent> <c-k> :m-2<cr>gv=gv
"}}}
" -> Search mappings {{{
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
nnoremap <space> /
nnoremap <s-space> ?
nnoremap * #*
"}}}
" -> Code folding mappings {{{
if has('folding')
  nmap <silent> <leader>f0 :set foldlevel=0<CR>
  nmap <silent> <leader>f1 :set foldlevel=1<CR>
  nmap <silent> <leader>f2 :set foldlevel=2<CR>
  nmap <silent> <leader>f3 :set foldlevel=3<CR>

  nnoremap <silent> <leader><Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
endif
"}}}
" -> Term mode mappings {{{
if s:is_nvim
  tnoremap <Esc> <C-\><C-n> 
  nnoremap <C-t> :term<cr>
endif
"}}}
" -> Misc {{{
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Disable highlight when <esc> is pressed
nnoremap <silent> <esc><esc> :noh<cr>

nnoremap <silent> <Leader>strip :g/^$/,/./-j<cr>

nnoremap <silent> <F9> :call ToggleBackground()<cr>

"}}}
" -> Mappings for Tagbar plugin {{{
nnoremap <silent> <F2> :TagbarToggle<cr>
"}}}
" -> Mappings for Ag or Git Grep plugin {{{
map <silent> <F5> :Ag! <cword><cr>
" map <F5> :call GitGrep(expand("<cword>"))<cr>
" }}}
" -> Mappings for clang_complete plugin {{{
nnoremap <silent> <Leader>s :call CheckSyntax()<cr>
" }}}
" -> Mappings for vim-rtags plugin {{{
" let g:rtagsUseDefaultMappings = 1
noremap <M-i> :call rtags#SymbolInfo()<CR>
noremap <M-j> :call rtags#JumpTo(g:SAME_WINDOW)<CR>
noremap <M-J> :call rtags#JumpTo(g:SAME_WINDOW, { '--declaration-only' : '' })<CR>
noremap <M-S> :call rtags#JumpTo(g:H_SPLIT)<CR>
noremap <M-V> :call rtags#JumpTo(g:V_SPLIT)<CR>
noremap <M-T> :call rtags#JumpTo(g:NEW_TAB)<CR>
noremap <M-p> :call rtags#JumpToParent()<CR>
noremap <M-f> :call rtags#FindRefs()<CR>
noremap <M-n> :call rtags#FindRefsByName(input("Pattern? ", "", "customlist,rtags#CompleteSymbols"))<CR>
noremap <M-s> :call rtags#FindSymbols(input("Pattern? ", "", "customlist,rtags#CompleteSymbols"))<CR>
noremap <M-r> :call rtags#ReindexFile()<CR>
noremap <M-l> :call rtags#ProjectList()<CR>
noremap <M-w> :call rtags#RenameSymbolUnderCursor()<CR>
noremap <M-v> :call rtags#FindVirtuals()<CR>
noremap <M-b> :call rtags#JumpBack()<CR>
noremap <M-C> :call rtags#FindSuperClasses()<CR>
noremap <M-c> :call rtags#FindSubClasses()<CR>
noremap <M-d> :call rtags#Diagnostics()<CR>
"}}}
" -> Mappings for vim-clang-format plugin {{{
noremap <Leader>cf :ClangFormat<CR>
"}}}
"-> Mappings for FZF plugin {{{
  nnoremap <C-p> :FZF<cr>
"}}}
" => Status line {{{
if s:is_vim | if has('statusline') | set laststatus=2 | endif | endif
"}}}
" => Helper functions {{{
function! AdjustWindowHeight(minheight, maxheight) "{{{ Adjust quickfix window size
  exe max([min([line("$")+1, a:maxheight]), a:minheight]) . "wincmd _"
endfunction "}}}

function! MyLastWindow() "{{{ Quit vim if quickfix is the last window
  " if the window is quickfix and last window go on
  if &buftype == "quickfix" && winnr('$') < 2
    quit!
  endif
endfunction "}}}

function! DeleteTrailingWS() "{{{ Delete trailing white space on save, useful for Python and CoffeeScript ;)
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc "}}}

function! CmdLine(str) "{{{
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction "}}}

function! VisualSelection(direction) range "{{{
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction "}}}

command! Bclose call <SID>BufcloseCloseIt() "{{{ Don't close window, when deleting a buffer
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  elseif buflisted(l:currentBufNum)
    bnext
  endif

  if bufnr("%") == l:currentBufNum
    new
  endif

  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction "}}}

function! CheckSyntax() "{{{
  if &ft == "c" || &ft == "cpp"
    call g:ClangUpdateQuickFix() | cclose | call FilterQuickFix()
  endif
endfunction "}}}

function! FilterQuickFix() "{{{
  call setqflist(filter(getqflist(), "bufname(v:val['bufnr']) ==? a:pat"))
endfunction "}}}

function! ToggleBackground() "{{{
  if &background == "dark" | set background=light | else | set background=dark | endif
endfunction "}}}

command! -nargs=* G :call GitGrep(<q-args>) "{{{
function! GitGrep(terms)
  cgetexpr system('git grep -n "'.a:terms.'"')
  copen
endfunction "}}}

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap <leader>h :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
   let @/ = ''
   if exists('#auto_highlight')
     au! auto_highlight
     augroup! auto_highlight
     setl updatetime=4000
     echo 'Highlight current word: off'
     return 0
  else
    augroup auto_highlight
    au!
    au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
  return 1
 endif
endfunction
"}}}
