filetype plugin on

"set incsearch       "vim searches while you're still typing
"set cindent         "C program indenting
"set autoindent      "indent automatically
"set tabstop=4       "width of the tab character
"set number          "shows line numbers
"set expandtab       "expand tab characters to space characters
"set lisp            "lisp indenting

syntax enable         "habilita cor
colorscheme ron       "esquema de cor
set ttyfast           "inserts more chars and improves redrawing
set autoindent        "self-explaining
"set cindent           "C style of indentation
set nobackup          "don't create annoying '~' files
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/

set expandtab         "tabs to spaces
"set noexpandtab
set tabstop=4         "tab char display size
set number            "show line numbers
set mouse=a           "grabs the mouse focus
                      "to disable, type ':set mouse=' (yep, equals nothing)
set showmatch         "when you insert a parenthesis, cursor briefly jumps
                      "to indicate where it was opened (if it's visible)
set hls is            "acronym means: highlight search - incremental search
set comments=sr:/*,mb:*,ex:*/     "what starts a comment line
set shiftwidth=4      "indendation shift to the right
"colorscheme evening   "this one's easy =)

set history=50        "command history buffer size (in lines)
"set tags=/home/helen/dash7/wl/tags

set clipboard=unnamedplus

"mapeando algumas teclas
"control+s salva no modo Insert e no modo Normal
"map!<C-w> <ESC>:w<cr>i
"map<C-w> :w<cr>

"control+q da quit no modo Insert e no modo Normal
"map!<C-e> <ESC>:q<cr>
"map<C-e> :q<cr>

"set updatetime=1000000
map <F3> :TlistToggle<cr>
let Tlist_Use_Right_Window = 1
map <F2> :NERDTreeToggle<cr>

"Salvar com maiúsculo salva normalmente
cmap W<cr> w<cr>

"New line in normal mode
map <S-Enter> O<Esc>
map <CR> o<Esc>

"Fechar com maiúsculo fecha normal
cmap Q<cr> q<cr>

"Fechar e salvar com letras maiúlculas
cmap WQ<cr> wq<cr>
cmap Wq<cr> wq<cr>
cmap wQ<cr> wq<cr>
cmap WQ!<cr> wq!<cr>
cmap Wq!<cr> wq!<cr>
cmap wQ!<cr> wq!<cr>

"abas
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

"mover linha para baixo"
map <C-Down> <esc>ddp
imap <C-Down> <esc>ddpi

"Para cima
map <C-Up> <esc>ddkP
imap <C-Up> <esc>ddkPi

"Colar ultimo yank
map l <esc>"0p
map L <esc>"0p

" e style code
map <F10> :set ts=8 sw=3 sts=8 noexpandtab cino=>5n-3f0^-2{2(0W1st0 nolist <enter>
"highlight no caracter número 79 e seta o estilo de python
map <F9>  :match ErrorMsg '\%>79v.\+' <enter>  :set tabstop=4 sw=4 expandtab <enter>
"highlight no caracter número 79 e seta o estilo do openocd
map <F12>  :match ErrorMsg '\%>79v.\+' <enter>  :set tabstop=4 sw=4 noexpandtab<enter>
"substitui CRLF por LF no final da linha
map <F7> :update <enter> ::e ++ff=dos <enter> :setlocal ff=unix <enter>

"super retab command, convert spaces to tabs
"Use: select a code and enter :'<,'>SuperRetab 2
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g


"splits
"nmap <C-e> :vsplit<cr>
"map! <C-e> <ESC>:vsplit<cr>i
"nmap <C-r> :split<cr>
"map! <C-r> <ESC>:split<cr>i
"selecionar
"map <C-b> <esc>v
"imap <C-b> <esc>v

"desfazer
"map <C-z> <esc>u
"imap <C-z> <esc>ui

"copia
"map <C-c> y
"imap <C-c> yi
"cola
"map <C-v> <esc>P
"imap <C-v> <esc>Pi
"corta
"map <C-x> x
"imap <C-x> xi

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

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
nnoremap <F8>     :ShowSpaces 1<CR>
nnoremap <S-F8>   m`:TrimSpaces<CR>``
vnoremap <S-F8>   :TrimSpaces<CR>

" OmniCppComplete
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

" build tags of your own project with CTRL+F12
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
noremap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
inoremap <F12> <Esc>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
