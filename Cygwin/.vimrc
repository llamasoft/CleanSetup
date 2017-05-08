" Reset to vim-default
if &compatible          " only if not set before:
  set nocompatible      " use vim-defaults instead of vi-defaults (easier, more user friendly)
endif


"""" Display setting
set background=dark     " enable for dark background terminal
set nowrap              " dont wrap line
set scrolloff=3         " N lines above/below cursor when scrolling
" set number              " show line number
" set showmatch           " show matching bracket (briefly jump)
set showmode            " show mode in status bar (insert/replace/...)
set showcmd             " show typed command in status bar
set ruler               " show cursor position in status bar
set title               " show file in titlebar


"""" Editor setting
set belloff=all         " disable error bell for all reason
set fileformat=unix     " file mode is unix
set esckeys             " map missed escape sequences (enables keypad keys)
set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase character

set magic               " change the way backslashes are used in search pattern
set bs=indent,eol,start " Allow backspacing over everything in insert mode

" set smartindent         " smart auto indenting based on syntax rule
set autoindent          " copy the previous line's indentation
set smarttab            " smart tab handling for indenting
set tabstop=4           " tab stops every N character
set shiftwidth=4        " width for autoindent
set expandtab           " convert tabs to spaces on indent (not same as :retab)


"""" System setting
set lazyredraw          " no redraws in macro
set confirm             " get a dialog when :q, :w, or :wq fail
set nobackup            " no backup~ files.
set hidden              " remember undo after quitting
set history=50          " keep 50 lines of command history
" set mouse=v             " use mouse in visual mode (not normal,insert,command,help mode)


"""" Color settings (if supported)
if &t_Co > 2 || has("gui_running")
    syntax on           " enable color
    set fo-=cro         " formatoptions, don't propagate comment lines
    set hlsearch        " highlight search
    " set incsearch      " search incremently (while typing)
endif


"""" Custom shortcuts
let @u='gUiw'          " Uppercase current word
let @l='guiw'          " Lowercase current word
let @h=':nohlsearch'   " Turn off search highlighting for current matches

" paste mode toggle (needed when using autoindent/smartindent)
" <C-O> returns to normal mode for one command
map  <F10>      :set paste!<CR>
imap <F10> <C-O>:set paste!<CR>


" \w shows whitespace as visible character
nnoremap <leader>w :call ToggleWhitespace()<CR>
let g:whitespace_visible = 0

function! ToggleWhitespace()
    if g:whitespace_visible
        echom "Whitespace hidden"
        let g:whitespace_visible = 0
        set list!
    else
        echom "Whitespace visible"
        let g:whitespace_visible = 1
        set list
        set listchars=tab:\|\ ,trail:-
    endif
endfunction


" \t trims all trailing whitespace
" The \m in the pattern forces 'regular magic' mode
nnoremap <leader>t :%s/\m\s\+$// <BAR> nohl <BAR> echom "Trailing spaces removed" <CR>
