"======================================================================
"
" init-plugins.vim - 
"
" Created by skywind on 2018/05/31
" Last Modified: 2018/06/10 23:11
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :



"----------------------------------------------------------------------
" 默认情况下的分组，可以再前面覆盖之
"----------------------------------------------------------------------
if !exists('g:bundle_group')
	let g:bundle_group = ['basic', 'tags', 'enhanced', 'filetypes', 'textobj']
	let g:bundle_group += ['tags', 'airline', 'filetree', 'ale', 'echodoc', 'leaderf']
	let g:bundle_group += ['coc']

endif


"----------------------------------------------------------------------
" 计算当前 vim-init 的子路径
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

function! s:path(path)
	let path = expand(s:home . '/' . a:path )
	return substitute(path, '\\', '/', 'g')
endfunc


"----------------------------------------------------------------------
" 在 ~/.vim/bundles 下安装插件
"----------------------------------------------------------------------
call plug#begin(get(g:, 'bundle_home', '~/.vim/plugged'))


"----------------------------------------------------------------------
" 默认插件 
"----------------------------------------------------------------------

" 全文快速移动，<leader><leader>f{char} 即可触发
" Plug 'easymotion/vim-easymotion'

" 表格对齐，使用命令 Tabularize
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

" Diff 增强，支持 histogram / patience 等更科学的 diff 算法
Plug 'chrisbra/vim-diff-enhanced'


"----------------------------------------------------------------------
" 基础插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'basic') >= 0

	" 展示开始画面，显示最近编辑过的文件
	Plug 'mhinz/vim-startify'

	" 一次性安装一大堆 colorscheme
	Plug 'flazz/vim-colorschemes'

    Plug 'morhetz/gruvbox'
    let g:gruvbox_italic = 1
    let g:gruvbox_number_column = 'bg0'
    let g:gruvbox_vert_split = 'gray'
    let g:gruvbox_invert_selection = 0
    let g:gruvbox_italic = 1
    let g:gruvbox_contrast_dark = 'soft'
    colorscheme gruvbox

	" 支持库，给其他插件用的函数库
	Plug 'xolox/vim-misc'

	" 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
	Plug 'kshenoy/vim-signature'

	" 用于在侧边符号栏显示 git/svn 的 diff
	Plug 'mhinz/vim-signify'

	" 使用 ALT+e 会在不同窗口/标签上显示 A/B/C 等编号，然后字母直接跳转
	Plug 't9md/vim-choosewin'

	" 提供基于 TAGS 的定义预览，函数参数预览，quickfix 预览
	Plug 'skywind3000/vim-preview'

	" Git 支持
	Plug 'tpope/vim-fugitive'

	" 使用 ALT+E 来选择窗口
	nmap <m-e> <Plug>(choosewin)

	" 默认不显示 startify
	let g:startify_disable_at_vimenter = 1
	let g:startify_session_dir = '~/.vim/session'

	" signify 调优
	let g:signify_vcs_list = ['git']
" "	let g:signify_sign_add               = '+'
" "	let g:signify_sign_delete            = '_'
" "	let g:signify_sign_delete_first_line = '‾'
" "	let g:signify_sign_change            = '~'
" "	let g:signify_sign_changedelete      = g:signify_sign_change

	" git 仓库使用 histogram 算法进行 diff
	let g:signify_vcs_cmds = {
			\ 'git': 'git diff --no-color --diff-algorithm=histogram --no-ext-diff -U0 -- %f',
			\}

    " c/c++ switch .h* and .c* file
    Plug 'ericcurtin/CurtineIncSw.vim'

    noremap <silent> <leader>ww : call CurtineIncSw()<CR>
endif


