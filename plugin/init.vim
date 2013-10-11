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
set autoindent        "self-explaining
"set cindent           "C style of indentation
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/
set nobackup          "don't create annoying '~' files

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

" *********************************************************************************************
" comments.vim  
" *********************************************************************************************
" Description : Global Plugin to comment and un-comment different 
"               source files in both normal and visual <Shift-V> mode
" Last Change : 26th April, 2006
" Created By  : Jasmeet Singh Anand <jasanand@hotmail.com>
" Version     : 2.2
" Usage       : For VIM 6 -
"               Stick this file in your ~/.vim/plugin directory or 
"               in some other 'plugin' directory that is in your runtime path
"               For VIM 5 -
"               Stick this file somewhere and 'source <path>/comments.vim' it from
"               your ~/.vimrc file
" Note        : I have provided the following key mappings
"               To comment    <Ctrl-C> in both normal and visual <Shift-V> range select mode
"               To un-comment <Ctrl-X> in both normal and visual <Shift-V> range select mode
"               These can be changed based on user's likings or usage
" Contact     : For any comments or bug fixes email me at <jasanand@hotmail.com>
" *********************************************************************************************
 "Modification:
" *********************************************************************************************
" Jasmeet Anand  26th April, 2006 v2.0 
" Fixed C commenting where a single line already had previous comments.
" int x=0; /*this is an x value*/
" Still working on situations like
" Issue A:
" 1 int x=0; /*this
" 2           is 
" 3           an
" 4           x
" 5           value*/
" *********************************************************************************************
" Jasmeet Anand  26th April, 2006 v2.1
" Provided more granule checking for C Code but still working on Issue A
" *********************************************************************************************
" Jasmeet Anand  27th April, 2006 v2.2
" Fixed another minor C code commenting bug
" Provided for .csh, .php, .php2 and .php3 support
" Resolved Issue A with the following logic 
" 1 /* int x=0; */ /*this*/
" 2           /*is*/ 
" 3           /*an*/
" 4           /*x*/
" 5           /*value*/
" However care should be taken when un-commenting it
" in order to retain the previous comments  
" *********************************************************************************************
" Jasmeet Anand  1st May 2006 v2.3
" Provided [:blank:] to accomodate for space and tab characters
" *********************************************************************************************
" Jasmeet Anand  1st May 2006 v2.4
" Provided support for .css as advised by Willem Peter
" *********************************************************************************************
" Jasmeet Anand  2nd May 2006 v2.5
" Removed auto-indenting for .sql, .sh and normal files when un-commenting
" *********************************************************************************************
" Jasmeet Anand  5th June 2006 v2.6
" Added support for .html, .xml, .xthml, .htm, .vim, .vimrc
" files as provided by Jeff Buttars
" *********************************************************************************************
" Smolyar "Rastafarra" Denis 7th June 2007 v2.7
" Added support for .tex
" *********************************************************************************************
" Jasmeet Anand  5th June 2006 v2.8
" Added support for Fortran .f, .F, .f90, .F90, .f95, .F95
" files as provided by Albert Farres
" *********************************************************************************************
" Jasmeet Anand  8th March 2008 v2.9
" Added support for ML, Caml, OCaml .ml, mli, PHP (v.4) .php4, PHP (v.5) .php5
" files as provided by Denis Smolyar
" Added support for noweb (requires only a small enhancement to the tex type)
" as provided by Meik "fuller" Teßmer
" Added support for vhdl files provided by Trond Danielsen
" *********************************************************************************************
" Jasmeet Anand 20 th March 2008 v2.10
" Bug fixes for php files as pointed by rastafarra
" *********************************************************************************************
" Jasmeet Anand 29th November 2008 v2.11
" Added support for haskel
" files as provided by Nicolas Martyanoff
" File Format changed to UNIX
" *********************************************************************************************
" Jasmeet Anand 11th January 2009 v2.12
" bug fix for haskel files as prpvided by Jean-Marie
"

" Exit if already loaded
if exists("loaded_comments_plugin")
  finish
endif

let loaded_comments_plugin="v2.10"

" key-mappings for comment line in normal mode
noremap  <silent> <C-C> :call CommentLine()<CR>
" key-mappings for range comment lines in visual <Shift-V> mode
vnoremap <silent> <C-C> :call RangeCommentLine()<CR>

