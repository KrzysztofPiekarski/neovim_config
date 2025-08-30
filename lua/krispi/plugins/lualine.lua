return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Loading Lualine silently
      
      local ok, lualine = pcall(require, "lualine")
      if not ok then
        print("❌ Failed to load Lualine!")
        return
      end
      
      local ok2, lazy_status = pcall(require, "lazy.status")
      if not ok2 then
        print("⚠️ Failed to load lazy.status")
      end

      -- Natychmiastowe zastosowanie highlight groups - bez autocommandów
      print("🎨 Applying Lualine highlight groups directly...")
      
      -- Bezpośrednie style dla trybów - zaokrąglone rogi z hardcoded kolorami Catppuccin Moka
      vim.api.nvim_set_hl(0, "Lualine_a_normal", { 
        bg = "#cba6f7", -- Catppuccin Moka purple
        fg = "#1e1e2e", -- Catppuccin Moka base
        bold = true,
        sp = "#cba6f7",
        underline = false,
        undercurl = false,
      })
      vim.api.nvim_set_hl(0, "Lualine_a_insert", { 
        bg = "#a6e3a1", -- Catppuccin Moka green
        fg = "#1e1e2e", -- Catppuccin Moka base
        bold = true,
        sp = "#a6e3a1",
        underline = false,
        undercurl = false,
      })
      vim.api.nvim_set_hl(0, "Lualine_a_visual", { 
        bg = "#f9e2af", -- Catppuccin Moka yellow
        fg = "#1e1e2e", -- Catppuccin Moka base
        bold = true,
        sp = "#f9e2af",
        underline = false,
        undercurl = false,
      })
      vim.api.nvim_set_hl(0, "Lualine_a_command", { 
        bg = "#f9e2af", -- Catppuccin Moka yellow
        fg = "#1e1e2e", -- Catppuccin Moka base
        bold = true,
        sp = "#f9e2af",
        underline = false,
        undercurl = false,
      })
      vim.api.nvim_set_hl(0, "Lualine_a_replace", { 
        bg = "#f38ba8", -- Catppuccin Moka red
        fg = "#1e1e2e", -- Catppuccin Moka base
        bold = true,
        sp = "#f38ba8",
        underline = false,
        undercurl = false,
      })
      
      -- Wymuś odświeżenie status bar i Lualine
      vim.cmd([[redrawstatus]])
      vim.cmd([[lua require('lualine').refresh()]])
      
      -- Lualine highlight groups applied silently

      -- Nowoczesny theme z hardcoded kolorami Catppuccin Moka
      local theme = {
        normal = {
          a = { bg = "#cba6f7", fg = "#1e1e2e", gui = "bold" },
          b = { bg = "#475569", fg = "#E2E8F0" },
          c = { bg = "#313244", fg = "#CBD5E1" },
        },
        insert = {
          a = { bg = "#a6e3a1", fg = "#1e1e2e", gui = "bold" },
          b = { bg = "#475569", fg = "#E2E8F0" },
          c = { bg = "#313244", fg = "#CBD5E1" },
        },
        visual = {
          a = { bg = "#f9e2af", fg = "#1e1e2e", gui = "bold" },
          b = { bg = "#475569", fg = "#E2E8F0" },
          c = { bg = "#313244", fg = "#CBD5E1" },
        },
        command = {
          a = { bg = "#f9e2af", fg = "#1e1e2e", gui = "bold" },
          b = { bg = "#475569", fg = "#E2E8F0" },
          c = { bg = "#313244", fg = "#CBD5E1" },
        },
        replace = {
          a = { bg = "#f38ba8", fg = "#1e1e2e", gui = "bold" },
          b = { bg = "#475569", fg = "#E2E8F0" },
          c = { bg = "#313244", fg = "#CBD5E1" },
        },
        inactive = {
          a = { bg = "#585B70", fg = "#94A3B8", gui = "bold" },
          b = { bg = "#585B70", fg = "#94A3B8" },
          c = { bg = "#585B70", fg = "#94A3B8" },
        },
      }

      -- Funkcja do formatowania nazwy pliku
      local function filename()
        local fname = vim.fn.fnamemodify(vim.fn.expand('%'), ':t')
        if fname == '' then
          fname = '[No Name]'
        end
        return fname
      end

      -- Funkcja do formatowania rozmiaru pliku
      local function filesize()
        local file = vim.fn.expand('%:p')
        if file == '' then return '' end
        local size = vim.fn.getfsize(file)
        if size <= 0 then return '' end
        local suffixes = {'B', 'KB', 'MB', 'GB'}
        local i = 1
        while size > 1024 and i < #suffixes do
          size = size / 1024
          i = i + 1
        end
        return string.format('%.1f%s', size, suffixes[i])
      end

      -- Funkcja do formatowania encoding
      local function encoding()
        local enc = (vim.bo.fileencoding ~= '' and vim.bo.fileencoding) or vim.o.encoding
        return enc ~= 'utf-8' and enc:upper() or ''
      end

      -- Funkcja do formatowania fileformat
      local function fileformat()
        local fmt = vim.bo.fileformat
        return fmt ~= 'unix' and fmt:upper() or ''
      end

      -- 🕐 Funkcja do formatowania czasu i daty
      local function datetime()
        local time = os.date("%H:%M")
        local date = os.date("%d.%m")
        return time .. " " .. "󰔛" .. " " .. date
      end

      -- 📊 Funkcja do zaawansowanych informacji Git
      local function git_status()
        local git_branch = vim.fn.FugitiveHead()
        if git_branch == "" then return "" end
        
        -- Dodaj lepszą obsługę błędów dla git commands
        local function safe_git_command(cmd)
          local ok, result = pcall(vim.fn.system, cmd)
          if ok and result and result ~= "" then
            return result:gsub("%s+", "")
          end
          return ""
        end
        
        -- Pobierz status ahead/behind z lepszą obsługą błędów
        local ahead = safe_git_command("git rev-list --count HEAD..@{u} 2>/dev/null")
        local behind = safe_git_command("git rev-list --count @{u}..HEAD 2>/dev/null")
        
        -- Pobierz liczbę stash z lepszą obsługą błędów
        local stash_count = safe_git_command("git stash list | wc -l")
        
        local status = git_branch
        if ahead ~= "" and tonumber(ahead) and tonumber(ahead) > 0 then
          status = status .. " " .. "󰐕" .. ahead
        end
        if behind ~= "" and tonumber(behind) and tonumber(behind) > 0 then
          status = status .. " " .. "󰐔" .. behind
        end
        if stash_count ~= "" and tonumber(stash_count) and tonumber(stash_count) > 0 then
          status = status .. " " .. "󰆘" .. " " .. stash_count
        end
        
        return status
      end

      -- 📈 Funkcja do statystyk pliku
      local function file_stats()
        local file = vim.fn.expand('%:p')
        if file == '' then return "" end
        
        local lines = vim.fn.line('$')
        local current_line = vim.fn.line('.')
        
        return string.format("%d lines " .. "󰌗" .. " %d", lines, current_line)
      end

      -- 🌐 Funkcja do informacji o projekcie
      local function project_info()
        local project_name = ""
        
        -- Pobierz nazwę projektu z .git
        local git_dir = vim.fn.finddir('.git', '.;')
        if git_dir ~= "" then
          local project_path = vim.fn.fnamemodify(git_dir, ':h')
          project_name = vim.fn.fnamemodify(project_path, ':t')
        end
        
        return project_name
      end

      -- Funkcja do formatowania trybu z lepszymi stylami
      local function mode_formatter()
        local mode = vim.fn.mode()
        local mode_names = {
          n = "NORMAL",
          i = "INSERT", 
          v = "VISUAL",
          V = "V-LINE",
          [""] = "V-BLOCK",
          c = "COMMAND",
          r = "REPLACE",
          R = "R-REPLACE",
        }
        return mode_names[mode] or "NORMAL"
      end

      -- Funkcja do dynamicznego highlight group dla trybów
      local function mode_highlight()
        local mode = vim.fn.mode()
        local mode_highlights = {
          n = "Lualine_a_normal",
          i = "Lualine_a_insert", 
          v = "Lualine_a_visual",
          V = "Lualine_a_visual",
          [""] = "Lualine_a_visual",
          c = "Lualine_a_command",
          r = "Lualine_a_replace",
          R = "Lualine_a_replace",
        }
        return mode_highlights[mode] or "Lualine_a_normal"
      end

      -- Ulepszona konfiguracja Lualine
      local ok, result = pcall(function()
        lualine.setup({
          options = {
            theme = theme,
            component_separators = { left = " ", right = " " },
            section_separators = { left = "", right = "" },
            globalstatus = true,
            disabled_filetypes = { statusline = { "dashboard", "alpha" } },
            always_divide_middle = true,
            -- Profesjonalne opcje stylowania
            icons_enabled = true,
            -- Zaokrąglone rogi dla trybów
            section_separators = { left = " ", right = " " },
            component_separators = { left = " ", right = " " },
          },
          sections = {
            lualine_a = { 
              { 
                mode_formatter, 
                separator = { left = "", right = " " }, 
                right_padding = 1, 
                padding = { left = 1, right = 1 },
                -- Użyj dynamicznego highlight group
                hl = mode_highlight,
              },
            },
            lualine_b = { 
              { git_status, icon = "󰘬", separator = { left = { "", " " }, right = " " } },
              { "diff", separator = { left = "󰍉 ", right = " " } },
              { "diagnostics", separator = { left = "󰋊 ", right = "" } },
            },
            lualine_c = { 
              { filename, separator = { left = "", right = " " } },
              { file_stats, separator = { left = "󰈙 ", right = "" } },
            },
            lualine_x = { 
              { project_info, separator = { left = "󰉋 ", right = "" } },
              { encoding, separator = { left = "󰨜 ", right = "" } },
              { fileformat, separator = { left = "󰈙 ", right = " " } },
              { "filetype", separator = { left = "󰉋 ", right = "" } },
            },
            lualine_y = { 
              { "progress", separator = { left = "󰎚 ", right = "" } },
            },
            lualine_z = { 
              { datetime, separator = { left = "󰔛 ", right = "" } },
            },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 
              { filename, separator = { left = "", right = "" } },
            },
            lualine_x = { 
              { "location", separator = { left = "󰈙 ", right = "" } },
            },
            lualine_y = {},
            lualine_z = {},
          },
          tabline = {},
          extensions = { "nvim-tree", "trouble", "lazy", "fugitive" },
        })
      end)
      
      if not ok then
        print("❌ Failed to setup Lualine:", result)
        return
      end

      -- Dodatkowy autocommand dla natychmiastowego zastosowania stylów
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          print("🎨 Immediate VimEnter autocommand - applying Lualine styles...")
          
          -- Stosuj style od razu przy starcie
          vim.api.nvim_set_hl(0, "Lualine_a_normal", { 
            bg = "#cba6f7", 
            fg = "#1e1e2e", 
            bold = true,
            sp = "#cba6f7",
            underline = false,
            undercurl = false,
          })
          vim.api.nvim_set_hl(0, "Lualine_a_insert", { 
            bg = "#a6e3a1", 
            fg = "#1e1e2e", 
            bold = true,
            sp = "#a6e3a1",
            underline = false,
            undercurl = false,
          })
          vim.api.nvim_set_hl(0, "Lualine_a_visual", { 
            bg = "#f9e2af", 
            fg = "#1e1e2e", 
            bold = true,
            sp = "#f9e2af",
            underline = false,
            undercurl = false,
          })
          vim.api.nvim_set_hl(0, "Lualine_a_command", { 
            bg = "#f9e2af", 
            fg = "#1e1e2e", 
            bold = true,
            sp = "#f9e2af",
            underline = false,
            undercurl = false,
          })
          vim.api.nvim_set_hl(0, "Lualine_a_replace", { 
            bg = "#f38ba8", 
            fg = "#1e1e2e", 
            bold = true,
            sp = "#f38ba8",
            underline = false,
            undercurl = false,
          })
          
          -- Wymuś odświeżenie status bar i Lualine
          vim.cmd([[redrawstatus]])
          vim.cmd([[lua require('lualine').refresh()]])
          
          -- Immediate Lualine styles applied silently
        end,
        once = true,
      })

      -- Dodatkowe kolory dla lepszej widoczności Lualine
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          print("🎨 ColorScheme autocommand triggered - applying Lualine styles...")
          
          -- Kolory dla różnych sekcji Lualine
          vim.api.nvim_set_hl(0, "LualineModeNormal", { bg = enhanced_colors.accent_purple, fg = colors.base, bold = true })
          vim.api.nvim_set_hl(0, "LualineModeInsert", { bg = enhanced_colors.accent_green, fg = colors.base, bold = true })
          vim.api.nvim_set_hl(0, "LualineModeVisual", { bg = enhanced_colors.accent_yellow, fg = colors.base, bold = true })
          vim.api.nvim_set_hl(0, "LualineModeCommand", { bg = enhanced_colors.accent_yellow, fg = colors.base, bold = true })
          vim.api.nvim_set_hl(0, "LualineModeReplace", { bg = enhanced_colors.accent_red, fg = colors.base, bold = true })
          
          -- Autocommand do stosowania nowych stylów przy każdym otwarciu pliku
          vim.api.nvim_create_autocmd("BufEnter", {
            callback = function()
              -- Wymuś odświeżenie status bar i Lualine
              vim.cmd([[redrawstatus]])
              vim.cmd([[lua require('lualine').refresh()]])
            end,
          })
          
          -- Dodatkowy autocommand dla zmiany trybu
          vim.api.nvim_create_autocmd("ModeChanged", {
            callback = function()
              -- Odśwież style przy zmianie trybu
              vim.cmd([[redrawstatus]])
              -- Wymuś odświeżenie Lualine
              vim.cmd([[lua require('lualine').refresh()]])
            end,
          })
          
          -- Autocommand dla zmiany typu pliku
          vim.api.nvim_create_autocmd("FileType", {
            callback = function()
              -- Stosuj style przy zmianie typu pliku
              vim.cmd([[redrawstatus]])
            end,
          })
          
          -- Autocommand dla każdego bufora
          vim.api.nvim_create_autocmd("BufWinEnter", {
            callback = function()
              -- Stosuj style przy wejściu do okna bufora
              vim.cmd([[redrawstatus]])
            end,
          })
          
          -- Kolory dla sekcji b (branch, diff, diagnostics)
          vim.api.nvim_set_hl(0, "LualineSectionB", { bg = enhanced_colors.bright_surface, fg = enhanced_colors.bright_text })
          
          -- Kolory dla sekcji c (filename, filesize)
          vim.api.nvim_set_hl(0, "LualineSectionC", { bg = colors.surface0, fg = enhanced_colors.bright_subtext })
          
          -- Kolory dla sekcji x (encoding, fileformat, filetype)
          vim.api.nvim_set_hl(0, "LualineSectionX", { bg = colors.surface0, fg = enhanced_colors.bright_subtext })
          
          -- Kolory dla sekcji y (progress)
          vim.api.nvim_set_hl(0, "LualineSectionY", { bg = colors.surface0, fg = enhanced_colors.bright_subtext })
          
          -- Kolory dla sekcji z (location)
          vim.api.nvim_set_hl(0, "LualineSectionZ", { bg = colors.surface0, fg = enhanced_colors.bright_subtext })
          
          -- Kolory dla separatorów - teraz bardziej widoczne
          vim.api.nvim_set_hl(0, "LualineSeparator", { bg = colors.surface0, fg = enhanced_colors.bright_overlay })
          vim.api.nvim_set_hl(0, "LualineComponentSeparator", { bg = colors.surface0, fg = enhanced_colors.bright_overlay })
          
          -- Dodatkowe kolory dla separatorów - upewniamy się, że są widoczne
          vim.api.nvim_set_hl(0, "LualineComponentSeparatorLeft", { bg = colors.surface0, fg = enhanced_colors.bright_overlay })
          vim.api.nvim_set_hl(0, "LualineComponentSeparatorRight", { bg = colors.surface0, fg = enhanced_colors.bright_overlay })
          vim.api.nvim_set_hl(0, "LualineSectionSeparatorLeft", { bg = colors.surface0, fg = enhanced_colors.bright_overlay })
          vim.api.nvim_set_hl(0, "LualineSectionSeparatorRight", { bg = colors.surface0, fg = enhanced_colors.bright_overlay })
          
          -- Kolory dla nieaktywnych sekcji
          vim.api.nvim_set_hl(0, "LualineInactive", { bg = colors.surface2, fg = enhanced_colors.bright_overlay })
          
          -- Dodatkowe kolory dla lepszej widoczności
          vim.api.nvim_set_hl(0, "LualineNormal", { bg = colors.surface0, fg = enhanced_colors.bright_text })
          vim.api.nvim_set_hl(0, "LualineInsert", { bg = colors.surface0, fg = enhanced_colors.bright_text })
          vim.api.nvim_set_hl(0, "LualineVisual", { bg = colors.surface0, fg = enhanced_colors.bright_text })
          vim.api.nvim_set_hl(0, "LualineCommand", { bg = colors.surface0, fg = enhanced_colors.bright_text })
          vim.api.nvim_set_hl(0, "LualineReplace", { bg = colors.surface0, fg = enhanced_colors.bright_text })
          
          -- ColorScheme autocommand completed silently
        end,
      })

      -- Lualine configured silently with Catppuccin Moka theme
      
      -- Sprawdź czy statusline jest widoczny
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.o.laststatus == 3 then
            -- Global statusline enabled silently
          else
            -- Global statusline not enabled silently
          end
        end,
      })
    end,
  },
}
