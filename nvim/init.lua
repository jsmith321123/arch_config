vim.cmd([[
call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'stevearc/conform.nvim'
Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

Plug 'folke/tokyonight.nvim'
Plug 'mellow-theme/mellow.nvim'
Plug 'morhetz/gruvbox'
Plug 'dchinmay2/alabaster.nvim'
Plug 'tree-sitter/tree-sitter-c-sharp'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'RRethy/base16-nvim'

call plug#end()
]])

vim.opt.textwidth=80
vim.wo.number=false

vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.autoindent=true
vim.opt.smartindent=true
vim.opt.expandtab=true
vim.opt.wrap=false
vim.opt.termguicolors = true
vim.opt.relativenumber = false
vim.opt.title = true

vim.cmd('colorscheme base16-0x96f')
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "RedundantWhitespace", { bg = "Gray", ctermbg = "Gray" })
vim.cmd([[match RedundantWhitespace /\s\+$\| \+\ze\t/]])

-- LSP languages
vim.lsp.enable('ts_ls');
vim.lsp.enable('csharp_ls');
vim.lsp.enable('clangd');
--

vim.api.nvim_set_keymap("n", "<C-Left>", ":tabprev<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Right>", ":tabnext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Up>", ":tab split<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Down>", ":tabclose<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<C-P>", ":Telescope find_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-F>", ":Telescope live_grep<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<C-J>", ":lua vim.lsp.buf.code_action()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-K>", ":lua vim.lsp.buf.hover()<CR>", { noremap = true })

-- vim.cmd([[
-- colorscheme vim
-- ]])
-- vim.cmd([[
-- colorscheme slate
-- ]])
-- vim.cmd([[
-- colorscheme lunaperche
-- ]])
-- vim.cmd([[
-- colorscheme alabaster
-- ]])

require('lualine').setup {
    options = { 
        theme = 'base16',
        section_separators = '',
        component_separators = '',
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'branch', 'diff', 'diagnostics', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
}

require("conform").setup({
  formatters_by_ft = {
    -- Conform will run the first available formatter
    javascript = { "prettier", stop_after_first = true },
    typescript = { "prettier", stop_after_first = true },
    typescriptangular = { "prettier", stop_after_first = true },
    javascriptreact = { "prettier", stop_after_first = true },
    typescriptreact = { "prettier", stop_after_first = true },
    json = { "prettier", stop_after_first = true },
    htmlangular = { "prettier", stop_after_first = true },
    html = { "prettier", stop_after_first = true },
    scss = { "prettier", stop_after_first = true },
    css = { "prettier", stop_after_first = true },
    cs = { "csharpier", stop_after_first = true },
  },
  format_on_save = {
    lsp_format = "fallback",
  },
})

-- show errors on cursor hold
-- vim.api.nvim_create_autocmd("CursorHold", {
--   buffer = bufnr,
--   callback = function()
--     local opts = {
--       focusable = false,
--       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--       border = 'rounded',
--       source = 'always',
--       prefix = ' ',
--       scope = 'cursor',
--     }
--     vim.diagnostic.open_float(nil, opts)
--   end,
-- })

-- Decrease updatetime for a faster response (default is 4000ms)
vim.o.updatetime = 300

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anvim redundant whitespace highlightnonymous"](args.body) -- For `vsnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
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
  }, {
    { name = 'buffer' },
  })
})


-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
