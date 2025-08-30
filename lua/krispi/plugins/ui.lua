return {
  -- Modern UI components and notifications
  
  -- Enhanced cmdline, popup and floating windows
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      -- Dodaj lepszą obsługę błędów
      local ok, noice = pcall(require, "noice")
      if not ok then
        print("❌ Failed to load noice.nvim")
        return
      end

      -- Uproszczona konfiguracja Noice
      noice.setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
          opts = {
            position = {
              row = "50%",
              col = "50%",
            },
            size = {
              width = 60,
              height = "auto",
            },
          },
        },
        popupmenu = {
          enabled = true,
          backend = "nui",
        },
        -- Wyłącz notify w Noice - używaj tylko nvim-notify
        notify = {
          enabled = false,
        },
        views = {
          cmdline_popup = {
            position = {
              row = "50%",
              col = "50%",
            },
            size = {
              width = 60,
              height = "auto",
            },
          },
          popup = {
            position = {
              row = "50%",
              col = "50%",
            },
            size = {
              width = 60,
              height = "auto",
            },
          },
        },
      })
      
      -- Kolory Catppuccin Moka dla Noice
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "NoiceCmdline", { bg = "#313244", fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { bg = "#313244", fg = "#CBA6F7", bold = true })
          vim.api.nvim_set_hl(0, "NoiceCmdlineIconSearch", { bg = "#313244", fg = "#F9E2AF", bold = true })
          vim.api.nvim_set_hl(0, "NoiceCmdlineIconCmdline", { bg = "#313244", fg = "#89B4FA", bold = true })
          vim.api.nvim_set_hl(0, "NoiceCmdlineIconFilter", { bg = "#313244", fg = "#A6E3A1", bold = true })
          vim.api.nvim_set_hl(0, "NoiceCmdlineIconHelp", { bg = "#313244", fg = "#F5C2E7", bold = true })
          vim.api.nvim_set_hl(0, "NoiceCmdlineIconInput", { bg = "#313244", fg = "#89DCEB", bold = true })
          vim.api.nvim_set_hl(0, "NoiceCmdlineIconLua", { bg = "#313244", fg = "#FAB387", bold = true })
          vim.api.nvim_set_hl(0, "NoiceCmdlineIconShell", { bg = "#313244", fg = "#A6E3A1", bold = true })
          vim.api.nvim_set_hl(0, "NoiceCmdlineIconSort", { bg = "#313244", fg = "#F5C2E7", bold = true })
          vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { bg = "#1E1E2E", fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { bg = "#1E1E2E", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderCmdline", { bg = "#1E1E2E", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderFilter", { bg = "#1E1E2E", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderHelp", { bg = "#1E1E2E", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderInput", { bg = "#1E1E2E", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderSearch", { bg = "#1E1E2E", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderShell", { bg = "#1E1E2E", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderSort", { bg = "#1E1E2E", fg = "#6C7086" })
        end,
      })
      
      -- Noice configured silently
    end,
  },

  -- Nvim-notify - Better notifications
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      -- Dodaj lepszą obsługę błędów
      local ok, notify = pcall(require, "notify")
      if not ok then
        print("❌ Failed to load nvim-notify")
        return
      end

      -- Uproszczona konfiguracja nvim-notify
      notify.setup({
        -- Podstawowe opcje
        stages = "fade_in_slide_out",
        timeout = 3000,
        background_colour = "#1E1E2E",
        
        -- Wyłącz problematyczne funkcje
        render = "minimal",
        minimum_width = 50,
        max_width = 80,
        
        -- Lepsze pozycjonowanie
        top_down = false,
        
        -- Kolory Catppuccin Moka
        icons = {
          ERROR = "󰅚",
          WARN = "󰀪",
          INFO = "󰋼",
          DEBUG = "󰆈",
          TRACE = "󰆈",
        },
      })

      -- Kolory Catppuccin Moka dla Notify
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "NotifyERRORBorder", { bg = "#1E1E2E", fg = "#F38BA8" })
          vim.api.nvim_set_hl(0, "NotifyWARNBorder", { bg = "#1E1E2E", fg = "#F9E2AF" })
          vim.api.nvim_set_hl(0, "NotifyINFOBorder", { bg = "#1E1E2E", fg = "#89B4FA" })
          vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { bg = "#1E1E2E", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { bg = "#1E1E2E", fg = "#6C7086" })
          
          vim.api.nvim_set_hl(0, "NotifyERRORIcon", { bg = "#1E1E2E", fg = "#F38BA8" })
          vim.api.nvim_set_hl(0, "NotifyWARNIcon", { bg = "#1E1E2E", fg = "#F9E2AF" })
          vim.api.nvim_set_hl(0, "NotifyINFOIcon", { bg = "#1E1E2E", fg = "#89B4FA" })
          vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { bg = "#1E1E2E", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { bg = "#1E1E2E", fg = "#6C7086" })
          
          vim.api.nvim_set_hl(0, "NotifyERRORTitle", { bg = "#1E1E2E", fg = "#F38BA8", bold = true })
          vim.api.nvim_set_hl(0, "NotifyWARNTitle", { bg = "#1E1E2E", fg = "#F9E2AF", bold = true })
          vim.api.nvim_set_hl(0, "NotifyINFOTitle", { bg = "#1E1E2E", fg = "#89B4FA", bold = true })
          vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { bg = "#1E1E2E", fg = "#6C7086", bold = true })
          vim.api.nvim_set_hl(0, "NotifyTRACETitle", { bg = "#1E1E2E", fg = "#6C7086", bold = true })
          
          vim.api.nvim_set_hl(0, "NotifyERRORBody", { bg = "#1E1E2E", fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "NotifyWARNBody", { bg = "#1E1E2E", fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "NotifyINFOBody", { bg = "#1E1E2E", fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { bg = "#1E1E2E", fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "NotifyTRACEBody", { bg = "#1E1E2E", fg = "#CDD6F4" })
        end,
      })
      
      -- Nvim-notify configured silently
    end,
  },

  -- UI framework for plugins
  {
    "MunifTanjim/nui.nvim",
    event = "VeryLazy",
  },

  -- Note: nvim-web-devicons is now configured in plugins/init.lua
  -- This prevents conflicts and ensures proper loading order

  -- Better input and select UI
  -- Konfiguracja w osobnych plikach: dressing.lua, indent-blankline.lua

  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require("neoscroll").setup({
        mappings = {},
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = true,
        cursor_scrolls_alone = true,
        easing_function = "cubic",
        pre_hook = nil,
        post_hook = nil,
        performance_mode = true,
      })
      
      -- Kolory Catppuccin Moka dla Neoscroll
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "Neoscroll", { fg = "#CBA6F7", bg = "#1E1E2E", bold = true })
        end,
      })
    end,
  },

  -- Better quickfix and location list
  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
    config = function()
      require("bqf").setup({
        auto_enable = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_ch = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
        },
        func_map = {
          vsplit = "",
          ptogglemode = "z,",
          stoggleup = "",
        },
        filter = {
          fzf = {
            action_for = { ["ctrl-s"] = "split" },
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
            default_opts = { "--skip-vcs" },
          },
        },
      })
      
      -- Kolory Catppuccin Moka dla BQF
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "BqfNormal", { bg = "#1E1E2E", fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "BqfBorder", { bg = "#1E1E2E", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "BqfPreviewFloat", { bg = "#313244", fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "BqfPreviewBorder", { bg = "#313244", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "BqfPreviewTitle", { bg = "#313244", fg = "#CBA6F7", bold = true })
          vim.api.nvim_set_hl(0, "BqfPreviewCursor", { bg = "#89B4FA", fg = "#1E1E2E" })
          vim.api.nvim_set_hl(0, "BqfPreviewRange", { bg = "#89B4FA", fg = "#1E1E2E" })
          vim.api.nvim_set_hl(0, "BqfPreviewBufName", { bg = "#1E1E2E", fg = "#89B4FA" })
          vim.api.nvim_set_hl(0, "BqfPreviewFileName", { bg = "#1E1E2E", fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "BqfPreviewLine", { bg = "#1E1E2E", fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "BqfPreviewLineNumber", { bg = "#1E1E2E", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "BqfPreviewLineNumberSelected", { bg = "#313244", fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "BqfPreviewLineNumberSelectedSearch", { bg = "#89B4FA", fg = "#1E1E2E" })
          vim.api.nvim_set_hl(0, "BqfPreviewLineNumberSelectedReplace", { bg = "#F38BA8", fg = "#1E1E2E" })
        end,
      })
    end,
  },

  -- Better search and replace
  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    config = function()
      require("spectre").setup({
        color_devicons = true,
        open_cmd = "vnew",
        live_update = false,
        line_sep_start = "┌──────────────────────────────────────────────────────────────────────────────┐",
        line_sep = "├──────────────────────────────────────────────────────────────────────────────┤",
        result_padding = "│  ",
        line_padding = "  ",
        highlight = {
          ui = "String",
          search = "DiffChange",
          replace = "DiffDelete",
        },
        mapping = {
          ["toggle_line"] = {
            map = "dd",
            cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
            desc = "toggle current item",
          },
          ["enter_file"] = {
            map = "<CR>",
            cmd = "<cmd>lua require('spectre').open_file(false)<CR>",
            desc = "open file",
          },
          ["send_to_qf"] = {
            map = "<leader>q",
            cmd = "<cmd>lua require('spectre').send_to_qf()<CR>",
            desc = "send all items to quickfix",
          },
          ["replace_cmd"] = {
            map = "<leader>c",
            cmd = "<cmd>lua require('spectre').replace_cmd()<CR>",
            desc = "input replace command",
          },
          ["show_option_menu"] = {
            map = "<leader>o",
            cmd = "<cmd>lua require('spectre').show_options()<CR>",
            desc = "show option",
          },
          ["run_replace"] = {
            map = "<leader>R",
            cmd = "<cmd>lua require('spectre').run_replace()<CR>",
            desc = "replace all",
          },
          ["change_view_mode"] = {
            map = "<leader>v",
            cmd = "<cmd>lua require('spectre').change_view()<CR>",
            desc = "change result view mode",
          },
        },
      })
      
      -- Kolory Catppuccin Moka dla Spectre
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "SpectreSearch", { bg = "#89B4FA", fg = "#1E1E2E" })
          vim.api.nvim_set_hl(0, "SpectreReplace", { bg = "#F38BA8", fg = "#1E1E2E" })
          vim.api.nvim_set_hl(0, "SpectreFile", { bg = "#1E1E2E", fg = "#89B4FA" })
          vim.api.nvim_set_hl(0, "SpectreDir", { bg = "#1E1E2E", fg = "#89B4FA" })
          vim.api.nvim_set_hl(0, "SpectreBorder", { bg = "#1E1E2E", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "SpectreLine", { bg = "#1E1E2E", fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "SpectreLineNumber", { bg = "#1E1E2E", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "SpectreLineNumberSelected", { bg = "#313244", fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "SpectreLineNumberSelectedSearch", { bg = "#89B4FA", fg = "#1E1E2E" })
          vim.api.nvim_set_hl(0, "SpectreLineNumberSelectedReplace", { bg = "#F38BA8", fg = "#1E1E2E" })
        end,
      })
    end,
  },

  -- Highlight current line and cursor
  {
    "yamatsum/nvim-cursorline",
    event = "VeryLazy",
    config = function()
      require("nvim-cursorline").setup({
        cursorline = {
          enable = true,
          timeout = 1000,
          number = false,
        },
        cursorword = {
          enable = true,
          min_length = 3,
          hl = { underline = true },
        },
      })
      
      -- Kolory Catppuccin Moka dla Cursorline
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "Cursorline", { bg = "#313244", sp = "#6C7086" })
          vim.api.nvim_set_hl(0, "Cursorword", { underline = true, sp = "#89B4FA" })
        end,
      })
    end,
  },

  -- Better indent guides
  -- Konfiguracja w osobnych plikach: dressing.lua, indent-blankline.lua

  -- Winbar with breadcrumbs
  {
    "utilyre/barbecue.nvim",
    event = "VeryLazy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("barbecue").setup({
        create_autocmd = false,
        attach_navic = false,
        show_modified = true,
        theme = "auto",
        context_follow_icon_color = false,
        symbols = {
          separator = ">",
        },
      })
      
      -- Kolory Catppuccin Moka dla Barbecue
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "BarbecueNormal", { bg = "#1E1E2E", fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "BarbecueEllipsis", { bg = "#1E1E2E", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "BarbecueSeparator", { bg = "#1E1E2E", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "BarbecueModified", { bg = "#1E1E2E", fg = "#FAB387" })
          vim.api.nvim_set_hl(0, "BarbecueDirname", { bg = "#1E1E2E", fg = "#89B4FA" })
          vim.api.nvim_set_hl(0, "BarbecueBasename", { bg = "#1E1E2E", fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "BarbecueContext", { bg = "#1E1E2E", fg = "#A6ADC8" })
          vim.api.nvim_set_hl(0, "BarbecueContextFile", { bg = "#1E1E2E", fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "BarbecueContextModule", { bg = "#1E1E2E", fg = "#F5C2E7" })
          vim.api.nvim_set_hl(0, "BarbecueContextNamespace", { bg = "#1E1E2E", fg = "#89DCEB" })
          vim.api.nvim_set_hl(0, "BarbecueContextPackage", { bg = "#1E1E2E", fg = "#F9E2AF" })
          vim.api.nvim_set_hl(0, "BarbecueContextClass", { bg = "#1E1E2E", fg = "#FAB387" })
          vim.api.nvim_set_hl(0, "BarbecueContextMethod", { bg = "#1E1E2E", fg = "#FAB387" })
          vim.api.nvim_set_hl(0, "BarbecueContextProperty", { bg = "#1E1E2E", fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "BarbecueContextField", { bg = "#1E1E2E", fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "BarbecueContextConstructor", { bg = "#1E1E2E", fg = "#FAB387" })
          vim.api.nvim_set_hl(0, "BarbecueContextEnum", { bg = "#1E1E2E", fg = "#FAB387" })
          vim.api.nvim_set_hl(0, "BarbecueContextFunction", { bg = "#1E1E2E", fg = "#FAB387" })
          vim.api.nvim_set_hl(0, "BarbecueContextVariable", { bg = "#1E1E2E", fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "BarbecueContextConstant", { bg = "#1E1E2E", fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "BarbecueContextString", { bg = "#1E1E2E", fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "BarbecueContextNumber", { bg = "#1E1E2E", fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "BarbecueContextBoolean", { bg = "#1E1E2E", fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "BarbecueContextArray", { bg = "#1E1E2E", fg = "#F5C2E7" })
          vim.api.nvim_set_hl(0, "BarbecueContextObject", { bg = "#1E1E2E", fg = "#F5C2E7" })
          vim.api.nvim_set_hl(0, "BarbecueContextKey", { bg = "#1E1E2E", fg = "#89B4FA" })
          vim.api.nvim_set_hl(0, "BarbecueContextNull", { bg = "#1E1E2E", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "BarbecueContextEnumMember", { bg = "#1E1E2E", fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "BarbecueContextStruct", { bg = "#1E1E2E", fg = "#FAB387" })
          vim.api.nvim_set_hl(0, "BarbecueContextEvent", { bg = "#1E1E2E", fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "BarbecueContextOperator", { bg = "#1E1E2E", fg = "#A6ADC8" })
          vim.api.nvim_set_hl(0, "BarbecueContextTypeParameter", { bg = "#1E1E2E", fg = "#FAB387" })
        end,
      })
    end,
  },
}
