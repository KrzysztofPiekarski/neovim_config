return {
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
          lualine = true,
        },
        color_overrides = {
          mocha = {
            rosewater = "#F5E0DC",
            flamingo = "#F2CDCD",
            pink = "#F5C2E7",
            mauve = "#CBA6F7",
            red = "#F38BA8",
            maroon = "#EBA0AC",
            peach = "#FAB387",
            yellow = "#F9E2AF",
            green = "#A6E3A1",
            teal = "#94E2D5",
            sky = "#89DCEB",
            sapphire = "#74C7EC",
            blue = "#89B4FA",
            lavender = "#B4BEFE",
            text = "#CDD6F4",
            subtext1 = "#BAC2DE",
            subtext0 = "#A6ADC8",
            overlay2 = "#9399B2",
            overlay1 = "#7F849C",
            overlay0 = "#6C7086",
            surface2 = "#585B70",
            surface1 = "#45475A",
            surface0 = "#313244",
            base = "#1E1E2E",
            mantle = "#181825",
            crust = "#11111B",
          },
        },
        custom_highlights = function(colors)
          return {
            -- Lepsze kolory dla różnych elementów
            Normal = { bg = "none" },
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none", fg = colors.overlay0 },
            FloatTitle = { bg = "none", fg = colors.subtext0 },
            
            -- Lepsze kolory dla cursorline
            CursorLine = { bg = colors.surface0, sp = colors.overlay0 },
            CursorLineNr = { fg = colors.subtext0, bg = colors.surface0, bold = true },
            
            -- Lepsze kolory dla search
            Search = { bg = colors.blue, fg = colors.base },
            IncSearch = { bg = colors.surface1, fg = colors.base },
            
            -- Lepsze kolory dla git signs
            GitSignsAdd = { fg = colors.green },
            GitSignsChange = { fg = colors.peach },
            GitSignsDelete = { fg = colors.red },
            
            -- Lepsze kolory dla indent guides
            IndentBlanklineChar = { fg = colors.surface2, nocombine = true },
            IndentBlanklineContextChar = { fg = colors.overlay0, nocombine = true },
            
            -- Lepsze kolory dla winbar
            WinBar = { fg = colors.subtext0, bg = "none" },
            WinBarNC = { fg = colors.overlay1, bg = "none" },
            
            -- Lepsze kolory dla LSP
            LspSignatureActiveParameter = { fg = colors.subtext0, bold = true },
            LspCodeLens = { fg = colors.overlay1, italic = true },
            
            -- Lepsze kolory dla Treesitter
            TreesitterContext = { bg = colors.surface0 },
            TreesitterContextLineNumber = { fg = colors.subtext0, bg = colors.surface0 },
            
            -- Specjalne kolory dla Alpha dashboard
            AlphaHeader = { fg = colors.sapphire, bg = colors.base, bold = true },
            AlphaHeaderKey = { fg = colors.blue, bg = colors.base, bold = true },
            AlphaHeaderValue = { fg = colors.green, bg = colors.base },
            AlphaButton = { fg = colors.subtext1, bg = colors.surface0 },
            AlphaButtonIcon = { fg = colors.blue, bg = colors.surface0, bold = true },
            AlphaFooter = { fg = colors.overlay1, bg = colors.base, italic = true },
          }
        end,
      })
      
      -- Ustaw Catppuccin jako domyślny motyw
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
