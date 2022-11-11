set number
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a
set background=dark

call plug#begin()

Plug 'https://github.com/vim-airline/vim-airline'
Plug 'kyazdani42/nvim-web-devicons' " for file icons

" Autocomplete
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind.nvim'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Debug
Plug 'mfussenegger/nvim-dap'

" Autoclose
Plug 'tmsvg/pear-tree'

" Git
" Plug 'tanvirtin/vgit.nvim'
Plug 'TimUntersberger/neogit'
Plug 'sindrets/diffview.nvim'
Plug 'airblade/vim-gitgutter'
  
" Tabs
Plug 'romgrk/barbar.nvim'
  
" Comments
Plug 'preservim/nerdcommenter'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Orgmode
Plug 'nvim-orgmode/orgmode'
Plug 'dhruvasagar/vim-table-mode'

" Dashboard
Plug 'glepnir/dashboard-nvim'

" Telescope
Plug 'BurntSushi/ripgrep'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'nvim-telescope/telescope-file-browser.nvim'

" File Tree
Plug 'nvim-tree/nvim-tree.lua'

" Terminal
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" Jump
Plug 'ggandor/leap.nvim'

" Indent Lines
Plug 'lukas-reineke/indent-blankline.nvim'

" Theme
Plug 'joshdick/onedark.vim'
" Plug 'lukas-reineke/onedark.nvim'

call plug#end()

colorscheme onedark

let mapleader = " "

let g:airline_left_sep=''
let g:airline_right_sep=''

" Smart pairs are disabled by default:
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

" Fix telescope
let g:pear_tree_ft_disabled = ['TelescopePrompt']

" Neovide
if exists("g:neovide")
	set guifont=FiraCode\ Nerd\ Font:h11
	"let g:neovide_scroll_animation_length = 2.0
endif

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Unbind space
nnoremap <Space> <NOP>

" Autoclose
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>O
"inoremap {;<CR> {<CR>};<ESC>O

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope file_browser<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>

" Tab navigation
"nnoremap <leader>tt <cmd>tabnew<cr>
"nnoremap <leader>td <cmd>tabnext<cr>
"nnoremap <leader>ta <cmd>tabprevious<cr>
"nnoremap <leader>tc <cmd>tabclose<cr>

" Nvim Tree
nnoremap <silent> <leader>tt <cmd>NvimTreeToggle<CR>

" Navigation
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

nnoremap <A-a> <C-w>h
nnoremap <A-s> <C-w>j
nnoremap <A-w> <C-w>k
nnoremap <A-d> <C-w>l

nnoremap <A-Left> <C-w>h
nnoremap <A-Down> <C-w>j
nnoremap <A-Up> <C-w>k
nnoremap <A-Right> <C-w>l

" Terminal
"nnoremap <F4> <cmd>bo sp<cr><cmd>terminal<cr><cmd>res 14<cr>
"tnoremap <Esc> <C-\><C-n>
"autocmd TermOpen * setlocal nonumber norelativenumber

" Lsp
nnoremap <leader>lx <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>ld <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>li <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>ll <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>lr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <leader>lt <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <F2> <cmd>lua vim.lsp.buf.rename()<CR>

" Debug
nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <Leader>dd <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <Leader>db <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <Leader>dp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

" Git
nnoremap <silent> <leader>gg <Cmd>Neogit<CR>

" Move to previous/next
nnoremap <silent>    <A-,> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <A-.> <Cmd>BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-C-,> <Cmd>BufferMovePrevious<CR>
nnoremap <silent>    <A-C-.> <Cmd>BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> <Cmd>BufferGoto 1<CR>
nnoremap <silent>    <A-2> <Cmd>BufferGoto 2<CR>
nnoremap <silent>    <A-3> <Cmd>BufferGoto 3<CR>
nnoremap <silent>    <A-4> <Cmd>BufferGoto 4<CR>
nnoremap <silent>    <A-5> <Cmd>BufferGoto 5<CR>
nnoremap <silent>    <A-6> <Cmd>BufferGoto 6<CR>
nnoremap <silent>    <A-7> <Cmd>BufferGoto 7<CR>
nnoremap <silent>    <A-8> <Cmd>BufferGoto 8<CR>
nnoremap <silent>    <A-9> <Cmd>BufferGoto 9<CR>
nnoremap <silent>    <A-0> <Cmd>BufferLast<CR>
" Pin/unpin buffer
nnoremap <silent>    <A-p> <Cmd>BufferPin<CR>
" Close buffer
nnoremap <silent>    <A-c> <Cmd>BufferClose<CR>
" Magic buffer-picking mode
nnoremap <silent>    <A-f> <Cmd>BufferPick<CR>

set termguicolors " this variable must be enabled for colors to be applied properly


""highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
""highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
""highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
" light blue
""highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE cterm=italic
""highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
""highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
" pink
""highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
""highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
" front
""highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
""highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
""highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4

"New
highlight! PmenuSel guibg=#282C34 guifg=NONE
highlight! Pmenu guifg=#C5CDD9 guibg=#22252A

highlight! CmpItemAbbrDeprecated guifg=#7E8294 guibg=NONE cterm=strikethrough
highlight! CmpItemAbbrMatch guifg=#82AAFF guibg=NONE cterm=bold
highlight! CmpItemAbbrMatchFuzzy guifg=#82AAFF guibg=NONE cterm=bold
highlight! CmpItemMenu guifg=#C792EA guibg=NONE" cterm=italic

highlight! CmpItemKindField guifg=#EED8DA guibg=#B5585F
highlight! CmpItemKindProperty guifg=#EED8DA guibg=#B5585F
highlight! CmpItemKindEvent guifg=#EED8DA guibg=#B5585F

