set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" This is the Vundle package, which can be found on GitHub.
" For GitHub repos, you specify plugins using the
" 'user/repository' format
Plugin 'gmarik/vundle'

" We could also add repositories with a ".git" extension
Plugin 'scrooloose/nerdtree.git'

" Tag list on the right
Plugin 'taglist.vim'

" Complete tags
Plugin 'OmniCppComplete'

" DelimitMate - auto close parenthesis, quotes, etc
Plugin 'delimitMate.vim'

" Git plugin
Plugin 'fugitive.vim'

"Disable capslock when back to normal mode
Plugin 'suxpert/vimcaps'

" Cscope plugin
Plugin 'chazy/cscope_maps'

" HTML plugin
Plugin 'ragtag.vim'

" Kernel coding style
Plugin 'vivien/vim-addon-linux-coding-style'

" Keep case when replacing with :%S/bla/blu/gc
Plugin 'abolish.vim'

" Now we can turn our filetype functionality back on
filetype plugin indent on

" ---------------------------------------------------------
"  COLOR
" ---------------------------------------------------------
syntax enable         " enable color
syn on se title       " File title
colorscheme ron       " color theeme
"colorscheme evening   " this one's easy =)

" ---------------------------------------------------------
"  IDENTATION
" ---------------------------------------------------------
set autoindent        " indent automatically
"set cindent           " C style of indentation
"set lisp              " lisp indenting
"set expandtab         " expand tab characters to space characters
"set tabstop=4         " tab char display size
"set shiftwidth=4      " indendation shift to the right

" Kernel style
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab

" ---------------------------------------------------------
"  BACKUP
" ---------------------------------------------------------
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/
" set nobackup          " don't create annoying '~' files

" ---------------------------------------------------------
"  OMNICPPCOMPLETE
" ---------------------------------------------------------
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" ---------------------------------------------------------
"  NerdTREE
" ---------------------------------------------------------
let NERDTreeShowBookmarks=1         " Open bookmarks at startup
"autocmd VimEnter * NERDTree         " Open NERDTree at startup

" ---------------------------------------------------------
"  GENERAL CONFIG
" ---------------------------------------------------------
set ttyfast           " inserts more chars and improves redrawing
set number            " show line numbers
set mouse=a           " grabs the mouse focus
                      " to disable, type ':set mouse=' (yep, equals nothing)
set showmatch         " when you insert a parenthesis, cursor briefly jumps
                      " to indicate where it was opened (if it's visible)
set hls is            " acronym means: highlight search - incremental search
set comments=sr:/*,mb:*,ex:*/       " what starts a comment line
set history=50        " command history buffer size (in lines)
set clipboard=unnamedplus           " Enable clipboard copy paste. If it is not working
                                    " just install gvim (even if you don't use it
                                    " to install de dependencies

" ---------------------------------------------------------
"  KEY MAPPING
" ---------------------------------------------------------

" =========================
" Pluging/Functions/Coding style
" =========================
" Highlight catacter 86th
map <F5>  :match ErrorMsg '\%>80v.\+' <enter>
" Clear Highlight
map <S-F5>  :match <enter>
map <F3> :TlistToggle<cr>
map <F3> :TlistToggle<cr>
let Tlist_Use_Right_Window = 1
map <F2> :NERDTreeToggle<cr>
" e style code
map <F10> :set ts=8 sw=3 sts=8 noexpandtab cino=>5n-3f0^-2{2(0W1st0 nolist <enter>
" highlight no caracter number 79th and set python style
map <F9>  :match ErrorMsg '\%>79v.\+' <enter>  :set tabstop=4 sw=4 expandtab <enter>
" highlight no caracter number 79th and set openocd style
map <F12>  :match ErrorMsg '\%>79v.\+' <enter>  :set tabstop=4 sw=4 noexpandtab<enter>
" replace CRLF by LF at the end of the line
map <F7> :update <enter> ::e ++ff=dos <enter> :setlocal ff=unix <enter>
" Show spaces at end of each line
nnoremap <F8>     :ShowSpaces 1<CR>
" Remove the spaces at end of each line
nnoremap <S-F8>   m`:TrimSpaces<CR>``
vnoremap <S-F8>   :TrimSpaces<CR>
" build tags of your own project with CTRL+F12
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
noremap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
inoremap <F12> <Esc>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
" Search in visual mode, select text and type //
vnoremap // y/<C-R>"<CR>

" =========================
" Save/Quit file
" =========================
" Save with or without captal letter
cmap W<cr> w<cr>
" Close with or without captal letter
cmap Q<cr> q<cr>
" Close and Save with or without captal letter
cmap WQ<cr> wq<cr>
cmap Wq<cr> wq<cr>
cmap wQ<cr> wq<cr>
cmap WQ!<cr> wq!<cr>
cmap Wq!<cr> wq!<cr>
cmap wQ!<cr> wq!<cr>

" =========================
" Tabs
" =========================
nmap <C-h> :tabnew<cr>
map!<C-h> <ESC>:tabnew<cr>i
nmap <C-j> :tabprevious<cr>
map!<C-j> <ESC>:tabprevious<cr>i
map <C-k> :tabnext<cr>
map!<C-k> <ESC>:tabnext<cr>i

"nmap <C-Left> :tabprevious<cr>
"map!<C-Left> <ESC>:tabprevious<cr>i
"map <C-Right> :tabnext<cr>
"map!<C-Right> <ESC>:tabnext<cr>i

" =========================
" Line moves up/down
" =========================
" Swap the current line with the line just below
"map <A-Down> <esc>ddp
"imap <A-Down> <esc>ddpi
map <C-Down> <esc>ddp
imap <C-Down> <esc>ddpi
" Swap the current line with the line just above
"map <A-Up> <esc>ddkP
"imap <A-Up> <esc>ddkPi
map <C-Up> <esc>ddkP
imap <C-Up> <esc>ddkPi


" =========================
" Disabling arrows for navigation
" =========================
"inoremap  <Up>     <NOP>
"inoremap  <Down>   <NOP>
"inoremap  <Left>   <NOP>
"inoremap  <Right>  <NOP>
"noremap   <Up>     <NOP>
"noremap   <Down>   <NOP>
"noremap   <Left>   <NOP>
"noremap   <Right>  <NOP>

" =========================
" General mapping
" =========================
" Paste last yank
"map l <esc>"0p
"map L <esc>"0p
" New line in normal mode
map <S-Enter> O<Esc>
map <CR> o<Esc>
" Cscope find
"map <C-l> :cs f
"map <C-L> :cs f
"map! <C-l> <esc>:cs f
"map! <C-L> <esc>:cs f


" ---------------------------------------------------------
"  DEFINITIONS OF FUNCTIONS AND COMMANDS
" ---------------------------------------------------------

" super retab command, convert spaces to tabs
" Use: select a code and enter :'<,'>SuperRetab 2
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

" Show spaces at end of each line
function ShowSpaces(...)
  let @/="\\v(\\s+$)|( +\\ze\\t)"
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

" Remove the spaces at end of each line
function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
