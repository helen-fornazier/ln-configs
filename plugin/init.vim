filetype plugin on

"set incsearch       " vim searches while you're still typing

" ---------------------------------------------------------
"  COLOR
" ---------------------------------------------------------
syntax enable         " enable color
colorscheme ron       " color theeme
"colorscheme evening   " this one's easy =)

" ---------------------------------------------------------
"  IDENTATION
" ---------------------------------------------------------
set autoindent        " indent automatically
"set cindent           " C style of indentation
"set lisp              " lisp indenting
set expandtab         " expand tab characters to space characters
set tabstop=4         " tab char display size

" ---------------------------------------------------------
"  BACKUP
" ---------------------------------------------------------
set nobackup          " don't create annoying '~' files
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/

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
set shiftwidth=4      " indendation shift to the right
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

nmap <C-Left> :tabprevious<cr>
map!<C-Left> <ESC>:tabprevious<cr>i
map <C-Right> :tabnext<cr>
map!<C-Right> <ESC>:tabnext<cr>i

" =========================
" Line moves up/down
" =========================
" Swap the current line with the line just below
map <C-Down> <esc>ddp
imap <C-Down> <esc>ddpi
" Swap the current line with the line just above
map <C-Up> <esc>ddkP
imap <C-Up> <esc>ddkPi

" =========================
" General mapping
" =========================
" Paste last yank
map l <esc>"0p
map L <esc>"0p
" New line in normal mode
map <S-Enter> O<Esc>
map <CR> o<Esc>


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