" key-mappings for un-comment line in normal mode
noremap  <silent> <C-X> :call UnCommentLine()<CR>
" key-mappings for range un-comment lines in visual <Shift-V> mode
vnoremap <silent> <C-X> :call RangeUnCommentLine()<CR>

" function to comment line in normal mode
function! CommentLine()
  let file_name = buffer_name("%")

  " for .cpp or .hpp or .java or .C files use //
  if file_name =~ '\.cpp$' || file_name =~ '\.hpp$' || file_name =~ '\.java$' || file_name =~ '\.php[2345]\?$' || file_name =~ '\.C$'
    execute ":silent! normal ^i//\<ESC>==\<down>^"
  " for .c or .h or .pc or .css files use /* */
  elseif file_name =~ '\.c$' || file_name =~ '\.h$' || file_name =~ '\.pc$' || file_name =~ '\.css$' || file_name =~ '\.js$'
    " if there are previous comments on this line ie /* ... */
    if stridx(getline("."), "\/\*") != -1 && stridx(getline("."), "\*\/") != -1
      execute ":silent! normal :nohlsearch\<CR>:s/\\([^\\/\\*]*\\)\\(\\/\\*.*\\*\\/\\)/\\1\\*\\/\\2/\<CR>:s/\\([^[:blank:]]\\+\\)/\\/\\*\\1/\<CR>:nohlsearch\<CR>=="
    " if there is a /* but no */ like line 1 in Issue A above
    elseif stridx(getline("."), "\/\*") != -1 && stridx(getline("."), "\*\/") == -1
      execute ":silent! normal :nohlsearch\<CR>:s/\\(.*\\)\\(\\/\\*.*$\\)/\\/\\*\\1\\*\\/\\2\\*\\//\<CR>:nohlsearch\<CR>=="
    " if there is a */ but no /* like line 5 in Issue A above
    elseif stridx(getline("."), "\/\*") == -1 && stridx(getline("."), "\*\/") != -1
      execute ":silent! normal :nohlsearch\<CR>:s/\\(.*\\*\\/\\)/\\/\\*\\1/\<CR>:nohlsearch\<CR>=="
    " if there are no comments on this line
    elseif stridx(getline("."), "\/\*") == -1 && stridx(getline("."), "\*\/") == -1
      execute ":silent! normal ^i/*\<ESC>$a*/\<ESC>==\<down>^"
    endif
  "for .ml or .mli files use (* *)
  elseif file_name =~ '\.ml$' || file_name =~ '\.mli$'
    if stridx(getline("."), "\(\*") == -1 && stridx(getline("."), "\*)") == -1
      execute ":silent! normal ^i(*\<ESC>$a*)\<ESC>==\<down>^"
    endif
    " .html,.xml,.xthml,.htm
  elseif file_name =~ '\.html$' || file_name =~ '\.htm$' || file_name =~ '\.xml$' || file_name =~ '\.xhtml$' 
    if stridx( getline("."), "\<!--" ) != -1 && stridx( getline("."), "--\>" ) != -1
    elseif stridx( getline("."), "\<!--" ) != -1 && stridx( getline("."), "--\>" ) == -1
        "  open, but a close "
       execute ":silent! normal ^A--\>\<ESC>==\<down>^"
    elseif stridx( getline("."), "\<!--" ) == -1 && stridx( getline("."), "--\>" ) != -1
       execute ":silent! normal ^i\<\!--\<ESC>==\<down>^"
    elseif stridx( getline("."), "\<!--" ) == -1 && stridx( getline("."), "--\>" ) == -1
       execute ":silent! normal ^i\<\!--\<ESC>$a--\>\<ESC>==\<down>^"
    endif
  " for .vim files use "
  elseif file_name =~ '\.vim$' || file_name =~ '\.vimrc$'
	 execute ":silent! normal ^i\"\<ESC>\<down>^"
  " for .sql files use --
  elseif file_name =~ '\.sql$'
    execute ":silent! normal ^i--\<ESC>\<down>^"
  " for .ksh or .sh or .csh or .pl or .pm files use #
  elseif file_name =~ '\.[kc]\?sh$' || file_name =~ '\.pl$' || file_name =~ '\.pm$'
    execute ":silent! normal ^i#\<ESC>\<down>^"
  " for .tex files use %
  elseif file_name =~ '\.tex$' || file_name =~ '\.nw$'
    execute ":silent! normal ^i%\<ESC>\<down>^"
  " for fortran 77 files use C on first column 
  elseif file_name =~ '\.f$' || file_name =~ '\.F$'
    execute ":silent! normal ^gIC\<ESC>\<down>^"
  " for fortran 90/95 files use !
  elseif file_name =~ '\.f90$' || file_name =~ '\.F90$' || file_name =~ '\.f95$' || file_name =~ '\.F95$'
    execute ":silent! normal ^i!\<ESC>\<down>^"
  " for VHDL and Haskell files use -- 
  elseif file_name =~ '\.vhd$' || file_name =~ '\.vhdl$' || file_name =~ '\.hs$'
    execute ":silent! normal ^gI-- \<ESC>\<down>^"
  " for all other files use # 
  else
    execute ":silent! normal ^i#\<ESC>\<down>^"
  endif
