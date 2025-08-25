return {
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local bg = "#011628"
      local bg_dark = "#011423"
      local bg_highlight = "#143652"
      local bg_search = "#0A64AC"
      local bg_visual = "#275378"
      local fg = "#CBE0F0"
      local fg_dark = "#B4D0E9"
      local fg_gutter = "#627E97"
      local border = "#547998"

      require("tokyonight").setup({
        style = "night",
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = { bold = true },
          variables = {},
          sidebars = "dark",
          floats = "dark",
        },
        sidebars = { "qf", "help", "terminal", "NvimTree", "Outline" },
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = true,
        on_colors = function(colors)
          colors.bg = bg
          colors.bg_dark = bg_dark
          colors.bg_float = bg_dark
          colors.bg_highlight = bg_highlight
          colors.bg_popup = bg_dark
          colors.bg_search = bg_search
          colors.bg_sidebar = bg_dark
          colors.bg_statusline = bg_dark
          colors.bg_visual = bg_visual
          colors.border = border
          colors.fg = fg
          colors.fg_dark = fg_dark
          colors.fg_float = fg
          colors.fg_gutter = fg_gutter
          colors.fg_sidebar = fg_dark
        end,
        on_highlights = function(hl, c)
          -- Lepsze kolory dla różnych elementów
          hl.Normal = { bg = "none" }
          hl.NormalFloat = { bg = "none" }
          hl.FloatBorder = { bg = "none", fg = c.border }
          hl.FloatTitle = { bg = "none", fg = c.fg_dark }
          
          -- Lepsze kolory dla cursorline
          hl.CursorLine = { bg = c.bg_highlight, sp = c.border }
          hl.CursorLineNr = { fg = c.fg_dark, bg = c.bg_highlight, bold = true }
          
          -- Lepsze kolory dla search
          hl.Search = { bg = c.bg_search, fg = c.bg }
          hl.IncSearch = { bg = c.bg_visual, fg = c.bg }
          
          -- Lepsze kolory dla git signs
          hl.GitSignsAdd = { fg = "#A3BE8C" }
          hl.GitSignsChange = { fg = "#D08770" }
          hl.GitSignsDelete = { fg = "#BF616A" }
          
          -- Lepsze kolory dla indent guides
          hl.IndentBlanklineChar = { fg = "#3B4252", nocombine = true }
          hl.IndentBlanklineContextChar = { fg = c.border, nocombine = true }
          
          -- Lepsze kolory dla winbar
          hl.WinBar = { fg = c.fg_dark, bg = "none" }
          hl.WinBarNC = { fg = c.fg_gutter, bg = "none" }
          
          -- Lepsze kolory dla LSP
          hl.LspSignatureActiveParameter = { fg = c.fg_dark, bold = true }
          hl.LspCodeLens = { fg = c.fg_gutter, italic = true }
          
          -- Lepsze kolory dla Treesitter
          hl.TreesitterContext = { bg = c.bg_highlight }
          hl.TreesitterContextLineNumber = { fg = c.fg_dark, bg = c.bg_highlight }
          
          -- Specjalne kolory dla Alpha dashboard
          hl.AlphaHeader = { fg = "#81A1C1", bg = c.bg, bold = true }
          hl.AlphaHeaderKey = { fg = "#5E81AC", bg = c.bg, bold = true }
          hl.AlphaHeaderValue = { fg = "#A3BE8C", bg = c.bg }
          hl.AlphaButton = { fg = "#D8DEE9", bg = c.bg_highlight }
          hl.AlphaButtonIcon = { fg = "#5E81AC", bg = c.bg_highlight, bold = true }
          hl.AlphaFooter = { fg = "#4C566A", bg = c.bg, italic = true }
        end,
      })
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- Alternatywne motywy kolorystyczne
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        term_colors = true,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = { "bold" },
          keywords = { "bold" },
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = { "bold" },
          operators = {},
        },
        integrations = {
          aerial = true,
          alpha = true,
          cmp = true,
          gitsigns = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          mason = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
          notify = true,
          neotree = true,
          treesitter = true,
          which_key = true,
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
      })
    end,
  },

  -- Motyw Nord
  {
    "shaunsingh/nord.nvim",
    priority = 1000,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = true
      vim.g.nord_disable_background = false
      vim.g.nord_italic = false
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = false
    end,
  },

  -- Motyw Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,
        contrast = "soft",
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })
    end,
  },
}
