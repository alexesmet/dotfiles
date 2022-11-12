" === BASIC VIM SETTING ===================================================
set showcmd     " Show (partial) command in status line.
set smartcase
set incsearch   " Incremental search
set autowrite   " Automatically save before commands like :next and :make
set hidden      " Hide buffers when they are abandoned
set mouse=a     " Enable mouse usage (all modes)

" Helps force plug-ins to load correctly when it is turned back on below.
filetype off

" Turn on syntax highlighting.
syntax on

" For plug-ins to load correctly.
filetype plugin indent on

" Turn off modelines
set modelines=0

set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

" FILE EXPLORER
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Display 5 lines above/below the cursor when scrolling with a mouse.
set scrolloff=5

" Fixes common backspace problems
set backspace=indent,eol,start

" Speed up scrolling in Vim
set ttyfast

" Status bar
set laststatus=2

" Display options
set showmode
set showcmd

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Display different types of white spaces.
set list
set listchars+=tab:›\ ,extends:#,trail:·

" Show line numbers
set number

" Set status line display
set statusline=%F%m%r%h%w\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]
set statusline=[B%n]\ %<%F%M\ %=\ [.%Y]\ [%l:%v/%L]

" Encoding
set encoding=utf-8

" Use ctrl+C / ctrl+V clipboard
set clipboard=unnamedplus

" Highlight matching search patterns
" set hlsearch

" Store info from no more than 100 files at a time, 9999 lines of text, 
" 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100

set completeopt=longest,menuone
set completeopt=noinsert,menuone,noselect

" Disable that bar on the left
set signcolumn=no

" === RUSSIAN LANGUAGE SUPPORT ============================================
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan


" === SUPPORT MY OWN TIME FORMAT FILES ====================================
au BufRead,BufNewFile *.time set filetype=time

" === KEY REMAPS (VANILLA)=================================================
" Insert a closing bracket if enter was pressed
inoremap {<CR>  {<CR>}<Esc>O
map j gj
map k gk
map <Up> g<Up>
map <Down> g<Down>



" === NEOVIDE UI SETTINGS =================================================
hi Pmenu guibg=grey10
hi! link NonText Ignore    


" === PLUGINS =============================================================
call plug#begin('~/.config/nvim/plugged')

Plug 'rust-lang/rust.vim',          { 'for': 'rust' }
Plug 'neovim/nvim-lspconfig'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" enable ncm2 for all buffers
let g:python3_host_prog='/usr/bin/python3'
autocmd BufEnter * call ncm2#enable_for_buffer()

call plug#end()

" === LSP =================================================================
lua << EOF
local opts = { noremap=true, silent=true }

vim.keymap.set('n', '<F2>', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<S-F2>', vim.diagnostic.goto_next, opts)

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local bufopts = { noremap=true, silent=true, buffer=bufnr }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<a-cr>', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<S-F6>', vim.lsp.buf.rename, bufopts)
end


local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}

EOF

