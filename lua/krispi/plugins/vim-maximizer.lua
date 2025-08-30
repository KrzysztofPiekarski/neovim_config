return {
  "szw/vim-maximizer",
  keys = {
    { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
  },
  config = function()
    -- Kolory Catppuccin Moka dla Maximizer
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "Maximizer", { fg = "#CBA6F7", bg = "#1E1E2E", bold = true })
      end,
    })
  end,
}
