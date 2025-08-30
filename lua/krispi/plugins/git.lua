return {
  {
    "tpope/vim-fugitive",
    dependencies = {
      "tpope/vim-rhubarb", -- GitHub integration
    },
    config = function()
      -- set keymaps
      local keymap = vim.keymap -- for conciseness

      -- Git operations
      keymap.set("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Git status" })
      keymap.set("n", "<leader>ga", "<cmd>Git add .<cr>", { desc = "Git add all" })
      keymap.set("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "Git commit" })
      keymap.set("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Git push" })
      keymap.set("n", "<leader>gl", "<cmd>Git pull<cr>", { desc = "Git pull" })
      
      -- Note: Additional Git keybindings are centralized in core/leader-mappings.lua
      -- This prevents conflicts and provides a single source of truth for all mappings
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require("gitsigns")
      
      gitsigns.setup({
        signs = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          
          -- Kolory Catppuccin Moka dla Gitsigns
          vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
              vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#A6E3A1" })
              vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#FAB387" })
              vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#F38BA8" })
              vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#A6E3A1" })
              vim.api.nvim_set_hl(0, "GitSignsTopDelete", { fg = "#F38BA8" })
              vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "#F9E2AF" })
              vim.api.nvim_set_hl(0, "GitSignsAddInline", { fg = "#A6E3A1" })
              vim.api.nvim_set_hl(0, "GitSignsChangeInline", { fg = "#FAB387" })
              vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { fg = "#F38BA8" })
              vim.api.nvim_set_hl(0, "GitSignsDeleteVirtLn", { fg = "#F38BA8" })
              vim.api.nvim_set_hl(0, "GitSignsAddVirtLn", { fg = "#A6E3A1" })
              vim.api.nvim_set_hl(0, "GitSignsChangeVirtLn", { fg = "#FAB387" })
            end,
          })

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true, desc = "Next git hunk"})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true, desc = "Previous git hunk"})

          -- Actions
          map('n', '<leader>hs', gs.stage_hunk, { desc = "Stage hunk" })
          map('n', '<leader>hr', gs.reset_hunk, { desc = "Reset hunk" })
          map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage hunk" })
          map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset hunk" })
          map('n', '<leader>hS', gs.stage_buffer, { desc = "Stage buffer" })
          map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Undo stage hunk" })
          map('n', '<leader>hR', gs.reset_buffer, { desc = "Reset buffer" })
          map('n', '<leader>hp', gs.preview_hunk, { desc = "Preview hunk" })
          map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = "Blame line" })
          map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "Toggle git blame line" })
          map('n', '<leader>hd', gs.diffthis, { desc = "Diff this" })
          map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Diff this ~" })
          map('n', '<leader>td', gs.toggle_deleted, { desc = "Toggle git deleted" })

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Gitsigns select hunk" })
        end
      })
    end,
  },
}