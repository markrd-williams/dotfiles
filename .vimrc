""""""""""""""""""""
" General
""""""""""""""""""""
set nu

syntax enable


set path=**

"enables the Wild Menu
set wildmenu

let mapleader = ","
let g:mapleader = ","

nmap <leader>w :w!<cr>

set shell=bash

filetype plugin indent on

""""""""""""""""""""
" Vim UI 
""""""""""""""""""""

"Shows current position
set ruler

"Search ignores case
set ignorecase

"Search with cases smartly
set smartcase

"Highlight search results
set hlsearch

" searches acts like modern searches
set incsearch

set lazyredraw

set showmode

set showmatch
set mat=2

set noerrorbells
set novisualbell
set t_vb=
set tm=500

set nowrap


""""""""""""""""""""
" Layout
""""""""""""""""""""

"sets utf8 as the encoding
set termencoding=utf-8
set encoding=utf8
set lazyredraw

""""""""""""""""""""
" Colors and Fonts  
""""""""""""""""""""

" Sets UNIX as standard filetype
set ffs=unix,dos,mac

"""""""""""""""""""
" Files and backups
"""""""""""""""""""


set noswapfile
set nobackup

"""""""""""""""""""
" Text, Tabs and indents
"""""""""""""""""""

set expandtab             " expand tabs to spaces
set smarttab              " insert tab based on shiftwidth not tabstop
set shiftwidth=2
set shiftround
set tabstop=2
set softtabstop=2

au FileType python sw=4 sts=4 et st

set ai " Auto indent
set si " Smart indent
set wrap " Wrap lines

"""""""""""""""""""
" Visual Mode
"""""""""""""""""""

" Press * or # to search current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>


"""""""""""""""""""
" Moving, tabs, windows, buffers
"""""""""""""""""""

"Map space to search and Ctrl-space to backwards search
map <space> /
map <c-space> ?

map <silent> <leader><cr> :noh<cr>

" Returns to last editing place when reopening file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""
" Arrow keys
""""""""""""""""""

"Map up and down keys to move lines up and down, and unmap all other keys
no <down> ddp 
no <left> <Nop>
no <right> <Nop>
no <up> ddkP
ino <down> <Nop> 
ino <left> <Nop>
ino <up> <Nop>
ino <right> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>"



""""""""""""""""
" Remove trailing whitespice
""""""""""""""""

fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

"""""""""""""""""
" Persistant Undo
"""""""""""""""""

try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry


"""""""""""""""""
" Parenthesis/Brackets
"""""""""""""""""

inoremap <leader>( ()<esc>i
inoremap <leader>[ []<esc>i
inoremap <leader>{ {}<esc>i
inoremap <leader>{<cr> {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i



"""""""""""""""""
" Helper Functions
"""""""""""""""""

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
