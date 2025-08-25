-- Główny plik inicjalizacji Neovim
-- Przyspieszenie startu przez cache'owanie skompilowanych plików Lua
vim.loader.enable()

-- Ustawienia podstawowe (muszą być przed załadowaniem pluginów)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Dodaj ścieżkę do modułów Lua
package.path = package.path .. ";" .. vim.fn.stdpath("config") .. "/lua/?.lua;" .. vim.fn.stdpath("config") .. "/lua/?/init.lua"

-- Załaduj podstawową konfigurację
require("krispi.core.init")

-- Załaduj pluginy
require("krispi.lazy")
