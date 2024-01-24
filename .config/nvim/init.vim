" dein settings(plugin manager)
let s:dein_dir = expand('~/.cache/dein')
"dein original
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

"if there is not dein, install it
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

"start setting
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  "prepare roml files. toml files hold plugins
  let g:rc_dir    = expand('~/.config/nvim')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  "load toml and cache
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  "end installing
  call dein#end()
  call dein#save_state()
endif

"if there are plugins that have not installed yet, install them
if dein#check_install()
  call dein#install()
endif

"character code settings
set encoding=utf-8
scriptencoding utf-8

set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double

"tab and indent settings
set expandtab
set autoindent
set smartindent

"change the steps of tab
augroup fileTypeIndent
    autocmd!
    source ~/.config/nvim/autocmds/file_type_indent.vim
augroup END

"search settings
set incsearch
set smartcase
set ignorecase
set hlsearch
set wrapscan
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
" automatically escape back slash and question
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

"set searched characters at center
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

"select until the end of the line
vnoremap v $h

"jump to the corresponding pair with tab
nnoremap <Tab> %
vnoremap <Tab> %

"cursor settings
set whichwrap=b,s,h,l,<,>,[,],~
set virtualedit=onemore

"indicator settings
set number
set list "make invisible characters visible
set wrap "wrap long lines
set textwidth=0 "disable auto new lines
set colorcolumn=120 "show a vertical line at the 120th column

"loopback settings
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

"highlight settings
set cursorline 
syntax enable

"brackets settings
set showmatch
source $VIMRUNTIME/macros/matchit.vim

"completement settings
set wildmenu
set wildmode=list:longest
set history=5000
set infercase  "ignore capital and lower when completion
set hidden "hide buffer instead of closing it
set switchbuf=useopen   "open hidden buffer instead of opening a new buffer

"internal file settings
set nobackup
set nowritebackup
set noswapfile

"reflect file changes outside of vim
set autoread

"show writing command in status
set showcmd
set cmdheight=2

"show status line
set laststatus=2

"jump the head or the tail of a line
"ctrl+a or ctrl_e (the same operation as the outside of vim)
inoremap <C-e> <Esc>$a<Esc>a
inoremap <C-a> <Esc>^i<Esc>i
noremap <C-e> <Esc>$a<Esc><right>
noremap <C-a> <Esc>^i<Esc>

"paste settings(fix slides when you paste from a clip board)
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

"enable clipboard
set clipboard=unnamedplus

"enable backspace
set backspace=indent,eol,start

"NERTree settings
nnoremap :tree :NERDTree

" another Esc
inoremap <silent> jj <ESC>

" git settings
" reference (https://woodyzootopia.github.io/2019/04/vim%E3%81%A7git%E3%82%82%E7%88%86%E9%80%9F%E7%B7%A8%E9%9B%86/)
" for fast display of vim-gitgutter
set updatetime=100
" keymaps of vim-fugitive
let mapleader = "\<Space>"
nnoremap <leader>gst :tab :G status<CR>
nnoremap <leader>ga :G add
nnoremap <leader>gc :G commit<CR>
nnoremap <leader>gl :tab :Git log<CR>
nnoremap <leader>glo :tab :Git log --oneline<CR>
nnoremap <leader>gp :G push
nnoremap <leader>gr :G rebase -i
nnoremap <leader>gm :G merge
nnoremap <leader>gd :tab :G diff<CR>

"py-docstring
nnoremap <silent> <C-_> <Plug>(pydocstring)

"run isort everytime you close python file
autocmd BufWritePost *.py :!isort % -m 3 -l 120
autocmd BufWritePost *.py :Black

"open the last cursor position
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif

"settings for terminal mode
"Move to normal mode by esc key
:tnoremap <Esc> <C-\><C-n>
"Open terminal (zsh) at the bottom by :T
command! T split | wincmd j | resize 10 | terminal zsh
"Open terminal with insert mode (by default, open terminal with normal mode)
autocmd TermOpen * startinsert

"存在しないディレクトリを指定してファイルを開いた場合に中間のディレクトリを自動で作成する
augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'))
  
  function! s:auto_mkdir(dir)
    if !isdirectory(a:dir)
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END
