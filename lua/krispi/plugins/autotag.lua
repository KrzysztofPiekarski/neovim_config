return {
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-ts-autotag").setup({
        autotag = {
          enable = true,
          enable_rename = true,
          enable_close = true,
          enable_close_on_slash = false,
        },
      })
      
      -- Kolory Catppuccin Moka dla Autotag
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "Autotag", { fg = "#F5C2E7", bg = "#1E1E2E", bold = true })
        end,
      })
    end,
  },
}
