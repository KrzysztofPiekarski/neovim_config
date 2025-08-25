return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Header
      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
        "           [ Neovim IDE Configuration ]              ",
        "                                                     ",
      }

      -- Buttons
      dashboard.section.buttons.val = {
        dashboard.button("e", "📁  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "🔍  Find file", "<cmd>Telescope find_files<CR>"),
        dashboard.button("g", "🌳  Find word", "<cmd>Telescope live_grep<CR>"),
        dashboard.button("r", "📚  Recent files", "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("n", "🌿  Neotree", "<cmd>NvimTreeToggle<CR>"),
        dashboard.button("s", "⚙️  Settings", "<cmd>e $MYVIMRC<CR>"),
        dashboard.button("q", "🚪  Quit Neovim", "<cmd>qa<CR>"),
      }

      -- Footer
      local function footer()
        local total_plugins = require("lazy").stats().count
        local datetime = os.date("📅 %d-%m-%Y  🕐 %H:%M:%S")
        local version = vim.version()
        local nvim_ver = string.format("Neovim %d.%d.%d", version.major, version.minor, version.patch)
        return string.format("✨ %d plugins loaded | %s | %s", total_plugins, datetime, nvim_ver)
      end

      dashboard.section.footer.val = footer()

      -- Layout
      dashboard.config.layout = {
        { type = "padding", val = 1 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }

      -- Setup
      alpha.setup(dashboard.opts)

      -- Disable statusline and tabline on dashboard
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          vim.cmd([[
            set showtabline=0 | 
            autocmd BufUnload <buffer> set showtabline=2
          ]])
        end,
      })

      -- Highlight groups - poprawione kolory z tłem
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          -- Ustawienie tła dla całego bufora Alpha
          vim.api.nvim_set_hl(0, "Normal", { 
            bg = "#011628"  -- Kolor tła z tokyonight
          })
          
          -- Ustawienie tła dla linii
          vim.api.nvim_set_hl(0, "LineNr", { 
            fg = "#627E97", 
            bg = "#011628" 
          })

          -- Ustawienie tła dla bufora
          vim.api.nvim_set_hl(0, "BufferLineFill", { 
            bg = "#011628" 
          })
        end,
      })
    end,
  },
}