endfunction

" function to un-comment line in normal mode
function! UnCommentLine()
  let file_name = buffer_name("%")

  " for .cpp or .hpp or .java or .C files use //
  if file_name =~ '\.cpp$' || file_name =~ '\.hpp$' || file_name =~ '\.java$' || file_name =~ '\.php[2345]\?$' || file_name =~ '\.C$'
    execute ":silent! normal :nohlsearch\<CR>:s/\\/\\///\<CR>:nohlsearch\<CR>=="
  " for .ml or .mli
  elseif file_name =~ '\.ml$' || file_name =~ '\.mli$'
    execute ":silent! normal :nohlsearch\<CR>:s/(\\*//\<CR>:nohlsearch\<CR>"
	execute ":silent! normal :nohlsearch\<CR>:s/\\*)//\<CR>:nohlsearch\<CR>=="
  " for .c or .h or .pc or .css files use /* */
  elseif file_name =~ '\.c$' || file_name =~ '\.h$' || file_name =~ '\.pc$' || file_name =~ '\.css$' || file_name =~ '\.js$'
    execute ":silent! normal :nohlsearch\<CR>:s/\\/\\*//\<CR>:s/\\*\\///\<CR>:nohlsearch\<CR>=="
  " for .vim files use "
  elseif file_name =~ '\.vim$' || file_name =~ '\.vimrc$'
    execute ":silent! normal :nohlsearch\<CR>:s/\\\"//\<CR>:nohlsearch\<CR>"
  " for .sql files use --
  elseif file_name =~ '\.sql$'
    execute ":silent! normal :nohlsearch\<CR>:s/\\-\\-//\<CR>:nohlsearch\<CR>"
  " for .ksh or .sh or .csh or .pl or .pm files use #
  elseif file_name =~ '\.[kc]\?sh$' || file_name =~ '\.pl$' || file_name =~ '\.pm$'
    execute ":silent! normal :nohlsearch\<CR>:s/\\#//\<CR>:nohlsearch\<CR>"
  " for .xml .html .xhtml .htm use <!-- -->
  elseif file_name =~ '\.html$' || file_name =~ '\.htm$' || file_name =~ '\.xml$' || file_name =~ '\.xhtml$' 
    execute ":silent! normal :nohlsearch\<CR>:s/<!--//\<CR>=="
    execute ":silent! normal :nohlsearch\<CR>:s/-->//\<CR>=="
  " for .tex use %
  elseif file_name =~ '\.tex$' || file_name =~ '\.nw$'
    execute ":silent! normal :nohlsearch\<CR>:s/%/\<CR>:nohlsearch\<CR>"
  " for fortran 77 files use C on first column 
  elseif file_name =~ '\.f$' || file_name =~ '\.F$'
    execute ":silent! normal ^x\<ESC>\<down>^"
  " for fortran 90/95 files use !
  elseif file_name =~ '\.f90$' || file_name =~ '\.F90$' || file_name =~ '\.f95$' || file_name =~ '\.F95$'
    execute ":silent! normal :nohlsearch\<CR>:s/!//\<CR>:nohlsearch\<CR>"
  " for VHDL and Haskell files use --
  elseif file_name =~ '\.vhd$' || file_name =~ '\.vhdl$' || file_name =~ '\.hs$'
    execute ":silent! normal :nohlsearch\<CR>:s/-- //\<CR>:nohlsearch\<CR>"
  " for all other files use # 
  else
    execute ":silent! normal :nohlsearch\<CR>:s/\\#//\<CR>:nohlsearch\<CR>"
  endif
