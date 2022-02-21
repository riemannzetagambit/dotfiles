" Vimrc file, http://phuzz.org
" this first section is required by Vundle:
" https://github.com/VundleVim/Vundle.vim
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'preservim/nerdtree'
Plugin 'vim-scripts/ScrollColors'
Plugin 'Lokaltog/vim-distinguished'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'leshill/vim-json'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on

" Change colorscheme here
colorscheme distinguished

"Setting latex and leader shortcuts
let mapleader=","

" tab navigation
nnoremap t :tabnext<CR>
nnoremap T :tabprevious<CR>
set switchbuf=usetab

" make it so it is easier to toggle paste mode
nnoremap <C-p> :set invpaste<CR>
" make it so it is easier to toggle line numbers
nnoremap \\ :set invnumber<CR>

"some nice shortcuts from Andy's vimrc
" instead of esc type ii to exit insert mode
inoremap ii <Esc>
" map semicolon to colon, which doesn't require a shift press for commands in
" normal mode then
nnoremap ; :
" map colon to semicolon, which requires shift press
nnoremap : ;
" <leader>h moves to the window to the left of the current window,
" <leader>j moves to the window below the current window,
" <leader>k moves to the window above the current window, and
" <leader>l moves to the window to the right of the current window.
nnoremap <leader>h <C-W>h
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l
" to resize the windows with easier controls when window is split
" increase pane by 4
nnoremap 0 :res +2<CR>
" decrease pane by 4
nnoremap 9 :res -2<CR>
" vertical increase pane by 4
nnoremap = :vertical res +2<CR>
" vertical decrease pane by 4
nnoremap - :vertical res -2<CR>
" Switch back to the last buffer you were looking at.
nnoremap <leader>b <C-^>

set tw=120			" set line width to 120 as default to comply with Milo's style requirements
set hidden			" this is so that modified buffers can be in the background
set nocompatible    " use vim defaults
set ls=2            " allways show status line
set tabstop=4       " numbers of spaces of tab character
set shiftwidth=4    " numbers of spaces to (auto)indent
set scrolloff=3     " keep 3 lines when scrolling
set showcmd         " display incomplete commands
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set ruler           " show the cursor position all the time
set visualbell     " turn off error beep/flash
set novisualbell    " turn off visual bell
set nobackup        " do not keep a backup file
set number          " show line numbers
set ignorecase      " ignore case when searching
"set noignorecase   " don't ignore case
set title           " show title in console title bar
set ttyfast         " smoother changes
"set ttyscroll=0        " turn off scrolling, didn't work well with PuTTY
set modelines=3     " number lines checked for modelines
set nostartofline   " don't jump to first character when paging
set t_Co=256        " make is so vim works with screen and 256 colors
"set whichwrap=b,s,h,l,<,>,[,]   " move freely between files
"set viminfo='20,<50,s10,h
"This makes looking at lists of commands while tab completing much nicer
set wildmenu
set wildmode=longest:full,full

"set autoindent     " always set autoindenting on
"set smartindent        " smart indent
"set cindent            " cindent
set noautoindent
set nosmartindent
set nocindent

"set autowrite      " auto saves changes when quitting and swiching buffer
set expandtab      " tabs are converted to spaces, use only when required
"set sm             " show matching braces, somewhat annoying...
"set nowrap         " don't wrap lines

syntax on           " syntax highlighing

" Keyboard mappings
map <F1> :previous<CR>  " map F1 to open previous buffer
map <F2> :next<CR>      " map F2 to open next buffer
nnoremap <silent> <leader>/ :nohlsearch<CR>
" this should clear the last search string
" (this is a problem for me because macros re-highlight the previous search
" pattern)
nnoremap <silent> m/ :let @/ = ""<CR>



"Highlight colors for various searches
"From http://www.jauu.net/data/jauu_backup/data/dotfiles/vimrc.html
"" COLORIZATION ( scary-modus )

"common bg fg color
""highlight Normal        ctermfg=black ctermbg=white
"modus (insert,visual ...)
highlight modeMsg     cterm=bold ctermfg=white  ctermbg=blue
"inactive statusLine
highlight statusLineNC  cterm=bold ctermfg=black  ctermbg=white
""visual mode
highlight visual    cterm=bold ctermfg=yellow ctermbg=red
"cursor colors
"highlight cursor        cterm=bold ctermfg=DarkCyan ctermbg=DarkCyan
highlight cursor        cterm=bold ctermfg=21 ctermbg=21
""vertical line on split screen
highlight VertSplit     cterm=bold ctermfg=yellow ctermbg=yellow
"searchpattern
highlight Search        cterm=bold ctermfg=yellow ctermbg=blue
"misspelled words (166 = orange, 93 = purple, see
"https://github.com/guns/xterm-color-table.vim)
highlight SpellBad        cterm=bold ctermfg=52  ctermbg=15
"folding
"highlight Folded                   ctermfg=white ctermbg=yellow


""""""""""""""""""
" Commands to start vim addons at startup
""""""""""""""""""

" NERD tree (for browsing file structure)
autocmd vimenter * if !argc() | NERDTree | endif
" and mapping Ctrl-n to open NERDtree
noremap <C-n> :NERDTreeToggle<CR>

" ctrlp add on
set runtimepath^=~/.vim/bundle/ctrlp.vim

" latex mappings, for vim-latex/latex-suite
" macro to automatically alter frac
let g:Tex_Com_frac = "\\frac{<++>}{<++>}<++>"

" trying to make underscore error highligting in tex files go away
let tex_no_error=1

" a custom function found on http://sartak.org/2011/03/end-of-line-whitespace-in-vim.html
" to remove trailing whitespaces
function! <SID>StripTrailingWhitespace()
    " save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nnoremap <silent> <leader><space> :call <SID>StripTrailingWhitespace()<CR>

" and finally, highlight trailing whitespace as an error
match ErrorMsg '\s\+$'
