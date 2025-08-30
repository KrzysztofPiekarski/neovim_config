return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },
    window = {
      border = "rounded",
      padding = { 1, 2 },
    },
    layout = {
      width = { min = 20 },
      spacing = 3,
    },
  },
  config = function(_, opts)
    -- Dodaj lepszą obsługę błędów
    local ok, which_key = pcall(require, "which-key")
    if not ok then
      print("❌ Failed to load which-key")
      return
    end

    -- Upewnij się, że wszystkie zależności są gotowe
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        -- Opóźnij setup which-key do momentu gdy wszystko jest gotowe
        vim.defer_fn(function()
          local setup_ok, setup_result = pcall(function()
            which_key.setup(opts)
          end)
          
          if not setup_ok then
            print("❌ Failed to setup which-key:", setup_result)
            return
          end
          
          -- Which-key configured silently
        end, 100) -- 100ms opóźnienie
      end,
      once = true,
    })
    
    -- Kolory Catppuccin Moka dla Which-Key
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "WhichKey", { bg = "#1E1E2E", fg = "#CDD6F4" })
        vim.api.nvim_set_hl(0, "WhichKeyGroup", { bg = "#1E1E2E", fg = "#CBA6F7", bold = true })
        vim.api.nvim_set_hl(0, "WhichKeyDesc", { bg = "#1E1E2E", fg = "#89B4FA" })
        vim.api.nvim_set_hl(0, "WhichKeySeparator", { bg = "#1E1E2E", fg = "#6C7086" })
        vim.api.nvim_set_hl(0, "WhichKeyBorder", { bg = "#1E1E2E", fg = "#6C7086" })
        vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "#1E1E2E" })
        vim.api.nvim_set_hl(0, "WhichKeyValue", { bg = "#1E1E2E", fg = "#A6E3A1" })
      end,
    })
  end,
}
