--------------
-- Settings --
--------------
-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- No backups and swapfile
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Auto read file on change
vim.opt.autoread = true

-- 24-bit color
vim.opt.termguicolors = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- vim.opt.hlsearch = true

-- Indent
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Clipboard behaviour
vim.opt.clipboard = "unnamedplus"

-- Show trailing spaces
vim.opt.list = true
vim.opt.listchars = { tab = '··', trail = ' ' }
vim.api.nvim_set_hl(0, 'TrailingWhitespace', { bg = 'LightRed' })
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  command = [[
		syntax clear TrailingWhitespace |
		syntax match TrailingWhitespace "\_s\+$"
	]]
})

-- Cursor line
vim.opt.cursorline = true
-- vim.opt.cursorcolumn = true

-----------------
-- Keybindings --
-----------------
-- Leader key
vim.g.mapleader = " "

-- Stop the highlighting
vim.keymap.set("n", "<esc>", ":noh<CR>", { desc = "Unselect", silent = true })

-- Save
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save File", silent = true })

-- Open new tab
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "Create New Tab", silent = true })

-- Close tab
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close Current Tab", silent = true })

-- Russian layout support
local function escape(str)
  local escape_chars = [[;,.'|\]]
  return vim.fn.escape(str, escape_chars)
end
local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>$]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;]]
vim.opt.langmap = vim.fn.join({
  escape(ru_shift) .. ";" .. escape(en_shift),
  escape(ru) .. ";" .. escape(en),
}, ",")