"----------------------------------------------------------------------
" 增强插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'enhanced') >= 0

	" 用 v 选中一个区域后，ALT_+/- 按分隔符扩大/缩小选区
	Plug 'terryma/vim-expand-region'

	" 快速文件搜索
	"Plug 'junegunn/fzf'

	" 给不同语言提供字典补全，插入模式下 c-x c-k 触发
	Plug 'asins/vim-dict'

	" 使用 :FlyGrep 命令进行实时 grep
	"Plug 'wsdjeg/FlyGrep.vim'

    " spell check
    " Plug 'kamykn/spelunker.vim'
    " let g:spelunker_disable_acronym_checking = 1
    " let g:spelunker_disable_email_checking = 1
    " let g:spelunker_disable_uri_checking = 1

	" 使用 :CtrlSF 命令进行模仿 sublime 的 grep
	Plug 'dyng/ctrlsf.vim'

    let g:ctrlsf_default_root = 'project'
    let g:ctrlsf_extra_root_markers = ['.root']
    let g:ctrlsf_regex_pattern = 1
    let g:ctrlsf_search_mode = 'async'
    let g:ctrlsf_position = 'right'
    nmap     <Leader>F <Plug>CtrlSFPrompt
    vmap     <Leader>F <Plug>CtrlSFVwordExec

	" 配对括号和引号自动补全
    Plug 'Raimondi/delimitMate'
    au FileType c,cpp,h,hpp,cc let b:delimitMate_matchpairs = "(:),[:],{:}"
    
	" 提供 gist 接口
	Plug 'lambdalisue/vim-gista', { 'on': 'Gista' }
	
    " 注释工具
    Plug 'scrooloose/nerdcommenter'

	" ALT_+/- 用于按分隔符扩大缩小 v 选区
	map <m-=> <Plug>(expand_region_expand)
	map <m--> <Plug>(expand_region_shrink)

    " indentLine: dispaling thin lines at each indentation
    Plug 'Yggdroot/indentLine'
    
    let g:indentLine_color_term = 239
    let g:indentLine_char = '⎸'
    autocmd BufRead,BufNewFile *.tex
                \ let g:indentLine_concealcursor='c'

    " 按键提示
    Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

    let g:mapleader = "\<Space>"
    let g:maplocalleader = ','
    nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
    let g:which_key_vertical = 1
    let g:which_key_max_size = 25
    let g:which_key_sort_horizontal = 1
    let g:which_key_use_floating_win = 0
    let g:which_key_timeout = 100

    
endif


"----------------------------------------------------------------------
" 自动生成 ctags/gtags，并提供自动索引功能
" 不在 git/svn 内的项目，需要在项目根目录 touch 一个空的 .root 文件
" 详细用法见：https://zhuanlan.zhihu.com/p/36279445
"----------------------------------------------------------------------
if index(g:bundle_group, 'tags') >= 0

    " gtags: GNU GLOBAL source code tage system with VIM
    Plug 'vim-scripts/gtags.vim'

    " Gtags setting:
    let $GTAGSLABEL = 'native-pygments'
    let $GTAGSCONF = '/etc/gtags.conf'
    set cscopetag
    set cscopeprg=gtags-cscope
    " shortcuts
    noremap <C-n> :cn<CR>
    noremap <C-p> :cp<CR>


    Plug 'majutsushi/tagbar'
    nnoremap <leader><C-T> :Tagbar<CR>
    let g:tagbar_sort = 0
    let g:tagbar_indent = 1
    let g:tagbar_iconchars = ['▸', '▾']

    " 提供 ctags/gtags 后台数据库自动更新功能
    Plug 'ludovicchabant/vim-gutentags'

    " 提供 GscopeFind 命令并自动处理好 gtags 数据库切换
    " 支持光标移动到符号名上：<leader>cg 查看定义，<leader>cs 查看引用
    Plug 'skywind3000/gutentags_plus'

    let g:gutentags_plus_nomap = 1
    noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
    noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
    noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
    noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
    noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
    noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
    noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
    noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
    noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>

    " 设定项目目录标志：除了 .git/.svn 外，还有 .root 文件
    let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
    let g:gutentags_ctags_tagfile = '.tags'

    " 默认生成的数据文件集中到 ~/.cache/tags 避免污染项目目录，好清理
    let g:gutentags_cache_dir = expand('~/.cache/tags')

    " 默认禁用自动生成
    let g:gutentags_modules = [] 

    " 如果有 ctags 可执行就允许动态生成 ctags 文件
    if executable('ctags')
        let g:gutentags_modules += ['ctags']
    endif

    " 如果有 gtags 可执行就允许动态生成 gtags 数据库
    if executable('gtags') && executable('gtags-cscope')
        let g:gutentags_modules += ['gtags_cscope']
    endif

    " 设置 ctags 的参数
    let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
    let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
    let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

    " 使用 universal-ctags 的话需要下面这行，请反注释
    let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

    " 禁止 gutentags 自动链接 gtags 数据库
    let g:gutentags_auto_add_gtags_cscope = 0

