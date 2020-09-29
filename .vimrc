au BufReadPost *.sublime-settings set syntax=json
set ruler           " Show the line and column number in status line
set showcmd         " Show (partial) command in status line
set laststatus=2    " Always show status line
set showmode        " Display current editing mode
set title           " Make the window title reflect the file being edited
"set showmatch       " Show matching brackets.
set ignorecase      " Do case insensitive matching
set history=2000    " Set history to 2000 entries
"set nu              " Line numbers
set hlsearch        " Highlight search results
"set cursorline      " Highlight the current line
set encoding=utf-8  " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file.
set nomodeline      " Disable modelines


syntax on
:color slate

" Remap :X to :x
cnoremap <expr> X (getcmdtype() is# ':' && empty(getcmdline())) ? 'x' : 'X'
