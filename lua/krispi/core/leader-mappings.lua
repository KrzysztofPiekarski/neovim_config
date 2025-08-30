-- Centralne mapowania leader dla całej konfiguracji Neovim
-- Ten plik zawiera wszystkie mapowania <leader> w jednym miejscu

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- PLIKI I WYSZUKIWANIE
-- ============================================================================
-- Telescope - wyszukiwanie plików
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files", noremap = true, silent = true })
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files", noremap = true, silent = true })
keymap("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep", noremap = true, silent = true })
keymap("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Grep String", noremap = true, silent = true })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers", noremap = true, silent = true })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags", noremap = true, silent = true })
keymap("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Marks", noremap = true, silent = true })
keymap("n", "<leader>fv", "<cmd>Telescope vim_options<cr>", { desc = "Vim Options", noremap = true, silent = true })
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps", noremap = true, silent = true })
keymap("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Todos", noremap = true, silent = true })

-- Git files
keymap("n", "<leader>gf", "<cmd>Telescope git_files<cr>", { desc = "Git Files", noremap = true, silent = true })

-- ============================================================================
-- BUFERY I OKNA
-- ============================================================================
-- Zarządzanie buforami
keymap("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer", noremap = true, silent = true })
keymap("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous Buffer", noremap = true, silent = true })
keymap("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer", noremap = true, silent = true })

-- Zarządzanie oknami
keymap("n", "<leader>ws", "<cmd>split<cr>", { desc = "Split Horizontal", noremap = true, silent = true })
keymap("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Split Vertical", noremap = true, silent = true })
keymap("n", "<leader>wq", "<cmd>close<cr>", { desc = "Close Window", noremap = true, silent = true })

-- Tabs
keymap("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab", noremap = true, silent = true })
keymap("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab", noremap = true, silent = true })
keymap("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab", noremap = true, silent = true })
keymap("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab", noremap = true, silent = true })
-- Note: <leader>tf is handled in core/keymaps.lua to avoid conflicts

-- ============================================================================
-- LSP I PROGRAMOWANIE
-- ============================================================================
-- LSP podstawowe
keymap("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Go to Definition", noremap = true, silent = true })
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>", { desc = "References", noremap = true, silent = true })
keymap("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Hover", noremap = true, silent = true })
keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { desc = "Signature Help", noremap = true, silent = true })
keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code Action", noremap = true, silent = true })
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", { desc = "Format", noremap = true, silent = true })

-- ============================================================================
-- GIT
-- ============================================================================
-- Git podstawowe
keymap("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Git Status", noremap = true, silent = true })
keymap("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "Git Commit", noremap = true, silent = true })
keymap("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Git Push", noremap = true, silent = true })
keymap("n", "<leader>gl", "<cmd>Git pull<cr>", { desc = "Git Pull", noremap = true, silent = true })

-- Gitsigns
keymap("n", "<leader>gd", "<cmd>Gdiffsplit<cr>", { desc = "Git Diff Split", noremap = true, silent = true })
keymap("n", "<leader>gh", "<cmd>0Gclog<cr>", { desc = "Git File History", noremap = true, silent = true })

-- ============================================================================
-- TERMINAL
-- ============================================================================
-- Terminal
keymap("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal", noremap = true, silent = true })
-- Note: <leader>tf is handled in core/keymaps.lua to avoid conflicts

-- ============================================================================
-- KONFIGURACJA
-- ============================================================================
-- Neovim config
keymap("n", "<leader>cs", "<cmd>source ~/.config/nvim/init.lua<cr>", { desc = "Source Config", noremap = true, silent = true })
keymap("n", "<leader>ce", "<cmd>edit ~/.config/nvim/init.lua<cr>", { desc = "Edit Config", noremap = true, silent = true })

-- ============================================================================
-- EKSPLORATOR PLIKÓW
-- ============================================================================
-- Nvim-tree
keymap("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer", noremap = true, silent = true })
keymap("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Find File in Explorer", noremap = true, silent = true })
keymap("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse Explorer", noremap = true, silent = true })
keymap("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh Explorer", noremap = true, silent = true })

-- ============================================================================
-- FORMATOWANIE I LINTING
-- ============================================================================
-- Formatowanie
keymap({ "n", "v" }, "<leader>mp", function()
  require("conform").format({ lsp_fallback = true, async = false })
end, { desc = "Format Code", noremap = true, silent = true })

-- ============================================================================
-- PYTHON
-- ============================================================================
-- Python debugging
keymap("n", "<leader>dpr", function() require('dap-python').test_method() end, { desc = "Debug Python Test Method", noremap = true, silent = true })
keymap("n", "<leader>dpc", function() require('dap-python').test_class() end, { desc = "Debug Python Test Class", noremap = true, silent = true })
keymap("v", "<leader>dps", function() require('dap-python').debug_selection() end, { desc = "Debug Python Selection", noremap = true, silent = true })

-- Python refactoring
keymap("x", "<leader>re", "<cmd>lua require('refactoring').refactor('Extract Function')<CR>", { desc = "Extract Function", noremap = true, silent = true })
keymap("x", "<leader>ref", "<cmd>lua require('refactoring').refactor('Extract Function To File')<CR>", { desc = "Extract Function To File", noremap = true, silent = true })
keymap("x", "<leader>rv", "<cmd>lua require('refactoring').refactor('Extract Variable')<CR>", { desc = "Extract Variable", noremap = true, silent = true })