endif


"----------------------------------------------------------------------
" 文本对象：textobj 全家桶
"----------------------------------------------------------------------
if index(g:bundle_group, 'textobj')

    " TO BE STUDIED
    " 基础插件：提供让用户方便的自定义文本对象的接口
    Plug 'kana/vim-textobj-user'

    " indent 文本对象：ii/ai 表示当前缩进，vii 选中当缩进，cii 改写缩进
    Plug 'kana/vim-textobj-indent'

    " 语法文本对象：iy/ay 基于语法的文本对象
    Plug 'kana/vim-textobj-syntax'

    " 函数文本对象：if/af 支持 c/c++/vim/java
    Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }

    " 参数文本对象：i,/a, 包括参数或者列表元素
    Plug 'sgur/vim-textobj-parameter'

    " 提供 python 相关文本对象，if/af 表示函数，ic/ac 表示类
    Plug 'bps/vim-textobj-python', {'for': 'python'}

    " 提供 uri/url 的文本对象，iu/au 表示
    Plug 'jceb/vim-textobj-uri'
endif


"----------------------------------------------------------------------
" 文件类型扩展
"----------------------------------------------------------------------
if index(g:bundle_group, 'filetypes') >= 0

    " C++ 语法高亮增强，支持 11/14/17 标准
    Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }

    " 额外语法文件
    Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }

    " python 语法文件增强
    Plug 'vim-python/python-syntax', { 'for': ['python'] }

    " rust 语法增强
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }

    " Julia 
    Plug 'JuliaEditorSupport/julia-vim'


    " vimtex
    Plug 'lervag/vimtex'

    let g:tex_flavor = 'latex'
    let g:tex_conceal= 'abg'
    let g:vimtex_fold_enabled=0
    let g:vimtex_fold_types = {}
    let g:vimtex_syntax_conceal = {
                \ "accents" : 1,
                \ "fancy" : 1,
                \ "greek" : 1,
                \ "math_bounds" : 1,
                \ "math_delimiters" : 0,
                \ "math_fracs" : 0,
                \ "math_super_sub" : 0,
                \ "math_symbols": 0,
                \ "styles" : 1,
                \ }

    "let g:vimtex_view_method = 'Preview'
    let g:vimtex_view_method = 'skim'
    let g:vimtex_view_automatic = 0
    let g:vimtex_compiler_progname = 'nvr'

    let g:vimtex_quickfix_open_on_warning = 0

    "" vimtex: disable warning message
    let g:vimtex_compiler_latexmk = {'callback' : 0}
    
    " A Vim Plugin for Lively Previewing LaTeX PDF Output
    Plug 'xuhdev/vim-latex-live-preview'
    " vim-latex-preview-config
    let g:livepreview_previewer = 'open -a Preview'
    let g:livepreview_use_biber = 1
    autocmd Filetype tex setl updatetime=0


endif


