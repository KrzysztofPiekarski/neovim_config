return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")

      -- Load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = {
            border = "rounded",
            winblend = 0,
            col_offset = -3,
            side_padding = 0,
            scrollbar = false,
          },
          documentation = {
            border = "rounded",
            winblend = 0,
          },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          expandable_indicator = true,
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            show_labelDetails = true,
            symbol_map = {
              Text = "󰉿",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "󰏤",
              Field = "󰇽",
              Variable = "󰋡",
              Class = "󰋧",
              Interface = "󰋨",
              Module = "󰏗",
              Property = "󰇽",
              Unit = "󰑭",
              Value = "󰎠",
              Enum = "󰒻",
              Keyword = "󰌋",
              Snippet = "󰅩",
              Color = "󰏘",
              File = "󰈙",
              Reference = "󰈇",
              Folder = "󰉋",
              EnumMember = "󰒼",
              Constant = "󰏿",
              Struct = "󰋩",
              Event = "󰎕",
              Operator = "󰆕",
              TypeParameter = "󰊄",
            },
            menu = {
              nvim_lsp = "[LSP]",
              nvim_lua = "[Lua]",
              buffer = "[Buffer]",
              path = "[Path]",
              luasnip = "[Snippet]",
              cmdline = "[Cmd]",
            },
          }),
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          { name = "nvim_lsp", priority = 1000 },
          { name = "nvim_lsp_signature_help", priority = 900 },
          { name = "luasnip", priority = 800 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 400 },
          { name = "nvim_lua", priority = 300 },
        },
        experimental = {
          ghost_text = true,
        },
        performance = {
          debounce = 300,
          throttle = 60,
          max_view_entries = 200,
        },
      })

      -- CMP for cmdline
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "cmdline", priority = 1000 },
          { name = "path", priority = 500 },
        },
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer", priority = 1000 },
        },
      })

      cmp.setup.cmdline("?", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer", priority = 1000 },
        },
      })

      -- Custom highlight groups dla Catppuccin Moka
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "CmpItemKind", { fg = "#A6ADC8" })
          vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#6C7086", italic = true })
          vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#89B4FA", bold = true })
          vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#89B4FA", bold = true })
          vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#FAB387" })
          vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#FAB387" })
          vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FAB387" })
          vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#FAB387" })
          vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#FAB387" })
          vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#FAB387" })
          vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#FAB387" })
          vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#A6ADC8" })
          vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#FAB387" })
          vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#A6ADC8" })
          vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#FAB387" })
        end,
      })
    end,
  },
}
