" Options
" --------------------
" // cSpell:disable
set background=dark
" set colorcolumn=80
set complete+=kspell
set completeopt=menuone,longest
set expandtab
set guifont=Iosevka\ SS02\ Semibold:h14
set incsearch
set jumpoptions+=stack
set langmenu=en_US 
let $LANG = 'en_US'
set ma
set mouse=a
set number
set nobackup
set nobomb
set noerrorbells
set noswapfile
set nowrap
set nu rnu
set number relativenumber
set smartcase
set shiftwidth=4
set shortmess+=c
set tabstop=4 softtabstop=4
set undodir=~/.vim/undodir
set undofile
set ve+=onemore
set fillchars-=vert:\|
set fillchars+=vert:\ 

" disable only ligatures and accents 
let g:tex_conceal = 'bdmgs'

" Leader
" --------------------
let mapleader = ","

" Node
" --------------------
" If :checkhealth says that npm is not recognized then
" Run the following command:
"   -> npm install -g neovim
if has('win32')
    " expand('~/AppData/Roaming/nvm/v12.22.1/node64.exe)
    " //wsl$/Ubuntu-20.04/home/iardo/docker/bin-nodejs/node_versions/v14.17.3/bin/node
    let g:coc_node_path = '\\wsl$\Ubuntu-20.04\home\iardo\docker\bin-nodejs\node_versions\v14.17.3\bin\node'
endif

" Python
" --------------------
" If you encounter an error like this:
"   -> [ function provider#python#Call[9]..remote#host#Require[13]..provider#pythonx#Require, line 15 ]
" Run this command 
"   -> pip install --upgrade --force-reinstall neovim --user
if has('win32')
    " expand('~/AppData/Local/Programs/Python/Python39/python.exe')
    let g:python3_host_prog = expand('~/AppData/Local/Programs/Python/Python39/python.exe')
endif

" True colors
" --------------------
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

" Shell
" --------------------
if has('win32')
    let &shell = has('win32') ? 'powershell' : 'pwsh'
    let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
    let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    set shellquote= shellxquote=
endif