"----------------------------------------------------------------------
" airline
"----------------------------------------------------------------------
if index(g:bundle_group, 'airline') >= 0

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " buffer tabs

    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_powerline_fonts = 0
    let g:airline_exclude_preview = 1
    let g:airline_section_b = '%n'
    let g:airline_theme='gruvbox'

    let g:airline#extensions#ale#enabled = 1
    let g:airline#extensions#branch#enabled = 0
    let g:airline#extensions#fugitiveline#enabled = 1

    let g:airline#extensions#gutentags#enabled = 1
    let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'

     let g:airline#extensions#bufferline#enabled = 1

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#fnamemod = ':t'

    let g:airline#extensions#tabline#formatter = 'short_path'
    let g:airline#extensions#tabline#show_close_button = 0
    let g:airline#extensions#tabline#exclude_preview = 0

    let g:airline#extensions#tabline#show_tabs = 0 " unchange
    let g:airline#extensions#tabline#show_tab_nr = 0
    let g:airline#extensions#tabline#show_tab_count = 1

    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#tabline#buf_label_first = 0
    let g:airline#extensions#tabline#buffers_label = ''
    let g:airline#extensions#tabline#tabs_label = ''

    let g:airline#extensions#coc#enabled = 1

endif


"----------------------------------------------------------------------
" filetree
"----------------------------------------------------------------------
if index(g:bundle_group, 'filetree') >= 0

    if has('nvim')
        Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/defx.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif

    nnoremap <silent><leader><C-f> :Defx -split=vertical -winwidth=30 
                \ -direction=topleft -show_ignored_files=0 -toggle=1 
                \ -buffer_name='' -columns=git:mark:filename:type 
                \ -columns=icons:filename:type <cr>
    " \ -ignored-files= ['.pyc','~$','.swp', '.DS_Store', '.out']

    autocmd FileType defx call s:defx_my_settings()
    function! s:defx_my_settings() abort
        " Define mappings
        nnoremap <silent><buffer><expr> <CR> defx#do_action('multi', ['drop', 'quit']) 
        nnoremap <silent><buffer><expr> c defx#do_action('copy')
        nnoremap <silent><buffer><expr> m defx#do_action('move')
        nnoremap <silent><buffer><expr> p defx#do_action('paste')
        nnoremap <silent><buffer><expr> l defx#do_action('drop')
        nnoremap <silent><buffer><expr> E defx#do_action('open', 'vsplit')
        nnoremap <silent><buffer><expr> P defx#do_action('open', 'pedit')
        nnoremap <silent><buffer><expr> o defx#do_action('open_or_close_tree')
        nnoremap <silent><buffer><expr> K defx#do_action('new_directory')
        nnoremap <silent><buffer><expr> N defx#do_action('new_file')
        nnoremap <silent><buffer><expr> M defx#do_action('new_multiple_files')
        nnoremap <silent><buffer><expr> C defx#do_action('toggle_columns',
                    \   'mark:filename:type:size:time')
        nnoremap <silent><buffer><expr> S defx#do_action('toggle_sort', 'time')
        nnoremap <silent><buffer><expr> d defx#do_action('remove')
        nnoremap <silent><buffer><expr> r defx#do_action('rename')
        nnoremap <silent><buffer><expr> !  defx#do_action('execute_command')
        nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
        nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
        nnoremap <silent><buffer><expr> .  defx#do_action('toggle_ignored_files')
        nnoremap <silent><buffer><expr> ; defx#do_action('repeat')
        nnoremap <silent><buffer><expr> h defx#do_action('cd', ['..'])
        nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
        nnoremap <silent><buffer><expr> q defx#do_action('quit')
        nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
        nnoremap <silent><buffer><expr> * defx#do_action('toggle_select_all')
        nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
        nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
        nnoremap <silent><buffer><expr> <C-l> defx#do_action('redraw')
        nnoremap <silent><buffer><expr> <C-g> defx#do_action('print')
        nnoremap <silent><buffer><expr> cd defx#do_action('change_vim_cwd')
    endfunction

    Plug 'kristijanhusak/defx-icons'

    let g:defx_icons_enable_syntax_highlight = 1
    let g:defx_icons_column_length = 0
    let g:defx_icons_directory_icon = ''
    let g:defx_icons_mark_icon = '*'
    let g:defx_icons_parent_icon = ''
    let g:defx_icons_default_icon = ''
    let g:defx_icons_directory_symlink_icon = ''
    " Options below are applicable only when using "tree" feature
    let g:defx_icons_root_opened_tree_icon = ''
    let g:defx_icons_nested_opened_tree_icon = ''
    let g:defx_icons_nested_closed_tree_icon = ''

    Plug 'kristijanhusak/defx-git'
    let g:defx_git#indicators = {
                \ 'Modified'  : '✹',
                \ 'Staged'    : '✚',
                \ 'Untracked' : '✭',
                \ 'Renamed'   : '➜',
                \ 'Unmerged'  : '═',
                \ 'Ignored'   : '☒',
                \ 'Deleted'   : '✖',
                \ 'Unknown'   : '?'
                \ }
