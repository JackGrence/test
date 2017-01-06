set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
"Plugin 'file:///home/jackgrence/.vim/plugin/eclim.vim'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'https://github.com/kien/ctrlp.vim.git'
Plugin 'https://github.com/Valloric/YouCompleteMe.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
"Plugin 'tomasr/molokai'
" Plugin 'Yggdroot/indentLine'
" Plugin 'nathanaelkane/vim-indent-guides'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set relativenumber
set nu
set tabstop=4
set ai
set cursorline
set shiftwidth=4
set background=dark
set hlsearch

syntax enable
let g:molokai_original = 1
let g:rehash256 = 1
set t_Co=256
set mouse=a

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_user_command = 'find %s -type f'
" let g:indentLine_setColors = 0
" let g:indentLine_color_tty_light = 7 " (default: 4)
" let g:indentLine_color_dark = 1 " (default: 2)
"Plugin 'tomasr/molokai'
" let g:indentLine_color_term = 1
"let g:indentLine_char = '.'
"let g:indentLine_concealcursor = 'inc'
"let g:indentLine_conceallevel = 2
" let g:indentLine_enabled = 0
" let g:indentLine_setConceal = 0
" set list lcs=tab:\|\

function! Pair( part )
	let l:next_char = strpart( getline( '.' ), col('.'), 1 )
	if l:next_char == a:part
		execute 'normal! l'
	else
		execute 'normal! a' . a:part
	endif
endfunction

" expand( "%:e" )
func! Compile()
	exec "w"
	let l:exp = expand( "%:e" )
	if l:exp == 'c'
		call CompileC()
	elseif l:exp == 'py'
		call CompilePython()
	elseif l:exp == 'java'
		call CompileJava()
	endif
endf

func! CompileJava()
	exec "!sed -e 's/$/\r/' % > ms_% && javac -d . % && java %<"
endf

func! CompilePython()
	exec "!python %"
endf

func! CompilePython3()
	exec "w"
	exec "!python3 %"
endf

func! CompileC()
	exec "!gcc % -o %<.out && ./%<.out"
endf
" test--------
func! MakeProject()
	exec "!make"
	exec "!./%<"
endf



" ------------

inoremap } <Esc>:call Pair("}")<cr>a
inoremap ( ()<Esc>i
inoremap ) <Esc>:call Pair(")")<cr>a
inoremap {<CR> {<CR>}<Esc>ko
inoremap [ []<Esc>i
inoremap ] <Esc>:call Pair("]")<cr>a

nnoremap <F5> :call Compile()<cr>
nnoremap <F6> :call CompilePython3()<cr>
nnoremap <c-j> :m+<cr>
nnoremap <c-k> :m-2<cr>
nnoremap <c-h> :tabp<cr>
nnoremap <c-l> :tabn<cr>

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
set laststatus=2
let g:airline_theme='dark'

let g:tagbar_left = 1
nmap <F8> :TagbarToggle<CR>
autocmd VimEnter * nested :TagbarOpen
"autocmd FileType * nested :call tagbar#autoopen(0)
"autocmd BufEnter * nested :call tagbar#autoopen(0)

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
colorscheme molokai
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif

" unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:EclimCompletionMethod = 'omnifunc'
