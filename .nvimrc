set nocompatible
filetype off

set rtp+=~/.nvim/bundle/Vundle.vim
call vundle#begin()

" Main configuration
set guifont=Inconsolata:h12

set hidden
set expandtab
set backspace=indent,eol,start
set autoindent
set history=1000
set ruler
set showcmd
set incsearch
set nu
set wildmode=list:full
set showtabline=2
set cmdheight=2
set shiftwidth=2
set softtabstop=2
set scrolloff=2
set foldmethod=syntax
let ruby_no_comment_fold=1
let c_no_comment_fold=1
set ruler
set laststatus=2
set statusline=%t%(\ [%n%M]%)%(\ %H%R%W%)\ %(%c-%v,\ %l\ of\ %L,\ (%o)\ %P\ 0x%B\ (%b)%)
set cursorline
set t_ti= t_te=
let g:sh_noisk=1
set modeline
set modelines=3
set foldmethod=manual
set nofoldenable
set nojoinspaces
set autoread

set nobackup
set nowritebackup

" Leader
let mapleader=","

" Vundlems
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-rails.git'
Plugin 'vim-ruby/vim-ruby.git'
Plugin 'ecomba/vim-ruby-refactoring.git'
Plugin 'tpope/vim-haml.git'
Plugin 'tpope/vim-endwise.git'
Plugin 'tpope/vim-rake.git'
Plugin 'tpope/vim-bundler.git'
Plugin 'ervandew/supertab.git'
Plugin 'cakebaker/scss-syntax.vim.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'kien/ctrlp.vim.git'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'ack.vim'
Plugin 'tpope/vim-fugitive.git'
Plugin 'ngmy/vim-rubocop.git'
Plugin 'kchmck/vim-coffee-script.git'
Plugin 'wting/rust.vim'

call vundle#end()

set t_Co=256 " 256 colors
set background=dark
colorscheme grb256
"colorscheme badwolf
syntax on

hi Normal ctermfg=231 ctermbg=NONE cterm=NONE guifg=#f8f8f2 guibg=#282a36 gui=NONE

filetype plugin indent on

" Ruby hot stuff autocomplete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

" Ruby refactoring maps
:nnoremap <leader>rap  :RAddParameter<cr>
:nnoremap <leader>rcpc :RConvertPostConditional<cr>
:nnoremap <leader>rel  :RExtractLet<cr>
:vnoremap <leader>rec  :RExtractConstant<cr>
:vnoremap <leader>relv :RExtractLocalVariable<cr>
:nnoremap <leader>rit  :RInlineTemp<cr>
:vnoremap <leader>rrlv :RRenameLocalVariable<cr>
:vnoremap <leader>rriv :RRenameInstanceVariable<cr>
:vnoremap <leader>rem  :RExtractMethod<cr>

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeHijackNetrw=0

" Buffers
:nnoremap <F5> :buffers<CR>:buffer<Space>
set shell=bash

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Indent p tags
  " autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

  " *.md is markdown
  autocmd! BufNewFile,BufRead *.md setlocal ft=
augroup END

" The Silver Searcher
" fast in file search
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>
"Silver searcher end

" Trailing whitespaces
" highlight and remove
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction
autocmd BufWritePre *.* :call TrimWhiteSpace()
" Trailing whitespaces

" Flog
" cyclomatic
:silent exe "g:flog_enable"
