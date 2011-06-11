set t_Co=256

let Tlist_Ctags_Cmd='/opt/local/bin/ctags'
let Tlist_WinWidth = 40
let Tlist_Use_Right_Window = 1


filetype indent on
filetype on

colorscheme jellybeans

syntax enable
set nocompatible
set number
set ruler

" Highlight current line
if v:version > 700
    set cursorline
endif

" Enable changing between buffers without saving.
" Makes working with multiple files reasonable
set hidden

" Completion
set dictionary=/usr/share/dict/words

filetype plugin on 
let g:pydiction_location = '~/.vim/pydiction/complete-dict' 


" By default, go for an indent of 4 tab stuff
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set pastetoggle=<F2>

" Dont change input methods when chaning input mode
"set imd

" Highlight matching parens
set showmatch


"
" Aliases
"
au VimEnter * if exists("loaded_cmdalias") |
    \      call CmdAlias("fad",   "FencAutoDetect") |
\ endif
   

set noerrorbells
set visualbell t_vb=
if has("autocmd")
    autocmd GUIEnter * set visualbell t_vb=
endif



"
" Mouse support
"
if has("mouse")
    set mouse=a
endif

" tab navigation like firefox
:nmap <F5> :tabprevious<CR>
:nmap <F6> :tabnext<CR>
:map <F5> :tabprevious<CR>
:map <F6> :tabnext<CR>
:imap <F5> <Esc>:tabprevious<CR>i
:imap <F6> <Esc>:tabnext<CR>i
":nmap <C-w> :tabclose<CR>
":imap <C-w> <Esc>:tabclose<CR>
:map <C-_> :NERDTreeToggle<CR>
:map <C-t> :TlistToggle<CR>

if bufwinnr(1)
  map = <C-W>+
  map - <C-W>-
  map _ <C-W><
  map + <C-W>>
endif
