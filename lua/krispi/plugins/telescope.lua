return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          prompt_prefix = " 🔍 ",
          selection_caret = " ❯ ",
          path_display = { "truncate" },
          file_sorter = require("telescope.sorters").get_fuzzy_file,
          generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
          winblend = 0,
          border = {},
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          color_devicons = true,
          use_less = true,
          set_env = { ["COLORTERM"] = "truecolor" },
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
          buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["<CR>"] = actions.select_default,
              ["<C-s>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<C-f>"] = actions.results_scrolling_up,
              ["<C-b>"] = actions.results_scrolling_down,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-l>"] = actions.complete_tag,
              ["<C-_>"] = actions.which_key,
            },
            n = {
              ["<esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-s>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<C-f>"] = actions.results_scrolling_up,
              ["<C-b>"] = actions.results_scrolling_down,
              ["?"] = actions.which_key,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = { "find", ".", "-type", "f", "-not", "-path", "*/\\.*" },
            hidden = true,
            no_ignore = false,
            no_ignore_parent = false,
          },
          git_files = {
            git_command = { "git", "ls-files", "--exclude-standard" },
            hidden = true,
            no_ignore = false,
            no_ignore_parent = false,
          },
          oldfiles = {
            cwd_only = false,
            sort_lastused = true,
            results_title = "Recent Files",
            prompt_title = "Recent Files",
            max_results = 100,
          },
          live_grep = {
            additional_args = function()
              return { "--hidden" }
            end,
          },
          grep_string = {
            additional_args = function()
              return { "--hidden" }
            end,
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              borderchars = {
                prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
                results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
                preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
              },
            }),
          },
        },
      })

      telescope.load_extension("ui-select")

      -- Kolory Catppuccin Moka dla Telescope
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#1E1E2E", fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "#1E1E2E", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#313244", fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "#313244", fg = "#6C7086" })
          vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = "#313244", fg = "#CBA6F7", bold = true })
          vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bg = "#1E1E2E", fg = "#89B4FA", bold = true })
          vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bg = "#1E1E2E", fg = "#A6E3A1", bold = true })
          vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { bg = "#313244", fg = "#CBA6F7" })
          vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#313244", fg = "#CDD6F4" })
          vim.api.nvim_set_hl(0, "TelescopeMatching", { bg = "#1E1E2E", fg = "#F9E2AF" })
        end,
      })

      -- Custom pickers
      local M = {}
      M.project_files = function()
        local _, ret, _ = require("telescope.utils").get_os_command_output({
          "git",
          "rev-parse",
          "--is-inside-work-tree",
        })
        if ret == 0 then
          require("telescope.builtin").git_files()
        else
          require("telescope.builtin").find_files()
        end
      end

      -- Keymaps
      vim.keymap.set("n", "<leader>ff", M.project_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
      vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Old Files" })
      vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Commands" })
      vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Marks" })
      vim.keymap.set("n", "<leader>fr", builtin.registers, { desc = "Registers" })
      vim.keymap.set("n", "<leader>fs", builtin.spell_suggest, { desc = "Spell Suggest" })
      vim.keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "Treesitter" })
    end,
  },
}