endfunction

" function to range comment lines in visual mode
function! RangeCommentLine()
  let file_name = buffer_name("%")

  " for .cpp or .hpp or .java or .C files use //
  if file_name =~ '\.cpp$' || file_name =~ '\.hpp$' || file_name =~ '\.java$' || file_name =~ '\.php[2345]\?$' || file_name =~ '\.C$'
    execute ":silent! normal :s/\\S/\\/\\/\\0/\<CR>:nohlsearch<CR>=="
  " for .c or .h or .pc or .css files use /* */
  elseif file_name =~ '\.c$' || file_name =~ '\.h$' || file_name =~ '\.pc$' || file_name =~ '\.css$' || file_name =~ '\.js$'
    " if there are previous comments on this line ie /* ... */
    if stridx(getline("."), "\/\*") != -1 && stridx(getline("."), "\*\/") != -1
      execute ":silent! normal :nohlsearch\<CR>:s/\\([^\\/\\*]*\\)\\(\\/\\*.*\\*\\/\\)/\\1\\*\\/\\2/\<CR>:s/\\([^[:blank:]]\\+\\)/\\/\\*\\1/\<CR>:nohlsearch\<CR>=="
    " if there is a /* but no */ like line 1 in Issue A above
    elseif stridx(getline("."), "\/\*") != -1 && stridx(getline("."), "\*\/") == -1
      execute ":silent! normal :nohlsearch\<CR>:s/\\(.*\\)\\(\\/\\*.*$\\)/\\/\\*\\1\\*\\/\\2\\*\\//\<CR>:nohlsearch\<CR>=="
    " if there is a */ but no /* like line 5 in Issue A above
    elseif stridx(getline("."), "\/\*") == -1 && stridx(getline("."), "\*\/") != -1
      execute ":silent! normal :nohlsearch\<CR>:s/\\(.*\\*\\/\\)/\\/\\*\\1/\<CR>:nohlsearch\<CR>=="
    " if there are no comments on this line
    elseif stridx(getline("."), "\/\*") == -1 && stridx(getline("."), "\*\/") == -1
      execute ":silent! normal :s/\\(\\S.*$\\)/\\/\\*\\1\\*\\//\<CR>:nohlsearch\<CR>=="
    endif
  " .html,.xml,.xthml,.htm
  elseif file_name =~ '\.html$' || file_name =~ '\.htm$' || file_name =~ '\.xml$' || file_name =~ '\.xhtml$' 
    if stridx( getline("."), "\<!--" ) != -1 && stridx( getline("."), "--\>" ) != -1
    elseif stridx( getline("."), "\<!--" ) != -1 && stridx( getline("."), "--\>" ) == -1
        "  open, but a close "
       execute ":silent! normal ^A--\>\<ESC>==\<down>^"
    elseif stridx( getline("."), "\<!--" ) == -1 && stridx( getline("."), "--\>" ) != -1
       execute ":silent! normal ^i\<\!--\<ESC>==\<down>^"
    elseif stridx( getline("."), "\<!--" ) == -1 && stridx( getline("."), "--\>" ) == -1
       execute ":silent! normal ^i\<\!--\<ESC>$a--\>\<ESC>==\<down>^"
    endif
   " for .ml, .mli files use (* *)
  elseif file_name =~ '\.ml$' || file_name =~ '\.mli'
    if stridx(getline("."), "\(\*") == -1 && stridx(getline("."), "\*)/") == -1
      execute ":silent! normal ^i\(*\<ESC>$a*)\<ESC>==\<down>^"
	endif
  " for .vim files use --
  elseif file_name =~ '\.vim$' || file_name =~ '\.vimrc$'
    execute ":silent! normal :s/\\S/\\\"\\0/\<CR>:nohlsearch<CR>"
  " for .sql files use --
  elseif file_name =~ '\.sql$'
    execute ":silent! normal :s/\\S/\\-\\-\\0/\<CR>:nohlsearch<CR>"
  " for .ksh or .sh or .csh or .pl or .pm files use #
  elseif file_name =~ '\.[kc]\?sh$' || file_name =~ '\.pl$' || file_name =~ '\.pm$'
    execute ":silent! normal :s/\\S/\\#\\0/\<CR>:nohlsearch<CR>"
  " for .tex use %
  elseif file_name =~ '\.tex$' || file_name =~ '\.nw$'
    execute ":silent! normal :s/\\S/\\%\\0/\<CR>:nohlsearch<CR>"
  " for fortran 77 files use C on first column 
  elseif file_name =~ '\.f$' || file_name =~ '\.F$'
    execute ":silent! normal ^gIC\<ESC>\<down>^"
  " for fortran 90/95 files use !
  elseif file_name =~ '\.f90$' || file_name =~ '\.F90$' || file_name =~ '\.f95$' || file_name =~ '\.F95$'
    execute ":silent! normal :s/\\S/!\\0/\<CR>:nohlsearch<CR>"
  " for VHDL and Haskell files use --
  elseif file_name =~ '\.vhd$' || file_name =~ '\.vhdl$' || file_name =~ '\.hs$'
    execute ":silent! normal ^gI-- \<ESC>\<down>^"
  " for all other files use #  
  else
    execute ":silent! normal :s/\\S/\\#\\0/\<CR>:nohlsearch<CR>"
  endif
