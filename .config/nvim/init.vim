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
    source ~/.config/nvim/autocmds/fileTypeIndent/python.vim
    source ~/.config/nvim/autocmds/fileTypeIndent/cpp.vim
    source ~/.config/nvim/autocmds/fileTypeIndent/vim.vim
    source ~/.config/nvim/autocmds/fileTypeIndent/toml.vim 
    source ~/.config/nvim/autocmds/fileTypeIndent/yaml.vim 
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
nnoremap <leader>gs :tab sp<CR>:Gstatus<CR>:only<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>gh :tab sp<CR>:0Glog<CR>
" abbrev for `git history`: create new quickfix tab for history
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gf :Gfetch<CR>
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>gr :Grebase -i<CR>
nnoremap <leader>gg :Ggrep 
nnoremap <leader>gm :Gmerge 

"py-docstring
nnoremap <silent> <C-_> <Plug>(pydocstring)

"run isort everytime you close python file
autocmd BufWritePost *.py :!isort %

"Negate bad effects of autopep8
autocmd BufWritePost *.py :%s/@ /@/g   

"open the last cursor position
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
