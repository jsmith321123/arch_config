--vim.opt.colorcolumn="80"
vim.opt.textwidth=80

-- vim.cmd([[
-- highlight ColorColumn ctermbg=8
-- ]])

vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.autoindent=true
vim.opt.smartindent=true
vim.opt.expandtab=true
vim.opt.wrap=true


vim.api.nvim_set_keymap("n", "<C-Left>", ":tabprev<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Right>", ":tabnext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Up>", ":tabnew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-Down>", ":tabclose<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<C-P>", ":Telescope find_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-F>", ":Telescope live_grep<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<C-K>", ":call CocActionAsync('doHover')<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-J>", "<Plug>(coc-codeaction-cursor)", { noremap = true })

vim.api.nvim_set_keymap("n", "<Leader>p", ":Neoformat<CR>", { noremap = true })

vim.cmd([[
call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'prettier/vim-prettier'
Plug 'sbdchd/neoformat'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

call plug#end()
]])

vim.cmd([[
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
    options = { theme = 'modus-vivendi' }
}
