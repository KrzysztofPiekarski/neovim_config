return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  opts = {
    focus = true,
    -- Kolory Catppuccin Moka
    use_diagnostic_signs = true,
    icons = true,
    cycle_results = true,
    auto_preview = false,
    auto_fold = false,
    auto_open = false,
    include_declaration = false,
    include_type = false,
    include_definition = false,
    include_references = false,
    include_implementation = false,
    include_definition = false,
    include_declaration = false,
    include_type = false,
    include_references = false,
    include_implementation = false,
  },
  cmd = "Trouble",
  keys = {
    { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Open trouble document diagnostics" },
    { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Open trouble location list" },
    { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in trouble" },
  },
  config = function(_, opts)
    require("trouble").setup(opts)
    
    -- Kolory Catppuccin Moka dla Trouble
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "TroubleNormal", { bg = "#1E1E2E", fg = "#CDD6F4" })
        vim.api.nvim_set_hl(0, "TroubleCount", { bg = "#1E1E2E", fg = "#F9E2AF" })
        vim.api.nvim_set_hl(0, "TroubleText", { bg = "#1E1E2E", fg = "#CDD6F4" })
        vim.api.nvim_set_hl(0, "TroubleIndent", { bg = "#1E1E2E", fg = "#6C7086" })
        vim.api.nvim_set_hl(0, "TroubleFile", { bg = "#1E1E2E", fg = "#89B4FA" })
        vim.api.nvim_set_hl(0, "TroubleLocation", { bg = "#1E1E2E", fg = "#A6E3A1" })
        vim.api.nvim_set_hl(0, "TroublePreview", { bg = "#313244", fg = "#CDD6F4" })
        vim.api.nvim_set_hl(0, "TroubleCode", { bg = "#1E1E2E", fg = "#F5C2E7" })
        vim.api.nvim_set_hl(0, "TroubleSignError", { bg = "#1E1E2E", fg = "#F38BA8" })
        vim.api.nvim_set_hl(0, "TroubleSignWarning", { bg = "#1E1E2E", fg = "#F9E2AF" })
        vim.api.nvim_set_hl(0, "TroubleSignInformation", { bg = "#1E1E2E", fg = "#89DCEB" })
        vim.api.nvim_set_hl(0, "TroubleSignHint", { bg = "#1E1E2E", fg = "#A6E3A1" })
      end,
    })
  end,
}
