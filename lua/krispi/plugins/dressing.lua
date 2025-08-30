return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  config = function()
    require("dressing").setup({
      input = {
        border = "rounded",
        relative = "cursor",
        row = 0,
        col = 0,
        width = 40,
        height = 1,
        title_pos = "left",
        title = "",
        title_align = "left",
        prompt_align = "left",
        prompt = "",
        default_value = "",
        insert_only = true,
        start_in_insert = true,
        select = true,
        relative = "cursor",
        row = 0,
        col = 0,
        width = 40,
        height = 1,
        title_pos = "left",
        title = "",
        title_align = "left",
        prompt_align = "left",
        prompt = "",
        default_value = "",
        insert_only = true,
        start_in_insert = true,
        select = true,
      },
      select = {
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
        trim_prompt = true,
      },
    })
    
    -- Kolory Catppuccin Moka dla Dressing
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "DressingInput", { bg = "#313244", fg = "#CDD6F4" })
        vim.api.nvim_set_hl(0, "DressingInputBorder", { bg = "#313244", fg = "#6C7086" })
        vim.api.nvim_set_hl(0, "DressingInputTitle", { bg = "#313244", fg = "#CBA6F7", bold = true })
        vim.api.nvim_set_hl(0, "DressingSelect", { bg = "#1E1E2E", fg = "#CDD6F4" })
        vim.api.nvim_set_hl(0, "DressingSelectBorder", { bg = "#1E1E2E", fg = "#6C7086" })
        vim.api.nvim_set_hl(0, "DressingSelectTitle", { bg = "#1E1E2E", fg = "#89B4FA", bold = true })
      end,
    })
  end,
}
