return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo_comments = require("todo-comments")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })

    keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })

    todo_comments.setup()
    
    -- Kolory Catppuccin Moka dla Todo Comments
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "TodoFgFIX", { fg = "#F38BA8", bg = "#1E1E2E", bold = true })
        vim.api.nvim_set_hl(0, "TodoFgTODO", { fg = "#89B4FA", bg = "#1E1E2E", bold = true })
        vim.api.nvim_set_hl(0, "TodoFgHACK", { fg = "#F9E2AF", bg = "#1E1E2E", bold = true })
        vim.api.nvim_set_hl(0, "TodoFgWARN", { fg = "#F9E2AF", bg = "#1E1E2E", bold = true })
        vim.api.nvim_set_hl(0, "TodoFgPERF", { fg = "#F5C2E7", bg = "#1E1E2E", bold = true })
        vim.api.nvim_set_hl(0, "TodoFgNOTE", { fg = "#A6E3A1", bg = "#1E1E2E", bold = true })
        vim.api.nvim_set_hl(0, "TodoFgTEST", { fg = "#89DCEB", bg = "#1E1E2E", bold = true })
        vim.api.nvim_set_hl(0, "TodoBgFIX", { fg = "#1E1E2E", bg = "#F38BA8", bold = true })
        vim.api.nvim_set_hl(0, "TodoBgTODO", { fg = "#1E1E2E", bg = "#89B4FA", bold = true })
        vim.api.nvim_set_hl(0, "TodoBgHACK", { fg = "#1E1E2E", bg = "#F9E2AF", bold = true })
        vim.api.nvim_set_hl(0, "TodoBgWARN", { fg = "#1E1E2E", bg = "#F9E2AF", bold = true })
        vim.api.nvim_set_hl(0, "TodoBgPERF", { fg = "#1E1E2E", bg = "#F5C2E7", bold = true })
        vim.api.nvim_set_hl(0, "TodoBgNOTE", { fg = "#1E1E2E", bg = "#A6E3A1", bold = true })
        vim.api.nvim_set_hl(0, "TodoBgTEST", { fg = "#1E1E2E", bg = "#89DCEB", bold = true })
        vim.api.nvim_set_hl(0, "TodoSignFIX", { fg = "#F38BA8", bg = "#1E1E2E", bold = true })
        vim.api.nvim_set_hl(0, "TodoSignTODO", { fg = "#89B4FA", bg = "#1E1E2E", bold = true })
        vim.api.nvim_set_hl(0, "TodoSignHACK", { fg = "#F9E2AF", bg = "#1E1E2E", bold = true })
        vim.api.nvim_set_hl(0, "TodoSignWARN", { fg = "#F9E2AF", bg = "#1E1E2E", bold = true })
        vim.api.nvim_set_hl(0, "TodoSignPERF", { fg = "#F5C2E7", bg = "#1E1E2E", bold = true })
        vim.api.nvim_set_hl(0, "TodoSignNOTE", { fg = "#A6E3A1", bg = "#1E1E2E", bold = true })
        vim.api.nvim_set_hl(0, "TodoSignTEST", { fg = "#89DCEB", bg = "#1E1E2E", bold = true })
      end,
    })
  end,
}