endfunction

" function to range un-comment lines in visual mode
function! RangeUnCommentLine()
  let file_name = buffer_name("%")

  " for .cpp or .hpp or .java files use //
  if file_name =~ '\.cpp$' || file_name =~ '\.hpp$' || file_name =~ '\.java$' || file_name =~ '\.php[2345]\?$' || file_name =~ '\.C$'
    execute ":silent! normal :s/\\/\\///\<CR>:nohlsearch\<CR>=="
  " for .c or .h or .pc or .css files use /* */
  elseif file_name =~ '\.c$' || file_name =~ '\.h$' || file_name =~ '\.pc$' || file_name =~ '\.css$' || file_name =~ '\.js$'
    execute ":silent! normal :nohlsearch\<CR>:s/\\/\\*//\<CR>:s/\\*\\///\<CR>:nohlsearch\<CR>=="
  " for .vim files use " 
  elseif file_name =~ '\.vim$' || file_name =~ '\.vimrc$'
    execute ":silent! normal :s/\\\"//\<CR>:nohlsearch\<CR>"
  " for .sql files use -- 
  elseif file_name =~ '\.sql$'
    execute ":silent! normal :s/\\-\\-//\<CR>:nohlsearch\<CR>"
  " for .ml .mli
  elseif file_name =~ '\.ml$' || file_name =~ '\.mli$'
    execute ":silent! normal :nohlsearch\<CR>:s/(\\*//\<CR>=="
    execute ":silent! normal :nohlsearch\<CR>:s/\\*)//\<CR>=="
  " for .xml .html .xhtml .htm use <!-- -->
  elseif file_name =~ '\.html$' || file_name =~ '\.htm$' || file_name =~ '\.xml$' || file_name =~ '\.xhtml$' 
    execute ":silent! normal :nohlsearch\<CR>:s/<!--//\<CR>=="
    execute ":silent! normal :nohlsearch\<CR>:s/-->//\<CR>=="
  elseif file_name =~ '\.[kc]\?sh$' || file_name =~ '\.pl$' || file_name =~ '\.pm$'
    execute ":silent! normal :s/\\#//\<CR>:nohlsearch\<CR>"
  " for .tex use %
  elseif file_name =~ '\.tex$' || file_name =~ '\.nw$'
    execute ":silent! normal :s/%/\<CR>:nohlsearch\<CR>"
  " for fortran 77 files use C on first column 
  elseif file_name =~ '\.f$' || file_name =~ '\.F$'
    execute ":silent! normal ^x\<ESC>\<down>^"
  " for fortran 90/95 files use !
  elseif file_name =~ '\.f90$' || file_name =~ '\.F90$' || file_name =~ '\.f95$' || file_name =~ '\.F95$'
    execute ":silent! normal :s/!//\<CR>:nohlsearch\<CR>"
  " for VHDL and Haskell files use --
  elseif file_name =~ '\.vhd$' || file_name =~ '\.vhdl$' || file_name =~ '\.hs$'
    execute ":silent! normal :s/-- //\<CR>:nohlsearch\<CR>"
  " for all other files use # 
  else
    execute ":silent! normal :s/\\#//\<CR>:nohlsearch\<CR>"
  endif
endfunction


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

:cs add cscope.out
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim           
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE: 
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE: 
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose  


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    "

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>	


    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout 
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout 
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif
