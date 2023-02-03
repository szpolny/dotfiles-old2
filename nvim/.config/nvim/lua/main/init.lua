require("main.packer")

-- Treesitter config
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  sync_install = false,
  auto_install = true,
 
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- Vim settings
vim.opt.termguicolors = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.showmode = false

vim.opt.mouse = 'a'

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Theme
require('onedark').setup({transparent = true})

require('onedark').load()
local color = "onedark"
vim.cmd.colorscheme(color)

-- Filetree
require("nvim-tree").setup()

-- lualine
require('lualine').setup({
    options = {
        theme = color
    }
})

-- LSP
require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end 
}

-- CMP
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

---------------------------
-- Keymaps
---------------------------
vim.g.mapleader = " "

-- Navigating between windows
vim.keymap.set('n', '<C-h>', "<C-w>h", {desc = "switch left"})
vim.keymap.set('n', '<C-j>', "<C-w>j", {desc = "switch down"})
vim.keymap.set('n', '<C-k>', "<C-w>k", {desc = "switch up"})
vim.keymap.set('n', '<C-l>', "<C-w>l", {desc = "switch right"})

-- Telescope keymaps
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
