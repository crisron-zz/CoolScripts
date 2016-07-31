" Syntax highlighting
syntax on

" Display line numbers
set number

" Copy the indentation from the previous line
set autoindent

" Enable automatic indentation according to file type
filetype plugin indent on

" Show existing tab with 4 spaces width
set tabstop=4

" When indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab insert 4 spaces
set expandtab

" On pressing backspace, Vim will automatically delete the proper
" number of spaces to move back one indentation level
set softtabstop=4

" Set indentation options for C++ files
" autocmd FileType c++ python setlocal expandtab shiftwidth=4 softtabstop=4

" autocmds for HTML files
augroup html
    " Delete any existing autocmds for when the file is sourced twice
    autocmd!
    " Set indentation options
    autocmd FileType html setlocal expandtab shiftwidth=2 softtabstop=2
    " Generate boilerplate code
    autocmd BufNewFile *.html 0r ~/.vim/skeleton.html
augroup end

" Tab completion for filenames
set wildmode=longest,list,full
set wildmenu

" Highlight searched word
set hlsearch

" Set colorscheme
colorscheme darkblue

" Always show the status line
set laststatus=2

" Show full path of file in statusline
set statusline=%F

" Display the file modified flag
set statusline+=%m

" Display percent through file
set statusline+=\ %=%P

" Highlight the word while searching
set incsearch

" Don't create .swp files
set noswapfile

" Don't destroy indentation when pasting in insert mode
" This command destroys indentation options
" set paste

" Add this line if supertab is not working
let g:SuperTabDefaultCompletionType = "<c-p>"

" Set the path to ID file
let LID_File='/Users/saurabh/mozilla-central/ID,/Users/saurabh/dhcp/dhcp-4.2.4-P2/ID'

" Make lid not jump to first search result
let LID_Jump_To_Match = 0

" Use the per-window location list for the results
let LID_Use_Location_List = 1
