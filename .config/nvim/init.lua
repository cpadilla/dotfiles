--========================================
--   inti.lua
--   created by Christofer Padilla
--========================================

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Load lazy.nvim
require("config.lazy")
require("lazy").setup("plugins")
require("keys")

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

--========================================
--   		Plugins
--========================================

-- require'lspconfig'.ts_ls.setup {}

-- Mason Setup
require("mason").setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})

require("mason-lspconfig").setup({
  automatic_installation = false,
  handlers = {
    -- Disable default setup for ts_ls
    ["tsserver"] = function() end,
    ["ts_ls"] = function() end,
  },
})

-- Force-load cmp-nvim-lsp to ensure capabilities are ready
require("cmp_nvim_lsp")

-- Completion Capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function on_attach(client, bufnr)
  print("LSP attached: " .. client.name)
end

require("typescript-tools").setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeCompletionsForModuleExports = true,
      quotePreference = "auto",
    },
    tsserver_format_options = {
      allowIncompleteCompletions = false,
      allowRenameOfImportPath = true,
    },
  },
})

require("lsp_signature").setup()

-- LSP Diagnostics Config
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

vim.cmd [[autocmd CompleteDone * lua print("Completion Done")]]

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

-- Commenting out for now until I can figure out what characters will render
-- sign({name = 'DiagnosticSignError', text = ''})
-- sign({name = 'DiagnosticSignWarn', text = ''})
-- sign({name = 'DiagnosticSignHint', text = ''})
-- sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Completion Plugin Setup
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})

-- Treesitter Plugin Setup 
require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust", "toml" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false,
  },
  ident = { enable = true }, 
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

--========================================
--   		Settings
--========================================

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Always use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Reload files changed outside vim
vim.opt.autoread = true
vim.cmd([[
" Triger `autoread` when files changes on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
]])

-- Hide markdown syntax
vim.opt.cole=3

vim.opt.wrap=true

vim.opt.mouse=a
vim.opt.nu=true

vim.opt.expandtab=true
vim.opt.tabstop=4
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.smarttab=true

-- Disable pause after pressing space
vim.o.timeoutlen = 100

-- Display tabs and trailing spaces visually
vim.cmd([[set list listchars=tab:\ \ ,trail:·]])

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300) 

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error 
-- Show inlay_hints more frequently 
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Treesitter folding 
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- Vimspector options
vim.g.vimspector_sidebar_width = 85
vim.g.vimspector_bottombar_height = 15
vim.g.vimspector_terminal_maxwidth = 70

--========================================
--                Commands
--========================================
-- command to pipe selection into BC
-- currently doesn't support multiple lines
-- because of ^M somewhere along the way
vim.cmd([[
function BC() range
    " let ans = system('echo scale=6\;'.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| bc -l')
    let ans = system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| bc -l')
    normal '>
    put ='=='
    put =ans
endfunction
com -range=% -nargs=0 BC :<line1>,<line2>call BC()
]])

--========================================
--                Folds
--========================================
vim.cmd([[hi Folded ctermbg=0]])


vim.o.foldmethod=syntax

-- Ignorecase when searching
vim.o.ignorecase=true

-- incremental search - Vim starts searching when we start typing
vim.o.incsearch=true

-- When searching try to be smart about cases
vim.o.smartcase=true

-- Highlight search results
vim.o.hlsearch=true

-- Open all folds by default
vim.o.foldenable=false

--========================================
--                Swap files
--========================================
-- Turn off swap files
vim.o.swapfile=false
vim.o.backup=false
vim.o.wb=false
