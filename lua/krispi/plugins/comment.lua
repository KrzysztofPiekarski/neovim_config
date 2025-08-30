return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local comment = require("Comment")

      comment.setup({
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
          line = "<leader>cc",
          block = "<leader>cb",
        },
        opleader = {
          line = "<leader>c",
          block = "<leader>cb",
        },
        extra = {
          above = "<leader>cO",
          below = "<leader>co",
          eol = "<leader>cA",
        },
        mappings = {
          basic = true,
          extra = true,
          extended = false,
        },
      })
      
      -- Kolory Catppuccin Moka dla Comment
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "Comment", { fg = "#6C7086", italic = true })
        end,
      })
    end,
  },
}
