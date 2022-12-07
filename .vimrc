" === BASIC VIM SETTING ===================================================
set showcmd     " Show (partial) command in status line.
set smartcase
set incsearch   " Incremental search
set autowrite   " Automatically save before commands like :next and :make
set hidden      " Hide buffers when they are abandoned
set mouse=a     " Enable mouse usage (all modes)

" Helps force plug-ins to load correctly when it is turned back on below.
filetype on
syntax on
filetype plugin indent on

" Turn off modelines
set modelines=0

set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

" Display 5 lines above/below the cursor when scrolling with a mouse.
set scrolloff=5

" Status bar
set laststatus=2

" Display options
set showmode
set showcmd

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Show line numbers
set number

" Set status line display
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]

" Encoding
set encoding=utf-8

" Use ctrl+C / ctrl+V clipboard
set clipboard=unnamedplus

" Highlight matching search patterns
set hlsearch

" Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100

:set completeopt=longest,menuone

map j gj
map k gk
map <Up> g<Up>
map <Down> g<Down>
