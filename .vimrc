set nocompatible

set t_Co=256

let Tlist_Ctags_Cmd='/opt/local/bin/ctags'
let Tlist_WinWidth = 40
let Tlist_Use_Right_Window = 1

"call pathogen#infect()
filetype plugin indent on


filetype indent on
filetype on

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

let python_highlight_all=1


syntax enable
set nocompatible
set number
set ruler


colorscheme jellybeans

if has('gui_running')
	set gfn=Monaco 10
"	colorscheme solarized
"	set background=dark
endif

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
" set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set pastetoggle=<F2>

" Dont change input methods when chaning input mode
"set imd

" Highlight matching parens
set showmatch

set wildmenu
nnoremap ; :

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
:map <C-_> :NERDTreeToggle<CR>
:map <C-t> :TlistToggle<CR>

if bufwinnr(1)
  map = <C-W>+
  map - <C-W>-
  map _ <C-W><
  map + <C-W>>
endif

vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
"imap <C-v> <Esc><C-v>a

"set cc=81
"hi ColorColumn ctermbg=black guibg=#121212

map OH 0
map! OH 0i

map OF $
map! OF $a
imap ` <Esc>

set tw=0