endif


"----------------------------------------------------------------------
" LanguageTool 语法检查
"----------------------------------------------------------------------
if index(g:bundle_group, 'grammer') >= 0
	Plug 'rhysd/vim-grammarous'
	noremap <space>rg :GrammarousCheck --lang=en-US --no-move-to-first-error --no-preview<cr>
	map <space>rr <Plug>(grammarous-open-info-window)
	map <space>rv <Plug>(grammarous-move-to-info-window)
	map <space>rs <Plug>(grammarous-reset)
	map <space>rx <Plug>(grammarous-close-info-window)
	map <space>rm <Plug>(grammarous-remove-error)
	map <space>rd <Plug>(grammarous-disable-rule)
	map <space>rn <Plug>(grammarous-move-to-next-error)
	map <space>rp <Plug>(grammarous-move-to-previous-error)
endif


"----------------------------------------------------------------------
" ale：动态语法检查
"----------------------------------------------------------------------
if index(g:bundle_group, 'ale') >= 0
	Plug 'w0rp/ale'

	" 设定延迟和提示信息
	let g:ale_completion_delay = 10
	let g:ale_echo_delay = 50
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
	let g:ale_lint_delay = 10
    let g:ale_sign_error = '✗'
    let g:ale_sign_warning = '⚡'
    let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']

	" 设定检测的时机：normal 模式文字改变，或者离开 insert模式
	" 禁用默认 INSERT 模式下改变文字也触发的设置，太频繁外，还会让补全窗闪烁
    let g:ale_lint_on_text_changed = 'never'
	let g:ale_lint_on_insert_leave = 1

	" 在 linux/mac 下降低语法检查程序的进程优先级（不要卡到前台进程）
	if has('win32') == 0 && has('win64') == 0 && has('win32unix') == 0
		let g:ale_command_wrapper = 'nice -n5'
	endif

    " config for C/C++
    let g:ale_c_build_dir_names = ['build', 'release', 'debug']
    let g:ale_c_build_dir = "build"
    let g:ale_c_parse_compile_commands = 1

    let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
    let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
    "let g:ale_c_cppcheck_options = ''
    "let g:ale_cpp_cppcheck_options = ''
    let g:ale_cpp_clangd_options = '-Wall -std=c++14 -x c++'
    let g:ale_cpp_clangtidy_checks = ['*']
    let g:ale_cpp_clangtidy_options = '-Wall -std=c++17 -x c++'

    " 编辑不同文件类型需要的语法检查器
    let g:ale_linters = {
                \ 'cpp': ['clangd', 'clang++', 'clangtidy',
                \ 'cquery'],
                \ 'c': ['gcc', 'clang'],
                \ 'rust': ['rustc', 'cargo', 'rls'],
                \ 'python': ['flake8', 'pylint'], 
                \ 'lua': ['luac'], 
                \ 'go': ['go build', 'gofmt'],
                \ 'java': ['javac'],
                \ 'javascript': ['eslint'], 
                \ }

    let g:ale_fixers = {
                \   '*': ['remove_trailing_lines', 'trim_whitespace'],
                \ 'cpp': ['clang-format'],
                \ }

    let g:ale_java_javac_options = '-encoding UTF-8  -J-Duser.language=en' 

	" 如果没有 gcc 只有 clang 时（FreeBSD）
	if executable('gcc') == 0 && executable('clang')
		let g:ale_linters.c += ['clang']
		let g:ale_linters.cpp += ['clang']
	endif

    " clang-format for formatting
    Plug 'rhysd/vim-clang-format'
    
    let g:clang_format#auto_format = 0 
    let g:clang_format#auto_formatexpr = 1 
    let g:clang_format#detect_style_file = 1 
    let g:clang_format#enable_fallback_style = 0

    autocmd FileType c ClangFormatAutoEnable

