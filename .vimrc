set t_Co=256

syntax enable
set nocompatible
set number
set ruler
set clipboard=unnamed

colorscheme google

set cursorline

set hidden

set dictionary=/usr/share/dict/words

set tabstop=4
set shiftwidth=4
set smarttab
set pastetoggle=<F2>
set expandtab

set smartindent
set autoindent

set showmatch

set mouse=a

map OH 0
map! OH 0i

map OF $
map! OF $a

:map <C-_> :NERDTreeToggle<CR>

if has("gui_running")
    set guioptions=egmrt
endif

filetype plugin on

let Tlist_Ctags_Cmd='/opt/local/bin/ctags'
let Tlist_WinWidth = 40
let Tlist_Use_Right_Window = 1

set ofu=syntaxcomplete#Complete
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview


au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl 