-- Python environment
keymap("n", "<leader>ve", "<cmd>lua require('swenv.api').pick_venv()<CR>", { desc = "Choose Python venv", noremap = true, silent = true })

-- Python REPL
keymap("n", "<leader>rf", "<cmd>IronFocus<CR>", { desc = "Focus Python REPL", noremap = true, silent = true })

-- Python docstrings
keymap("n", "<leader>nf", "<cmd>lua require('neogen').generate()<CR>", { desc = "Generate docstring", noremap = true, silent = true })

-- ============================================================================
-- GO
-- ============================================================================
-- Go commands
keymap("n", "<leader>go", "<cmd>GoFmt<CR>", { desc = "Go Format", noremap = true, silent = true })
keymap("n", "<leader>gF", "<cmd>GoFillStruct<CR>", { desc = "Go Fill Struct", noremap = true, silent = true })
keymap("n", "<leader>gS", "<cmd>GoFillSwitch<CR>", { desc = "Go Fill Switch", noremap = true, silent = true })
-- Note: <leader>gT is handled in go.lua to avoid conflicts

-- ============================================================================
-- C++
-- ============================================================================
-- C++ commands
keymap("n", "<leader>ch", "<cmd>Ouroboros<CR>", { desc = "Switch Header/Source", noremap = true, silent = true })

-- ============================================================================
-- JAVA
-- ============================================================================
-- Java commands
keymap("n", "<leader>ju", "<cmd>JdtUpdateConfig<CR>", { desc = "Update Java Config", noremap = true, silent = true })
keymap("n", "<leader>jt", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", { desc = "Test Java Method", noremap = true, silent = true })
keymap("n", "<leader>jw", "<cmd>lua require('jdtls').compile('full')<CR>", { desc = "Compile Java", noremap = true, silent = true })

-- ============================================================================
-- RUST
-- ============================================================================
-- Rust commands
keymap("n", "<leader>rt", function() require('rust-tools').open_cargo_toml.open_cargo_toml() end, { desc = "Open Cargo.toml", noremap = true, silent = true })
keymap("n", "<leader>rr", function() require('rust-tools').runnables.runnables() end, { desc = "Rust Runnables", noremap = true, silent = true })

-- ============================================================================
-- SSH
-- ============================================================================
-- SSH commands
keymap("n", "<leader>sc", "<cmd>DistantConnect<CR>", { desc = "SSH Connect", noremap = true, silent = true })
keymap("n", "<leader>sd", "<cmd>DistantDisconnect<CR>", { desc = "SSH Disconnect", noremap = true, silent = true })
keymap("n", "<leader>sl", "<cmd>DistantList<CR>", { desc = "SSH List connections", noremap = true, silent = true })
keymap("n", "<leader>so", "<cmd>DistantOpen<CR>", { desc = "SSH Open file/directory", noremap = true, silent = true })
keymap("n", "<leader>sb", "<cmd>DistantBrowse<CR>", { desc = "SSH Browse remote directory", noremap = true, silent = true })
keymap("n", "<leader>st", "<cmd>DistantShell<CR>", { desc = "SSH Terminal", noremap = true, silent = true })

-- ============================================================================
-- NEORG
-- ============================================================================
-- Neorg commands
keymap("n", "<leader>or", "<cmd>Neorg return<CR>", { desc = "Return to previous buffer", noremap = true, silent = true })
keymap("n", "<leader>of", "<cmd>Neorg workspace<CR>", { desc = "Open Neorg workspace", noremap = true, silent = true })
keymap("n", "<leader>on", "<cmd>Neorg journal<CR>", { desc = "Open Neorg journal", noremap = true, silent = true })
keymap("n", "<leader>ot", "<cmd>Neorg todo<CR>", { desc = "Open Neorg todo", noremap = true, silent = true })
keymap("n", "<leader>os", "<cmd>Neorg search<CR>", { desc = "Search Neorg files", noremap = true, silent = true })
keymap("n", "<leader>oem", "<cmd>Neorg export to-file<CR>", { desc = "Export to markdown", noremap = true, silent = true })

-- ============================================================================
-- CODEIUM
-- ============================================================================
-- Codeium commands
keymap('v', '<leader>cr', '<cmd>Codeium Refactor<cr>', { desc = "Refactor selected code", noremap = true, silent = true })

-- ============================================================================
-- MQL5
-- ============================================================================
-- MQL5 commands
keymap("n", "<leader>mt", function() require('mql5').test() end, { desc = "MQL5 Test", noremap = true, silent = true })

-- ============================================================================
-- POMOC
-- ============================================================================
-- Help
keymap("n", "<leader>?", "<cmd>WhichKey<cr>", { desc = "Show Which-Key", noremap = true, silent = true })

-- ============================================================================
-- NARZĘDZIA
-- ============================================================================
-- Maximizer
keymap("n", "<leader>m", "<cmd>MaximizerToggle<CR>", { desc = "Toggle Maximizer", noremap = true, silent = true })

-- Trouble
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble", noremap = true, silent = true })
keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace Diagnostics", noremap = true, silent = true })
keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document Diagnostics", noremap = true, silent = true })

-- ============================================================================
-- INNE
-- ============================================================================
-- File info
keymap("n", "<leader>fi", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "File Info", noremap = true, silent = true })

-- Leader mappings loaded silently
