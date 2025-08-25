return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local toggleterm = require("toggleterm")
    
    toggleterm.setup({
      size = 20,
      open_mapping = [[<c-\>]], -- Ctrl+\ do otwierania/zamykania
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "horizontal", -- vertical, horizontal, tab, float
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })

    -- Funkcja do tworzenia konkretnego terminala
    local Terminal = require("toggleterm.terminal").Terminal

    -- Terminal w trybie float
    local float_term = Terminal:new({
      direction = "float",
      float_opts = {
        border = "double",
      },
      hidden = true,
    })

    local function float_toggle()
      float_term:toggle()
    end

    -- Terminal w trybie vertical
    local vertical_term = Terminal:new({
      direction = "vertical",
      size = vim.o.columns * 0.4,
      hidden = true,
    })

    local function vertical_toggle()
      vertical_term:toggle()
    end

    -- Terminal w trybie tab
    local tab_term = Terminal:new({
      direction = "tab",
      hidden = true,
    })

    local function tab_toggle()
      tab_term:toggle()
    end

    -- Ustawienia klawiszy
    local keymap = vim.keymap

    -- Główne mapowania
    keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
    keymap.set("n", "<leader>tf", function() float_toggle() end, { desc = "Toggle floating terminal" })
    keymap.set("n", "<leader>tv", function() vertical_toggle() end, { desc = "Toggle vertical terminal" })
    keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Toggle horizontal terminal" })
    keymap.set("n", "<leader>tb", function() tab_toggle() end, { desc = "Toggle terminal in new tab" })

    -- Mapowania w trybie terminal
    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      keymap.set('t', '<esc>', [[<C-\><C-n>]], opts) -- Escape do wyjścia z trybu insert
      keymap.set('t', 'jk', [[<C-\><C-n>]], opts) -- Alternatywne wyjście
      keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts) -- Nawigacja między oknami
      keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts) -- Przełączanie okien
    end

    -- Automatyczne ustawienie mapowań dla terminala
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end,
}