endif


"----------------------------------------------------------------------
" echodoc：搭配 YCM/deoplete 在底部显示函数参数
"----------------------------------------------------------------------
if index(g:bundle_group, 'echodoc') >= 0
	Plug 'Shougo/echodoc.vim'
	set noshowmode
	let g:echodoc#enable_at_startup = 1
endif


"----------------------------------------------------------------------
" LeaderF：CtrlP / FZF 的超级代替者，文件模糊匹配，tags/函数名 选择
"----------------------------------------------------------------------
if index(g:bundle_group, 'leaderf') >= 0
	" 如果 vim 支持 python 则启用  Leaderf
	if has('python') || has('python3')
		Plug 'Yggdroot/LeaderF'

		" 打开文件模糊匹配
        let g:Lf_ShortcutF = '<leader>f<leader>'
        noremap <leader>f<leader>  :LeaderfFile<cr>

		" 打开最近使用的文件 MRU，进行模糊匹配
        noremap <leader>fm :LeaderfMru<cr>

		" 打开函数列表，按 i 进入模糊匹配，ESC 退出
		noremap <leader>fp :LeaderfFunction!<cr>

		" 打开 tag 列表，i 进入模糊匹配，ESC退出
		noremap <leader>ft :LeaderfBufTag!<cr>

		" 打开 buffer 列表进行模糊匹配
		noremap <leader>fb :LeaderfBuffer<cr>

		" 全局 tags 模糊匹配
		noremap <leader>fT :LeaderfTag<cr>

        " 搜索模式
        let g:lf_defaultmode = 'NameOnly'
        let g:lf_defaultexternaltool = "ag"
        let g:lf_rememberlastsearch = 1

		" 最大历史文件保存 2048 个
		let g:Lf_MruMaxFiles = 2048

		" ui 定制
		let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
        "let g:Lf_StlPalette = {
              "\    "stlName": {
              "\        "gui": "bold",
              "\        "ctermbg": "214",
              "\        "ctermfg": "235",
              "\        "guibg": "#fabd2f",
              "\        "cterm": "bold",
              "\        "guifg": "#282828",
              "\        "font": "NONE",
              "\    },
              "\    "stlCwd": {
              "\        "gui": "NONE",
              "\        "ctermbg": "239",
              "\        "ctermfg": "223",
              "\        "guibg": "#504945",
              "\        "cterm": "NONE",
              "\        "guifg": "#ebdbb2",
              "\        "font": "NONE",
              "\    },
              "\    "stlFuzzyMode": {
              "\        "gui": "NONE",
              "\        "ctermbg": "167",
              "\        "ctermfg": "235",
              "\        "guibg": "#fb4934",
              "\        "cterm": "NONE",
              "\        "guifg": "#282828",
              "\        "font": "NONE",
              "\    },
              "\    "stlLineInfo": {
              "\        "gui": "NONE",
              "\        "ctermbg": "239",
              "\        "ctermfg": "223",
              "\        "guibg": "#504945",
              "\        "cterm": "NONE",
              "\        "guifg": "#ebdbb2",
              "\        "font": "NONE",
              "\    },
              "\    "stlCategory": {
              "\        "gui": "NONE",
              "\        "ctermbg": "108",
              "\        "ctermfg": "235",
              "\        "guibg": "#8ec07c",
              "\        "cterm": "NONE",
              "\        "guifg": "#282828",
              "\        "font": "NONE",
              "\    },
              "\    "stlRegexMode": {
              "\        "gui": "NONE",
              "\        "ctermbg": "142",
              "\        "ctermfg": "235",
              "\        "guibg": "#b8bb26",
              "\        "cterm": "NONE",
              "\        "guifg": "#282828",
              "\        "font": "NONE",
              "\    },
              "\    "stlBlank": {
              "\        "gui": "NONE",
              "\        "ctermbg": "239",
              "\        "ctermfg": "243",
              "\        "guibg": "#504945",
              "\        "cterm": "NONE",
              "\        "guifg": "#a89984",
              "\        "font": "NONE",
              "\    },
              "\    "stlFullPathMode": {
              "\        "gui": "NONE",
              "\        "ctermbg": "175",
              "\        "ctermfg": "235",
              "\        "guibg": "#d3869b",
              "\        "cterm": "NONE",
              "\        "guifg": "#282828",
              "\        "font": "NONE",
              "\    },
              "\    "stlTotal": {
              "\        "gui": "bold",
              "\        "ctermbg": "214",
              "\        "ctermfg": "235",
              "\        "guibg": "#fabd2f",
              "\        "cterm": "bold",
              "\        "guifg": "#282828",
              "\        "font": "NONE",
              "\    },
              "\    "stlNameOnlyMode": {
              "\        "gui": "NONE",
              "\        "ctermbg": "109",
              "\        "ctermfg": "235",
              "\        "guibg": "#83a598",
              "\        "cterm": "NONE",
              "\        "guifg": "#282828",
              "\        "font": "NONE",
              "\    },
              "\}

		" 如何识别项目目录，从当前文件目录向父目录递归知道碰到下面的文件/目录
		let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
		let g:Lf_WorkingDirectoryMode = 'Ac'
		let g:Lf_WindowHeight = 0.30
		let g:Lf_CacheDirectory = expand('~/.vim/cache')

		" 显示绝对路径
		let g:Lf_ShowRelativePath = 0

		" 显示帮助
		let g:Lf_HideHelp = 0

		" 模糊匹配忽略扩展名
		let g:Lf_WildIgnore = {
					\ 'dir': ['.svn','.git','.hg'],
					\ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
					\ }

		" MRU 文件忽略扩展名
		let g:Lf_MruFileExclude = ['*.so', '*.exe', '*.py[co]', '*.sw?', '~$*', '*.bak', '*.tmp', '*.dll']

		" 禁用 function/buftag 的预览功能，可以手动用 p 预览
		let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

		" 使用 ESC 键可以直接退出 leaderf 的 normal 模式
		let g:Lf_NormalMap = {
				\ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
				\ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<cr>']],
				\ "Mru": [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<cr>']],
				\ "Tag": [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<cr>']],
				\ "BufTag": [["<ESC>", ':exec g:Lf_py "bufTagExplManager.quit()"<cr>']],
				\ "Function": [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<cr>']],
				\ }
        "  Gtags 配置
        let g:Lf_Gtagsconf = '/etc/gtags.conf'
    endif
endif


"----------------------------------------------------------------------
" deoplete补全
"----------------------------------------------------------------------
if index(g:bundle_group, 'complete') >= 0


	if has('nvim')
		Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
	else
		Plug 'Shougo/defx.nvim'
		Plug 'roxma/nvim-yarp'
		Plug 'roxma/vim-hug-neovim-rpc'
	endif

    " A very good source of deoplete
    Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_smart_case = 1
    let g:deoplete#auto_completion_start_length = 3
    let g:deoplete#auto_complete_delay=10
    let g:deoplete#ignore_sources = {}
    let g:deoplete#sources = {'_': ['tabnine', 'ale']}
    " let g:deoplete#ignore_sources._ = ['javacomplete2']
    set completeopt=menu,menuone,preview,noselect,noinsert

    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

endif

"----------------------------------------------------------------------
" coc补全
"----------------------------------------------------------------------
if index(g:bundle_group, 'coc') >= 0

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    set updatetime=300
endif
"----------------------------------------------------------------------
" 结束插件安装
"----------------------------------------------------------------------
call plug#end()
