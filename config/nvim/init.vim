let mapleader = "\<space>"

" Hotkey (sxhkd)
autocmd BufWritePost *sxhkdrc !killall -SIGUSR1 -e sxhkd
" Statusbar (dwmblocks)
autocmd BufWritePost ~/.local/src/dwmblocks/blocks.h !cd ~/.local/src/dwmblocks; sudo make install && { killall -eq dwmblocks; setsid dwmblocks }

" =======
" Plugins
" =======
call plug#begin(stdpath('data') . '/plugged')
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte'

Plug 'vimwiki/vimwiki'
call plug#end()

    "\   'cocstatus': 'coc#status',
let g:lightline = {
    \ 'colorscheme': 'molokai',
    \ 'active': {
    \   'left': [ ['mode', 'paste'],
    \             ['cocstatus', 'readonly', 'filename+', ] ],
    \   'right': [ ['lineinfo'],
    \              ['percent'],
    \              ['filetype', ] ],
    \ },
    \ 'component_function': {
    \   'filename+': 'LightlineFilename',
    \ },
    \ 'mode_map': {
    \   'n': 'N',
    \   'i': 'I',
    \   'R': 'R',
    \   'v': 'V',
    \   'V': 'VL',
    \   "\<C-v>": 'VB',
    \   'c': ':',
    \ },
    \ }

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' [+]' : ''
  return filename . modified
endfunction

" Use autocmd to force lightline update.
"autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md',}]

" ===============
" Editor settings
" ===============
set number " Print a line number in front of each line
set relativenumber " Show the line numbers relative to the current line
set ignorecase smartcase " Ignore case when a pattern contains lowercase letters only

set scrolloff=2
set mouse=a
set cmdheight=2
set updatetime=300
set noshowmode

set termguicolors " Enable true-color
highlight Pmenu guifg=#d7d7d7 guibg=#0c0c0c " Popup menu
"highlight NormalFloat guifg=#d7d7d7 guibg=#0c0c0c

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" ==================
" Keyboard shortcuts
" ==================
" Force you to use hjkl
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" Move between buffers
nnoremap <left> :bprevious<CR>
nnoremap <right> :bnext<CR>

" We all agree that the "s" is the most useless motion in Vim.
noremap s <nop> " use cl instead
noremap S <nop> " use cc instead
" Now it's free real estate.
nnoremap ss :setlocal spell! spelllang=en_us<CR>
nnoremap s/ :nohlsearch<CR>
nnoremap s? :nohlsearch<CR>

" https://github.com/neovim/neovim/issues/6289
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" ================
" Language servers
" ================
" https://microsoft.github.io/language-server-protocol/implementors/servers/
" https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

nvim_lsp.rust_analyzer.setup {
  cmd = { vim.fn.expand("$RUSTUP_HOME/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rust-analyzer") }, 
  on_attach = on_attach,
  flags = { debounce_text_changes = 150, }
}

local servers = { "clangd", "cssls", "html", "jdtls", "jsonls", "pyright", --[[ "rust_analyzer" ,]] "svelte", "texlab", "tsserver", "vuels" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = { debounce_text_changes = 150, }
  }
end

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

"" Make <CR> auto-select the first completion item and notify coc.nvim to
"" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
"" Apply AutoFix to problem on the current line.
""nmap <leader>qf  <Plug>(coc-fix-current)
"
"" Map function and class text objects
"" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
""xmap if <Plug>(coc-funcobj-i)
""omap if <Plug>(coc-funcobj-i)
""xmap af <Plug>(coc-funcobj-a)
""omap af <Plug>(coc-funcobj-a)
""xmap ic <Plug>(coc-classobj-i)
""omap ic <Plug>(coc-classobj-i)
""xmap ac <Plug>(coc-classobj-a)
""omap ac <Plug>(coc-classobj-a)
"
"" Use <TAB> for selections ranges.
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)
"
"" Show commands.
"nnoremap <silent><nowait> <space>=  :<C-u>CocList commands<cr>
"" Find symbol of current document.
"nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols.
"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
