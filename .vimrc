" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

" leader key
let mapleader = ","
" let g:mapleader = ","

" set line number
set numberwidth=4
set number

" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

" regular
set backspace=2 "make backspace work like most other apps
set history=100
set so=5 "scroll offset = the number of context lines you would like to see above and below the cursor
set ruler "Always show current position
set cmdheight=2 "The commandbar height
set showmatch "Show matching bracets when text indicator is over them

" unknown
set wildmenu "Turn on WiLd menu
set hidden "Change buffer - without saving
set whichwrap+=<,>,h,l
set ignorecase "Ignore case when searching
set smartcase
set gdefault
set hlsearch "Highlight search things
set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros
set magic "Set magic on, for regular expressions
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" tab
set shiftwidth=2
set tabstop=2
set shiftround
set expandtab
"set softtabstop=2
"set smarttab

" Linebreak on 500 characters
set lbr
set tw=500

set autoindent "Auto indent
set smartindent "Smart indet
set copyindent "Smart indet
set wrap "Wrap lines

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
    syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

filetype plugin indent on


"set go=er
let $LANG='en_US'
set langmenu=en_US

" Set to auto read when a file is changed from the outside
set autoread
set autowrite

"nnoremap ; :
inoremap jj <esc>
cnoremap jj <esc>
map <F1> <esc>
map <F2> :nohl<cr>
set pastetoggle=<F7>

" 修改等号两端
nmap c=r $F=lc$<space>
nmap c=l $F=hc^

set matchpairs=(:),{:},[:],<:>

" 命令行bash快捷键
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <A-b> <S-Left>
cnoremap <A-f> <S-Right>
cnoremap <A-B> <S-Left>
cnoremap <A-F> <S-Right>

"set foldenable
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
vnoremap <space> :fold<CR>
set foldnestmax=10
set foldenable
set foldlevel=1

" 按下 Q 不进入 Ex 模式，而是退出
nmap Q :x<cr>

" 删除光标处的单词
imap <c-w> <Esc>ebdei

" Show invisible
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,trail:.,extends:#,nbsp:.,eol:¬
" autocmd filetype html,xml set listchars-=tab:>.

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" code style line 80
set colorcolumn=80
" au FileType html,eruby set colorcolumn=200


" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" color
set t_Co=256
color wombat256

" file format
set encoding=utf8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set ffs=unix,dos,mac "Default file types

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Always display the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

"
function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z


"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
"autocmd BufWrite *.py :call DeleteTrailingWS()
nnoremap <silent> <F5>  :call DeleteTrailingWS()<CR>

set guitablabel=%t

""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>
map <a-f> :Mru<cr>

""""""""""""""""""""""""""""""
" => airline
""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
set guifont=Menlo\ Regular\ for\ Powerline\ for\ Powerline


"    file                 type
au   BufNewFile,BufRead   *.coffee,*.coffee.erb          set ft=coffee
au   BufNewFile,BufRead   *.js,*.json,*.js.erb           set ft=javascript
au   BufNewFile,BufRead   *.css,*.css.erb                set ft=css
au   BufNewFile,BufRead   *.scss,*.css.scss              set ft=scss
au   BufNewFile,BufRead   *.html                         set ft=html
au   BufNewFile,BufRead   *.html.erb                     set ft=eruby

au   FileType html,css,javascript,eruby        set softtabstop=4 tabstop=4 shiftwidth=4 expandtab
au   FileType coffee,scss                      set softtabstop=2 tabstop=2 shiftwidth=2

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1


" Removes trailing spaces except markdown
function! TrimWhiteSpace()
    if exists('b:noStripWhitespace')
      return
    endif
    %s/\s\+$//e
endfunction
nnoremap <silent> <Leader>rtw :call TrimWhiteSpace()<CR>
autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()
autocmd FileType md, markdown let b:noStripWhitespace=1

" auto reload vimrc
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" config YouCompleteMe key binding
" let g:ycm_key_list_select_completion = ['<C-TAB>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-S-TAB>', '<Up>']

" tabular
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" tagbar
nnoremap <silent> <Leader>b :TagbarToggle<CR>
