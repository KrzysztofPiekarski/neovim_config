return {
  "nvim-neorg/neorg",
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
  dependencies = { 
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim", -- Make sure telescope loads first
  },
  config = function()
    require("neorg").setup {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/Documents/notes", -- Główny workspace dla notatek
              work = "~/Documents/work",   -- Workspace dla pracy
              personal = "~/Documents/personal", -- Workspace osobisty
            },
            default_workspace = "notes",
          },
        },
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp", -- Integracja z nvim-cmp
          }
        },
        ["core.integrations.nvim-cmp"] = {}, -- Włącza completion
        -- Temporarily disable telescope integration to avoid errors
        -- ["core.integrations.telescope"] = {}, -- Integracja z Telescope
        ["core.keybinds"] = {
          config = {
            default_keybinds = true,
            neorg_leader = "<Leader>o", -- Prefix dla komend Neorg
          },
        },
        ["core.summary"] = {}, -- Generowanie podsumowań
        ["core.export"] = {}, -- Eksport do różnych formatów
        ["core.export.markdown"] = {}, -- Eksport do Markdown
        ["core.presenter"] = { -- Prezentacje
          config = {
            zen_mode = "zen-mode", -- Integracja z zen-mode jeśli masz
          }
        },
        ["core.journal"] = { -- Dziennik/Journal
          config = {
            strategy = "flat", -- lub "nested"
            workspace = "notes",
          }
        },
      },
    }

    -- Dodatkowe skróty klawiszowe
    local keymap = vim.keymap

    -- Neorg workspace management
    keymap.set("n", "<leader>ow", "<cmd>Neorg workspace<CR>", { desc = "Open Neorg workspace picker" })
    keymap.set("n", "<leader>on", "<cmd>Neorg workspace notes<CR>", { desc = "Switch to notes workspace" })
    keymap.set("n", "<leader>op", "<cmd>Neorg workspace personal<CR>", { desc = "Switch to personal workspace" })
    keymap.set("n", "<leader>oj", "<cmd>Neorg journal<CR>", { desc = "Open today's journal" })

    -- Neorg file operations
    keymap.set("n", "<leader>oi", "<cmd>Neorg index<CR>", { desc = "Open workspace index" })
    keymap.set("n", "<leader>or", "<cmd>Neorg return<CR>", { desc = "Return to previous buffer" })
    
    -- Telescope integration (temporarily disabled due to fzf issues)
    -- keymap.set("n", "<leader>of", "<cmd>Telescope neorg find_norg_files<CR>", { desc = "Find Neorg files" })
    -- keymap.set("n", "<leader>ol", "<cmd>Telescope neorg find_linkable<CR>", { desc = "Find linkable items" })
    -- keymap.set("n", "<leader>oh", "<cmd>Telescope neorg search_headings<CR>", { desc = "Search headings" })
    
    -- Alternative file finding using standard telescope
    keymap.set("n", "<leader>of", "<cmd>Telescope find_files search_dirs=~/Documents/notes,~/Documents/work,~/Documents/personal<CR>", { desc = "Find Neorg files" })

    -- Export functions
    keymap.set("n", "<leader>oem", "<cmd>Neorg export to-file<CR>", { desc = "Export to markdown" })
    
    -- Task management
    keymap.set("n", "<leader>ot", "<cmd>Neorg toggle-concealer<CR>", { desc = "Toggle concealer" })
    keymap.set("n", "<leader>om", "<cmd>Neorg mode norg<CR>", { desc = "Enter Neorg mode" })
    keymap.set("n", "<leader>oq", "<cmd>Neorg mode traverse-heading<CR>", { desc = "Traverse headings mode" })
  end,
}