" Plugins
" --------------------
call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'jremmen/vim-ripgrep', {'do': 'yes \| choco install ripgrep'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lyuts/vim-rtags'
Plug 'mbbill/undotree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'severin-lemaignan/vim-minimap'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-utils/vim-man'
Plug 'vim-vdebug/vdebug'
call plug#end()

" Plugin settings
" --------------------

" Airline
let g:airline_theme = "palenight"

" Coc

nnoremap <leader>gd <Plug>(coc-definition)
nnoremap <leader>gr <Plug>(coc-references)
nnoremap <C-p> :GFiles<CR>
let g:coc_start_at_startup = 1
let g:coc_global_extensions = [
    \'coc-browser',
    \'coc-cssmodules',
    \'coc-emmet',
    \'coc-flutter',
    \'coc-fzf-preview',
    \'coc-gist',
    \'coc-graphql',
    \'coc-highlight',
    \'coc-html',
    \'coc-htmlhint',
    \'coc-html-css-support',
    \'@yaegassy/coc-intelephense',
    \'coc-java',
    \'coc-json',
    \'coc-julia',
    \'coc-omnisharp',
    \'coc-php-cs-fixer',
    \'coc-phpls',
    \'coc-powershell',
    \'coc-python',
    \'coc-rls',
    \'coc-rome',
    \'coc-sh',
    \'coc-stylelintplus',
    \'coc-stylelint',
    \'coc-sourcekit',
    \'coc-spell-checker',
    \'coc-sql',
    \'coc-sqlfluff',
    \'coc-svelte',
    \'coc-svg',
    \'coc-swagger',
    \'coc-tailwindcss',
    \'coc-texlab',
    \'coc-tsserver',
    \'coc-vetur',
    \'coc-xml',
    \'coc-yaml',
\ ]
let g:coc_user_config = {
    \'coc.preferences': {
        \'suggest.noselect': v:false,
        \'suggest.enablePreselect': v:false,
    \}
\}

" CtrlP
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_use_caching = 0

" Fzf
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" Lightline
let g:lightline = { 'colorscheme': 'palenight' }

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Undotree
nnoremap <leader>u :UndotreeShow<CR>
let g:netrw_browse_split = 2
let g:netrw_banner = 0

" Ripgrep
nnoremap <leader>ps :Rg<SPACE>
if executable('rg')
    let g:rg_derive_root = 'true'
endif

" Mappings
" --------------------

" Buffers
nnoremap <S-A-h> :wincmd h<CR>
nnoremap <S-A-j> :wincmd j<CR>
nnoremap <S-A-k> :wincmd k<CR>
nnoremap <S-A-l> :wincmd l<CR>
nnoremap <S-A-Left> :wincmd h<CR>
nnoremap <S-A-Down> :wincmd j<CR>
nnoremap <S-A-Up> :wincmd k<CR>
nnoremap <S-A-Right> :wincmd l<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex<bar> :vertical resize 30<CR>
nnoremap <C-w> :q<CR>

" Clipboard
nmap <c-c> "+y
vmap <c-c> "+y
nmap <c-v> "+p
inoremap <c-v> <c-r>+
cnoremap <c-v> <c-r>+
inoremap <c-r> <c-v>

" Line comments
if has('win32')
  nmap <C-/> :Commentary<CR>
  vmap <C-/> :Commentary<CR>
else
  nmap <c>/ :Commentary<CR>
  vmap <c>/ :Commentary<CR>
endif

" Line move
nnoremap <S-Up> :m-2<CR>
vnoremap <S-Up> <Esc>:m-2<CR>
nnoremap <S-k> :m-2<CR>
vnoremap <S-k> <Esc>:m-2<CR>
nnoremap <S-Down> :m+<CR>
vnoremap <S-Down> <Esc>:m+<CR>
nnoremap <S-j> :m+<CR>
vnoremap <S-j> <Esc>:m+<CR>

" Navigation
" TODO: add mapping
nnoremap <S-H> 0
vnoremap <S-H> 0
nnoremap <S-L> $l
vnoremap <S-L> $l
nnoremap <S-e> :$<CR> $l

" Minimap
nnoremap <Leader>mm g:minimap_show<CR
nnoremap <Leader>mc g:minimap_close<CR>

" Search
nnoremap <leader>hh <cmd>noh<cr>

" Terminal
" TODO: search what is this about
map <Leader>t :term ++close<cr>
tmap <Leader>t <c-w>:term ++close<cr>

" Vimrc
let vimrc=expand('<sfile>:p')
nnoremap ,vu :source <C-R>=vimrc<CR><CR>
nnoremap ,ve :call <sid>OpenVimrc()<cr>

" TODO: investigar para que son los siguientes comandos
inoremap <expr> <Down> pumvisible() ? "<C-n>" :"<Down>"
inoremap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"

inoremap <expr> <Right> pumvisible() ? "<C-y>" : "<Right>"
inoremap <expr> <CR> pumvisible() ? "<C-y>" :"<CR>"

inoremap <expr> <Left> pumvisible() ? "<C-e>" : "<Left>"

nnoremap gb :e#<CR>

" Functions
" --------------------
function! s:OpenVimrc()
  if (0==strlen(bufname('%'))) && (1==line('$')) && (0==strlen(getline('$')))
    exe "e ".g:vimrc
  else
    exe "sp ".g:vimrc
  endif
endfunction

" TODO: Revisar esta funcion nuevamente
" function! s:tab_completion()
"   let info = complete_info(['pum_visible', 'items'])

"   if info.pum_visible
"     if len(info.items) <= 1
"       return "\<C-y>"
"     else
"       return "\<C-n>"
"     endif
"   endif

"   return "\<C-g>u\<TAB>"
" endfunction

" inoremap <silent><expr> <TAB> <SID>tab_completion()
" inoremap <silent><expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>

" Theme
" --------------------
colorscheme palenight
