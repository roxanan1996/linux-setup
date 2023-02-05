" default stuff, including set nocompatible
source $VIMRUNTIME/defaults.vim

" set nocompatible

" autoload Plug if needed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
" Plugins

" Python completion
Plug 'davidhalter/jedi-vim'

Plug 'tpope/vim-fugitive'
" https://github.com/tpope/vim-fugitive/blob/master/doc/fugitive.txt
Plug 'iberianpig/tig-explorer.vim'
" Minimalistic plugin installer 
Plug 'junegunn/vim-plug'
Plug 'scrooloose/nerdtree'
" TODO try this out
Plug 'Xuyuanp/nerdtree-git-plugin'
" Align text
Plug 'godlygeek/tabular'
" TODO try it out
Plug 'airblade/vim-gitgutter'
" Plugin to change 'Hello worlds' to different delimeters with cs'whatever
Plug 'tpope/vim-surround'
" Very powerful https://github.com/terryma/vim-multiple-cursors 
" But not for now
"Plug 'terryma/vim-multiple-cursors'
"Provides automatic closing of quotes. paranthesis etc
Plug 'raimondi/delimitmate'
" It shows tabs for indent line
Plug 'yggdroot/indentline'

" TODO only for python
"Plug 'Valloric/YouCompleteMe'

" TagBar provides a sumarry of the file, files and structures used
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>'

Plug 'vivien/vim-linux-coding-style'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Themes
Plug 'nlknguyen/papercolor-theme'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim', { 'as': 'dracula' }

" Rust
Plug 'rust-lang/rust.vim'
Plug 'dense-analysis/ale'

call plug#end()

let g:airline_theme='dark'

" UI stuff
syntax on
set number
set background=dark
set noshowmode
set backspace=indent,eol,start

" Omnifunction
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" vim options that make plugins better
set updatetime=100
set laststatus=2

" spelling grammar
"set spell

" indentation stuff
set autoindent
set smartindent
set pastetoggle=<F2>

" enable folding and stuff
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" tabs and spaces
set tabstop=4
set shiftwidth=4
set softtabstop=0 noexpandtab
set smarttab
"set colorcolumn=80
"set textwidth=80
syntax enable
set nowb
set nobackup
set noswapfile

" mouse support
"set mouse=a

" clipboard stuff to enable copy paste
set clipboard=unnamedplus

" shortcuts for tabs and splits
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map ,s :split <C-R>=expand("%:p:h") . "/" <CR>
map ,v :vs <C-R>=expand("%:p:h") . "/" <CR>

" Nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-t> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" NERDTree git plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" Lightline theme
" let g:lightline = {
"      \ 'colorscheme': 'PaperColor',
"      \ }

"YOUCOMPLETE ME PYTHON
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'

"antrl4 syntax on
au BufRead,BufNewFile *.g4 set filetype=antlr4

" cscope
" This is not needed because plugin file is read
"if has("cscope")
"        " Look for a 'cscope.out' file starting from the current directory,
"        " going up to the root directory.
"        let s:dirs = split(getcwd(), "/")
"        while s:dirs != []
"                let s:path = "/" . join(s:dirs, "/")
"                if (filereadable(s:path . "/cscope.out"))
"                        execute "cs add " . s:path . "/cscope.out " . s:path . " -v"
"                        break
"                endif
"                let s:dirs = s:dirs[:-2]
"        endwhile
" 
"        set csto=0	" Use cscope first, then ctags
"        set cst		" Only search cscope
"        set csverb	" Make cs verbose
" 
"        nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"        nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"        nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"        nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"        nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"        nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"        nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"        nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
" 
"        " Open a quickfix window for the following queries.
"        set cscopequickfix=s-,c-,d-,i-,t-,e-,g-
"endif

" highlight when search is used
"set hls is

"-------------------------------------------------------------------------------
" OmniCppCompletion plugin
"-------------------------------------------------------------------------------

" Enable OmniCompletion
" http://vim.wikia.com/wiki/Omni_completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Configure menu behavior
" http://vim.wikia.com/wiki/VimTip1386
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Use Ctrl+Space for omni-completion
" http://stackoverflow.com/questions/510503/ctrlspace-for-omni-and-keyword-completion-in-vim
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
  \ "\<lt>C-n>" :
  \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
  \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
  \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" Popup menu hightLight Group
highlight Pmenu ctermbg=13 guibg=LightGray
highlight PmenuSel ctermbg=7 guibg=DarkBlue guifg=White
highlight PmenuSbar ctermbg=7 guibg=DarkGray
highlight PmenuThumb guibg=Black

" enable global scope search
let OmniCpp_GlobalScopeSearch = 1
" show function parameters
let OmniCpp_ShowPrototypeInAbbr = 1
" show access information in pop-up menu
let OmniCpp_ShowAccess = 1
" auto complete after '.'
let OmniCpp_MayCompleteDot = 1
" auto complete after '->'
let OmniCpp_MayCompleteArrow = 1
" auto complete after '::'
let OmniCpp_MayCompleteScope = 0
" don't select first item in pop-up menu
let OmniCpp_SelectFirstItem = 0

" Highlight trailing spaces
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

" Rust
" autoformat on save
let g:rustfmt_autosave = 1
" As-you-type autocomplete
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1
" Map go to definition
nnoremap <C-O> :ALEGoToDefinition<CR>


let g:ale_linters = {
\  'rust': ['analyzer'],
\}

let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'] }

