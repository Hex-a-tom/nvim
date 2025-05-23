-- Source: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local function map(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.silent = opts.silent ~= false
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
-- map("n", "<C-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
-- map("n", "<C-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
-- map("i", "<C-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
-- map("i", "<C-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
-- map("v", "<C-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
-- map("v", "<C-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
map("n", "<A-,>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<A-.>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

map("n", "<leader>bk", "<cmd>Bclose<cr>", { desc = "Kill buffer" })

-- Clear search with <esc>
map("n" , "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- indent text when pasting
-- map("n", "p", "p'[v']=")

-- saner behavior of visual mode paste
map("x", "p", "P")

-- multible cursor emulation
map("n", "c*", "*``cgn")
map("n", "c#", "#``cgn")

-- redo
map("n", "<S-U>", "<C-R>")

-- easier start and end of line
map("n", "H", "^")
map("n", "L", "$")

-- throwaway macro
map("n", "Q", "@q")

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
