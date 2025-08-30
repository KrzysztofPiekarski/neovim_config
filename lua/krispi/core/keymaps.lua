-- Podstawowe mapowania klawiszy Neovim
-- Ten plik zawiera podstawowe skróty klawiszowe

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Smooth scrolling with neoscroll
keymap.set("n", "<C-u>", "<cmd>lua require('neoscroll').scroll(-vim.api.nvim_win_get_height(0), true, 300, [['cubic']])<CR>", { desc = "Scroll up smoothly" })
keymap.set("n", "<C-d>", "<cmd>lua require('neoscroll').scroll(vim.api.nvim_win_get_height(0), true, 300, [['cubic']])<CR>", { desc = "Scroll down smoothly" })
keymap.set("n", "<C-b>", "<cmd>lua require('neoscroll').scroll(-vim.api.nvim_win_get_height(0), true, 300, [['cubic']])<CR>", { desc = "Scroll up smoothly" })
keymap.set("n", "<C-f>", "<cmd>lua require('neoscroll').scroll(vim.api.nvim_win_get_height(0), true, 300, [['cubic']])<CR>", { desc = "Scroll down smoothly" })

-- Center view after jumping
keymap.set("n", "G", "Gzz", { desc = "Go to end and center view" })
keymap.set("n", "gg", "ggzz", { desc = "Go to beginning and center view" })
keymap.set("n", "n", "nzz", { desc = "Next search result and center view" })
keymap.set("n", "N", "Nzz", { desc = "Previous search result and center view" })
keymap.set("n", "*", "*zz", { desc = "Search word under cursor and center view" })
keymap.set("n", "#", "#zz", { desc = "Search word under cursor backwards and center view" })
