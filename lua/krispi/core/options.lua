-- Podstawowe opcje Neovim
local opt = vim.opt
local g = vim.g

-- Ustawienia podstawowe
opt.mouse = "a" -- Włącz mysz
opt.clipboard = "unnamedplus" -- Użyj systemowego schowka
opt.swapfile = false -- Wyłącz pliki swap
opt.backup = false -- Wyłącz backup
opt.undofile = true -- Włącz undo history
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Opcje edycji
opt.expandtab = true -- Użyj spacji zamiast tabów
opt.shiftwidth = 2 -- Szerokość wcięcia
opt.tabstop = 2 -- Szerokość taba
opt.softtabstop = 2 -- Szerokość soft taba
opt.autoindent = true -- Automatyczne wcięcie
opt.smartindent = true -- Inteligentne wcięcie
opt.wrap = false -- Nie zawijaj linii
opt.linebreak = true -- Zawijaj w słowach
opt.breakindent = true -- Zachowaj wcięcie przy zawijaniu

-- Opcje wyszukiwania
opt.ignorecase = true -- Ignoruj wielkość liter
opt.smartcase = true -- Uwzględniaj wielkość liter jeśli są duże
opt.incsearch = true -- Wyszukiwanie inkrementalne
opt.hlsearch = true -- Podświetl wyniki wyszukiwania

-- Opcje UI
opt.number = true -- Pokaż numery linii
opt.relativenumber = true -- Relatywne numery linii
opt.cursorline = true -- Podświetl aktualną linię
opt.cursorcolumn = false -- Nie podświetlaj kolumny
opt.signcolumn = "yes" -- Pokaż kolumnę znaków
opt.showmatch = true -- Pokaż dopasowania nawiasów
opt.matchtime = 2 -- Czas pokazywania dopasowania
opt.showmode = false -- Nie pokazuj trybu (lualine to robi)
opt.showcmd = true -- Pokaż komendy
opt.laststatus = 3 -- Globalny statusline
opt.ruler = false -- Nie pokazuj linijki (lualine to robi)
opt.scrolloff = 8 -- Minimalna liczba linii nad/pod kursorem
opt.sidescrolloff = 8 -- Minimalna liczba kolumn obok kursora
opt.list = false -- Nie pokazuj niewidocznych znaków
opt.listchars = { tab = "→ ", eol = "↵", trail = "·", extends = "⟩", precedes = "⟨" }

-- Opcje okien
opt.splitbelow = true -- Split poniżej
opt.splitright = true -- Split po prawej
opt.winblend = 0 -- Przezroczystość okien
opt.pumblend = 0 -- Przezroczystość menu
opt.termguicolors = true -- Prawdziwe kolory w terminalu

-- Opcje wydajności
opt.hidden = true -- Pozwól na przełączanie buforów bez zapisywania
opt.updatetime = 300 -- Czas aktualizacji swap
opt.timeoutlen = 1000 -- Czas timeout dla mapowań
opt.ttimeoutlen = 0 -- Czas timeout dla key codes

-- Opcje sesji
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Go environment variables
vim.env.GOROOT = "/usr/lib/go"
vim.env.GOPATH = vim.fn.expand("~/go")
vim.env.GOBIN = vim.fn.expand("~/go/bin")
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.expand("~/go/bin")

-- Ustawienia globalne
g.mapleader = " "
g.maplocalleader = " "

-- Wyłącz niektóre wbudowane pluginy Neovim dla lepszej wydajności
local disabled_built_ins = {
  "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
  "gzip", "zip", "zipPlugin", "tar", "tarPlugin",
  "getscript", "getscriptPlugin", "vimball", "vimballPlugin",
  "2html_plugin", "logiPat", "rrhelper", "spellfile_plugin", "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

-- Ustawienia highlight groups dla Catppuccin Moka
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- Lepsze kolory dla różnych elementów
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#6C7086" })
    vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none", fg = "#A6ADC8" })
    
    -- Lepsze kolory dla cursorline
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#313244", sp = "#6C7086" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#A6ADC8", bg = "#313244", bold = true })
    
    -- Lepsze kolory dla search
    vim.api.nvim_set_hl(0, "Search", { bg = "#89B4FA", fg = "#1E1E2E" })
    vim.api.nvim_set_hl(0, "IncSearch", { bg = "#45475A", fg = "#1E1E2E" })
    
    -- Lepsze kolory dla git signs
    vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#A6E3A1" })
    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#FAB387" })
    vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#F38BA8" })
    
    -- Lepsze kolory dla indent guides
    vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#585B70", nocombine = true })
    vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#6C7086", nocombine = true })
    
    -- Lepsze kolory dla winbar
    vim.api.nvim_set_hl(0, "WinBar", { fg = "#A6ADC8", bg = "none" })
    vim.api.nvim_set_hl(0, "WinBarNC", { fg = "#7F849C", bg = "none" })
  end,
})

-- Options loaded silently
