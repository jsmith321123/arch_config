vim.opt.colorcolumn="81"
vim.opt.textwidth=80
vim.wo.number=true
vim.wo.relativenumber=true

vim.cmd([[
highlight ColorColumn ctermbg=8
set signcolumn=yes
set numberwidth=4
]])

vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.autoindent=true
vim.opt.smartindent=true
vim.opt.expandtab=true
vim.opt.wrap=false
vim.opt.termguicolors = true 

vim.api.nvim_set_keymap("n", "<C-Left>", ":tabprev<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Right>", ":tabnext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Up>", ":tabnew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Down>", ":tabclose<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<C-P>", ":Telescope find_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-F>", ":Telescope live_grep<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<C-K>", ":call CocActionAsync('doHover')<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-J>", "<Plug>(coc-codeaction-cursor)", { noremap = true })

vim.api.nvim_set_keymap("n", "<C-O>", ":Neoformat<CR>", { noremap = true })

vim.cmd([[
call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'prettier/vim-prettier'
Plug 'stevearc/conform.nvim'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

Plug 'folke/tokyonight.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()
]])

vim.cmd([[
colorscheme tokyonight-storm

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
]])

require('lualine').setup {
    options = { 
        theme = 'onedark', 
        section_separators = '',
        component_separators = '', 
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
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

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c_sharp", "typescript", "html" },

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

require("conform").setup({
  formatters = {
    csharpier = function()
      local useDotnet = not vim.fn.executable("csharpier")

      local command = useDotnet and "dotnet csharpier" or "csharpier"

      local version_out = vim.fn.system(command .. " --version")

      --NOTE: system command returns the command as the first line of the result, need to get the version number on the final line
      local version_result = version_out[#version_out]
      local major_version = tonumber((version_out or ""):match("^(%d+)")) or 0
      local is_new = major_version >= 1

      local args = is_new and { "format", "$FILENAME" } or { "--write-stdout" }

      return {
          command = command,
          args = args,
          stdin = not is_new,
          require_cwd = false,
      }
    end,
  },
  formatters_by_ft = {
    cs = { 'csharpier' },
    typescript = { "prettier", stop_after_first = true },
    typescriptreact = { "prettier", stop_after_first = true },
    javascript = { "prettier", stop_after_first = true },
    html = { "prettier", stop_after_first = true },
    scss = { "prettier", stop_after_first = true },
    css = { "prettier", stop_after_first = true },
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
