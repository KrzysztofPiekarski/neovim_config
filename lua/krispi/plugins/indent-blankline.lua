return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = { char = "┊" },
    scope = { enabled = true, char = "│" },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  },
  config = function(_, opts)
    require("ibl").setup(opts)
    
    -- Kolory Catppuccin Moka dla Indent Blankline
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#585B70", nocombine = true })
        vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#6C7086", nocombine = true })
        vim.api.nvim_set_hl(0, "IndentBlanklineSpaceChar", { fg = "#585B70", nocombine = true })
        vim.api.nvim_set_hl(0, "IndentBlanklineSpaceCharBlankline", { fg = "#585B70", nocombine = true })
      end,
    })
  end,
}
