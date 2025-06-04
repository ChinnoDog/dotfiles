"filetype plugin indent on
set autoindent
" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" On pressing tab, insert 4 spaces
set expandtab
" Added by me
set softtabstop=2

highlight SpecialKey ctermfg=1
set list
set listchars=tab:T>

" Prevent modifying a readonly file
" See: https://vi.stackexchange.com/questions/3455/blocking-changes-to-read-only-file#10248
autocmd BufRead * let &l:modifiable = !&readonly

" Make sure colors are right in tmux
set background=dark

" Jump to last known position in file 
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Syntax highlighting by default
if has("syntax")
  syntax on
endif

" Recognize Vagrantfile as ruby
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby

" Disable mouse support
set mouse=

function! ClearAndPasteInsert()
  normal! ggdG
  set paste
  startinsert
endfunction

command! Replace call ClearAndPasteInsert()

" Make sure backspace works
set backspace=2

" Map key for yanking to system clipboard
vnoremap Y "+y

" use tabs in makefiles
autocmd FileType make setlocal noexpandtab

" Configure folding
set foldmethod=syntax            " Enable folding
set foldlevelstart=99            " Start with all folds open
set number                       " enable line numbering

" Make sure backspace works
set backspace=2

" disable mouse support
set mouse=

function! ClearAndPasteInsert()
  normal! ggdG
  set paste
  startinsert
endfunction

command! Replace call ClearAndPasteInsert()

" Map key for yanking to system clipboard
vnoremap Y "+y

" Syntax highlighting for .ssh/config.d/*
au BufNewFile,BufRead ssh_config,*/.ssh/config.d/*  setf sshconfig
