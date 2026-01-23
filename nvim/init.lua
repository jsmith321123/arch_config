vim.cmd([[
call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'

Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()
]])

vim.opt.colorcolumn="81"
vim.wo.number=true
vim.wo.relativenumber=true

vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.autoindent=true
vim.opt.smartindent=true
vim.opt.expandtab=true
vim.opt.wrap=false
vim.opt.termguicolors=true 

vim.lsp.enable('ts_ls')
-- vim.lsp.enable('angularls')
vim.lsp.enable('csharp_ls')
vim.lsp.enable('clangd')

vim.api.nvim_set_keymap("n", "<C-P>", ":Telescope find_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-F>", ":Telescope live_grep<CR>", { noremap = true })

-- require('lualine').setup {
--     options = { 
--         theme = 'onedark', 
--         section_separators = '',
--         component_separators = '', 
--     },
--     sections = {
--         lualine_a = {'mode'},
--         lualine_b = {},
--         lualine_c = {'filename'},
--         lualine_x = {'encoding', 'fileformat', 'filetype'},
--         lualine_y = {'progress'},
--         lualine_z = {'location'}
--     },
--     inactive_sections = {
--         lualine_a = {},
--         lualine_b = {},
--         lualine_c = {'filename'},
--         lualine_x = {'location'},
--         lualine_y = {},
--         lualine_z = {}
--     },
-- }

vim.cmd([[
colorscheme vim
set signcolumn=yes
set numberwidth=4
highlight ColorColumn guibg=LightGray guifg=Black
]])

require'nvim-treesitter'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c_sharp", "typescript", "html", "c" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = {  },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {  },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}


-- 
-- LSP COMPLETION
--

vim.opt.completeopt = {'menu', 'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess:append('c')

local function tab_complete()
  if vim.fn.pumvisible() == 1 then
    -- navigate to next item in completion menu
    return '<Down>'
  end

  local c = vim.fn.col('.') - 1
  local is_whitespace = c == 0 or vim.fn.getline('.'):sub(c, c):match('%s')

  if is_whitespace then
    -- insert tab
    return '<Tab>'
  end

  local lsp_completion = vim.bo.omnifunc == 'v:lua.vim.lsp.omnifunc'

  if lsp_completion then
    -- trigger lsp code completion
    return '<C-x><C-o>'
  end

  -- suggest words in current buffer
  return '<C-x><C-n>'
end

local function tab_prev()
  if vim.fn.pumvisible() == 1 then
    -- navigate to previous item in completion menu
    return '<Up>'
  end

  -- insert tab
  return '<Tab>'
end

vim.keymap.set('i', '<Tab>', tab_complete, {expr = true})
vim.keymap.set('i', '<S-Tab>', tab_prev, {expr = true})


