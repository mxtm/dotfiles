"Plugins

"Required for Vundle
set nocompatible
filetype off

"Initialize Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Vundle managing itself
Plugin 'VundleVim/Vundle.vim'

"Other plugins

Bundle 'bling/vim-airline'
"Configuration for vim-airline
let g:airline_powerline_fonts = 1
set ttimeoutlen=50

Bundle 'bling/vim-bufferline'

"Bundle 'Valloric/YouCompleteMe'
"Configuration for YouCompleteMe
"autocmd CompleteDone * pclose
"let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"let g:ycm_python_interpreter_path = '/usr/bin/python'
"let g:ycm_python_sys_path = []
"let g:ycm_extra_conf_vim_data = [
""  \  'g:ycm_python_interpreter_path',
""  \  'g:ycm_python_sys_path'
""  \]
"let g:ycm_global_ycm_extra_conf = '~/.global_extra_conf.py'
"Using eclim for Java
"let g:EclimCompletionMethod = 'omnifunc'

Bundle 'Raimondi/delimitMate'

Plugin 'tmhedberg/SimpylFold'

Plugin 'vim-scripts/indentpython.vim'
Plugin 'lervag/vimtex'

"End plugins section
call vundle#end()
filetype plugin indent on

"Basic configuration
syntax on
set backspace=2
set history=500
set ruler
set laststatus=2
set number
set t_Co=256
set encoding=utf-8

"Indentation configuration
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set noexpandtab
set smarttab

"Search configuration
set hlsearch
set showmatch
set ignorecase
set smartcase

"Disabling the arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

"Auto indenting toggle for pasting
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"Reformat key
map <F7> mzgg=G`z<CR>

"Enable folding, using the spacebar
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

"Python specific configuration
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
"
if empty(v:servername) && exists('*remote_startserver')
  call remote_startserver('VIM')
endif

"Copy and paste across terminals
set clipboard=unnamed
