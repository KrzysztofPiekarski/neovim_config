return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      local autopairs = require("nvim-autopairs")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")

      autopairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          typescript = { "string", "template_string" },
          java = { "string" },
          c = { "string", "comment" },
          cpp = { "string", "comment" },
          go = { "string", "comment" },
          rust = { "string", "comment" },
          python = { "string", "comment" },
          html = { "string" },
          css = { "string" },
          scss = { "string" },
          json = { "string" },
          yaml = { "string" },
          markdown = { "string" },
          bash = { "string", "comment" },
          fish = { "string", "comment" },
          sql = { "string", "comment" },
          toml = { "string" },
          dockerfile = { "string", "comment" },
          gitignore = { "string", "comment" },
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        disable_in_macro = false,
        disable_in_visualblock = false,
        disable_in_replace_mode = true,
        ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
        enable_moveright = true,
        enable_afterquote = true,
        enable_check_bracket_line = true,
        enable_bracket_in_quote = true,
        enable_abbr = false,
        break_undo = true,
        check_ts = true,
        map_cr = true,
        map_bs = true,
        map_c_h = false,
        map_c_w = false,
      })

      -- Integration with CMP
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
      
      -- Kolory Catppuccin Moka dla Autopairs
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "Autopairs", { fg = "#89B4FA", bg = "#1E1E2E", bold = true })
        end,
      })
    end,
  },
}