highlight! CmpItemKindText guifg=#C3E88D guibg=#9FBD73
highlight! CmpItemKindEnum guifg=#C3E88D guibg=#9FBD73
highlight! CmpItemKindKeyword guifg=#C3E88D guibg=#9FBD73

highlight! CmpItemKindConstant guifg=#FFE082 guibg=#D4BB6C
highlight! CmpItemKindConstructor guifg=#FFE082 guibg=#D4BB6C
highlight! CmpItemKindReference guifg=#FFE082 guibg=#D4BB6C

highlight! CmpItemKindFunction guifg=#EADFF0 guibg=#A377BF
highlight! CmpItemKindStruct guifg=#EADFF0 guibg=#A377BF
highlight! CmpItemKindClass guifg=#EADFF0 guibg=#A377BF
highlight! CmpItemKindModule guifg=#EADFF0 guibg=#A377BF
highlight! CmpItemKindOperator guifg=#EADFF0 guibg=#A377BF

highlight! CmpItemKindVariable guifg=#C5CDD9 guibg=#7E8294
highlight! CmpItemKindFile guifg=#C5CDD9 guibg=#7E8294

highlight! CmpItemKindUnit guifg=#F5EBD9 guibg=#D4A959
highlight! CmpItemKindSnippet guifg=#F5EBD9 guibg=#D4A959
highlight! CmpItemKindFolder guifg=#F5EBD9 guibg=#D4A959

highlight! CmpItemKindMethod guifg=#DDE5F5 guibg=#6C8ED4
highlight! CmpItemKindValue guifg=#DDE5F5 guibg=#6C8ED4
highlight! CmpItemKindEnumMember guifg=#DDE5F5 guibg=#6C8ED4

highlight! CmpItemKindInterface guifg=#D8EEEB guibg=#58B5A8
highlight! CmpItemKindColor guifg=#D8EEEB guibg=#58B5A8
highlight! CmpItemKindTypeParameter guifg=#D8EEEB guibg=#58B5A8

" a list of groups can be found at `:help nvim_tree_highlight`
lua << EOF

require("toggleterm").setup{
	open_mapping = [[<F4>]],
}

require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    -- show_current_context_start = true,
}

-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust", "scala", "org", "c_sharp" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
	additional_vim_regex_highlighting = {'org'},
  },
}

require('orgmode').setup({
  org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/Dropbox/org/refile.org',
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>ee', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-j>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>eq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Set up nvim-cmp.
local cmp = require'cmp'
local lspkind = require('lspkind')

cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
		completion = {
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		},
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    }),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. strings[1] .. " "
			kind.menu = "    (" .. strings[2] .. ")"

			return kind
		end,
	},
})

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

cmp.setup({
  sources = {
    { name = 'orgmode' }
  }
})


  -- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
local servers = { 'rust_analyzer', 'ccls', 'metals', 'bashls' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup { 
		capabilities = capabilities
	}
end


require('lspconfig').omnisharp.setup { 
	capabilities = capabilities,
	cmd = {"omnisharp"}
}

local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}

-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

local neogit = require('neogit')

neogit.setup {
	integrations = {
    -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
    -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
    --
    -- Requires you to have `sindrets/diffview.nvim` installed.
    -- use { 
    --   'TimUntersberger/neogit', 
    --   requires = { 
    --     'nvim-lua/plenary.nvim',
    --     'sindrets/diffview.nvim' 
    --   }
    -- }
    --
    diffview = true
  },
}

vim.o.updatetime = 300
-- vim.o.incsearch = false
vim.wo.signcolumn = 'yes'

-- require('vgit').setup({
--      "keymaps = {
--        "['n <C-k>'] = 'hunk_up',
--        "['n <C-j>'] = 'hunk_down',
--        "['n <leader>gs'] = 'buffer_hunk_stage',
--        "['n <leader>gr'] = 'buffer_hunk_reset',
--        "['n <leader>gp'] = 'buffer_hunk_preview',
--        "['n <leader>gb'] = 'buffer_blame_preview',
--        "['n <leader>gf'] = 'buffer_diff_preview',
--        "['n <leader>gh'] = 'buffer_history_preview',
--        "['n <leader>gu'] = 'buffer_reset',
--        "['n <leader>gg'] = 'buffer_gutter_blame_preview',
--        "['n <leader>gl'] = 'project_hunks_preview',
--        "['n <leader>gd'] = 'project_diff_preview',
--        "['n <leader>gq'] = 'project_hunks_qf',
--        "['n <leader>gx'] = 'toggle_diff_preference',
--        "},
--"})

require("telescope").load_extension "file_browser"

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require('leap').add_default_mappings()

local home = os.getenv('HOME')
local db = require('dashboard')

db.header_pad = 6

db.custom_center = {
      {icon = '  ',
      desc = 'Recently latest session                 ',
      shortcut = 'SPC s l',
      action ='SessionLoad'},
      {icon = '  ',
      desc = 'Recently opened files                   ',
      action =  'DashboardFindHistory',
      shortcut = 'SPC f o'},
      {icon = '  ',
      desc = 'Find File                               ',
      action = 'Telescope find_files find_command=rg,--hidden,--files',
      shortcut = 'SPC f f'},
      {icon = '  ',
      desc ='File Browser                            ',
      action =  'Telescope file_browser',
      shortcut = 'SPC f b'},
      {icon = '  ',
      desc = 'Find word                               ',
      action = 'Telescope live_grep',
      shortcut = 'SPC f g'},
      {icon = '  ',
      desc = 'Open Neovim Config                      ',
      action = 'e ' .. home .. '/.config/nvim/init.vim',
      shortcut = 'SPC f d'},
}

db.custom_header = {
\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
\}

EOF

