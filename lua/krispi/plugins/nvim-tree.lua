return {
  {
    "nvim-tree/nvim-tree.lua",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local nvim_tree = require("nvim-tree")

      nvim_tree.setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
          side = "left",
        },
        -- Kolory Catppuccin Moka
        update_focused_file = {
          enable = true,
          update_cwd = true,
          ignore_list = {},
        },
        renderer = {
          group_empty = true,
          highlight_git = true,
          icons = {
            git_placement = "before",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
            glyphs = {
              default = "󰈚",
              symlink = "󰉒",
              bookmark = "󰆤",
              modified = "●",
              folder = {
                arrow_closed = "󰅶",
                arrow_open = "󰅷",
                default = "󰉋",
                open = "󰉋",
                empty = "󰉋",
                empty_open = "󰉋",
                symlink = "󰉒",
                symlink_open = "󰉒",
              },
              git = {
                unstaged = "󰄱",
                staged = "✓",
                unmerged = "󰘬",
                renamed = "󰁕",
                untracked = "󰈔",
                deleted = "󰩺",
                ignored = "󰈝",
              },
            },
          },
        },
        filters = {
          dotfiles = false,
          git_ignored = true,
        },
        git = {
          enable = true,
          ignore = false,
          show_on_dirs = true,
          timeout = 400,
        },
        update_focused_file = {
          enable = true,
          update_cwd = true,
          ignore_list = {},
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.ERROR,
          },
          icons = {
            hint = "󰌵",
            info = "󰋼",
            warning = "󰀪",
            error = "󰅚",
          },
        },
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")
          local opts = function(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          -- Default mappings
          api.config.mappings.default_on_attach(bufnr)

          -- Custom mappings
          vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
          vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
          vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
          vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
          vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
          vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
          vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("CD"))
          vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
          vim.keymap.set("n", "a", api.fs.create, opts("Create"))
          vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
          vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
          vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
          vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
          vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
          vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
          vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
          vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
          vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
          vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
          vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
          vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
          vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
          vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
          vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
          vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
          vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
        end,
        actions = {
          use_system_clipboard = true,
          change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
          },
          expand_all = {
            max_folder_discovery = 300,
            exclude = {},
          },
          file_popup = {
            open_win_config = {
              col = 1,
              row = 1,
              relative = "cursor",
              border = "shadow",
              style = "minimal",
            },
          },
          open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
              enable = true,
              chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
              exclude = {
                filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                buftype = { "nofile", "terminal", "help" },
              },
            },
          },
          remove_file = {
            close_window = true,
          },
        },
        trash = {
          cmd = "gio trash",
          require_confirm = true,
        },
        live_filter = {
          prefix = "[FILTER]: ",
          always_show_folders = true,
        },
        tab = {
          sync = {
            open = false,
            close = false,
            ignore = {},
          },
        },
        notify = {
          threshold = vim.log.levels.INFO,
        },
        ui = {
          confirm = {
            remove = true,
            trash = true,
            default_yes = false,
          },
        },
        log = {
          enable = false,
          truncate = true,
          types = {
            all = false,
            config = false,
            copy_paste = false,
            dev = false,
            diagnostics = false,
            git = false,
            profile = false,
            watcher = false,
          },
        },
      })

      -- Keymaps są już zdefiniowane w leader-mappings.lua
      -- vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
      -- vim.keymap.set("n", "<leader>o", "<cmd>NvimTreeFocus<CR>", { desc = "Focus File Explorer" })
      
      -- Kolory Catppuccin Moka dla nvim-tree
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#1E1E2E", fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "#1E1E2E", fg = "#1E1E2E" })
          vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { bg = "#1E1E2E", fg = "#CBA6F7", bold = true })
          vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { bg = "#1E1E2E", fg = "#FAB387" })
          vim.api.nvim_set_hl(0, "NvimTreeGitStaged", { bg = "#1E1E2E", fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "NvimTreeGitMerge", { bg = "#1E1E2E", fg = "#F9E2AF" })
          vim.api.nvim_set_hl(0, "NvimTreeGitRenamed", { bg = "#1E1E2E", fg = "#89B4FA" })
          vim.api.nvim_set_hl(0, "NvimTreeGitNew", { bg = "#1E1E2E", fg = "#A6E3A1" })
          vim.api.nvim_set_hl(0, "NvimTreeImageFile", { bg = "#1E1E2E", fg = "#F5C2E7" })
          vim.api.nvim_set_hl(0, "NvimTreeSymlink", { bg = "#1E1E2E", fg = "#89DCEB" })
          vim.api.nvim_set_hl(0, "NvimTreeFolderName", { bg = "#1E1E2E", fg = "#89B4FA" })
          vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { bg = "#1E1E2E", fg = "#89B4FA", bold = true })
          vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", { bg = "#1E1E2E", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "NvimTreeStatusLineNC", { bg = "#1E1E2E", fg = "#6C7086" })
        end,
      })
    end,
  },
}
