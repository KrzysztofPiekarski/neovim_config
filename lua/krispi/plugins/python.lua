return {
  -- Python Development Enhancement
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    config = function()
      require("venv-selector").setup({
        -- Your options go here
        name = "venv",
        auto_refresh = false,
        search_venv_managers = true,
        search_workspace = true,
        search = true,
        dap_enabled = true, -- makes the debugger work with venv
        
        -- Path options
        path = ".",
        parents = 2,
        name_only = false,
        full_name = false,
        
        -- Telescope options
        telescope_filter_type = "substring",
        telescope_color_scheme = "dropdown",
      })
      
      -- Python venv keymaps
      local keymap = vim.keymap
      keymap.set("n", "<leader>vs", "<cmd>VenvSelect<CR>", { desc = "Select Python venv" })
      keymap.set("n", "<leader>vc", "<cmd>VenvSelectCached<CR>", { desc = "Select cached Python venv" })
    end,
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  },

  -- Python testing with pytest
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          dap = { justMyCode = false },
          args = { "--log-level", "DEBUG" },
          runner = "pytest",
          python = ".venv/bin/python",
        },
      },
    },
  },

  -- Python debugging
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "mfussenegger/nvim-dap-python",
      -- "nvim-neotest/nvim-nio",
    },
    config = function()
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      
      -- Python debugging keymaps
      local keymap = vim.keymap
      keymap.set("n", "<leader>dpr", function() require('dap-python').test_method() end, { desc = "Debug Python Test Method" })
      keymap.set("n", "<leader>dpc", function() require('dap-python').test_class() end, { desc = "Debug Python Test Class" })
      keymap.set("v", "<leader>dps", function() require('dap-python').debug_selection() end, { desc = "Debug Python Selection" })
    end,
  },

  -- Python REPL
  {
    "Vigemus/iron.nvim",
    ft = { "python" },
    config = function()
      local iron = require("iron.core")
      
      iron.setup({
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { "zsh" }
            },
            python = {
              command = { "python3" },  -- or { "ipython", "--no-autoindent" }
              format = require("iron.fts.common").bracketed_paste,
            },
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = require('iron.view').bottom(40),
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
          send_motion = "<space>sc",
          visual_send = "<space>sc",
          send_file = "<space>sf",
          send_line = "<space>sl",
          send_until_cursor = "<space>su",
          send_mark = "<space>sm",
          mark_motion = "<space>mc",
          mark_visual = "<space>mc",
          remove_mark = "<space>md",
          cr = "<space>s<cr>",
          interrupt = "<space>s<space>",
          exit = "<space>sq",
          clear = "<space>cl",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      })

      -- Python REPL keymaps
      local keymap = vim.keymap
      keymap.set("n", "<leader>rs", "<cmd>IronRepl<CR>", { desc = "Start Python REPL" })
      keymap.set("n", "<leader>rr", "<cmd>IronRestart<CR>", { desc = "Restart Python REPL" })
      keymap.set("n", "<leader>rf", "<cmd>IronFocus<CR>", { desc = "Focus Python REPL" })
      keymap.set("n", "<leader>rh", "<cmd>IronHide<CR>", { desc = "Hide Python REPL" })
    end,
  },

  -- Python docstring generator
  {
    "danymat/neogen",
    ft = { "python", "go", "javascript", "typescript", "rust", "java", "c", "cpp" },
    config = function()
      require('neogen').setup({
        enabled = true,
        languages = {
          python = {
            template = {
              annotation_convention = "google_docstrings"
            }
          },
          go = {
            template = {
              annotation_convention = "godoc"
            }
          },
        }
      })
      
      -- Docstring keymaps
      local keymap = vim.keymap
      keymap.set("n", "<leader>nf", "<cmd>lua require('neogen').generate()<CR>", { desc = "Generate docstring" })
      keymap.set("n", "<leader>nc", "<cmd>lua require('neogen').generate({ type = 'class' })<CR>", { desc = "Generate class docstring" })
      keymap.set("n", "<leader>nt", "<cmd>lua require('neogen').generate({ type = 'type' })<CR>", { desc = "Generate type docstring" })
    end,
  },

  -- Python refactoring
  {
    "ThePrimeagen/refactoring.nvim",
    ft = { "python", "go", "javascript", "typescript", "java", "c", "cpp" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup({
        prompt_func_return_type = {
          go = false,
          java = false,
          cpp = false,
          c = false,
          h = false,
          hpp = false,
          cxx = false,
        },
        prompt_func_param_type = {
          go = false,
          java = false,
          cpp = false,
          c = false,
          h = false,
          hpp = false,
          cxx = false,
        },
        printf_statements = {},
        print_var_statements = {},
      })
      
      -- Refactoring keymaps
      local keymap = vim.keymap
      
      -- Extract function supports only visual mode
      keymap.set("x", "<leader>re", "<cmd>lua require('refactoring').refactor('Extract Function')<CR>", { desc = "Extract Function" })
      keymap.set("x", "<leader>rf", "<cmd>lua require('refactoring').refactor('Extract Function To File')<CR>", { desc = "Extract Function To File" })
      
      -- Extract variable supports only visual mode
      keymap.set("x", "<leader>rv", "<cmd>lua require('refactoring').refactor('Extract Variable')<CR>", { desc = "Extract Variable" })
      
      -- Inline func supports only normal
      keymap.set("n", "<leader>rI", "<cmd>lua require('refactoring').refactor('Inline Function')<CR>", { desc = "Inline Function" })
      
      -- Inline var supports both normal and visual mode
      keymap.set({ "n", "x" }, "<leader>ri", "<cmd>lua require('refactoring').refactor('Inline Variable')<CR>", { desc = "Inline Variable" })
      
      -- Extract block supports only normal mode
      keymap.set("n", "<leader>rb", "<cmd>lua require('refactoring').refactor('Extract Block')<CR>", { desc = "Extract Block" })
      keymap.set("n", "<leader>rbf", "<cmd>lua require('refactoring').refactor('Extract Block To File')<CR>", { desc = "Extract Block To File" })
      
      -- Print var
      keymap.set({"x", "n"}, "<leader>rp", function() require('refactoring').debug.print_var() end, { desc = "Print Variable" })
      -- Supports both visual and normal mode
      keymap.set("n", "<leader>rc", function() require('refactoring').debug.cleanup({}) end, { desc = "Cleanup Debug Prints" })
    end,
  },

  -- Python-specific snippets and utilities
  {
    "AckslD/swenv.nvim",
    ft = "python",
    config = function()
      require('swenv').setup({
        -- Should return a list of tables with a `name` and a `path` entry each.
        -- Gets the argument passed to `auto_venv`.
        get_venvs = function(venvs_path)
          return require('swenv.api').get_venvs(venvs_path)
        end,
        -- Path passed to `get_venvs`.
        venvs_path = vim.fn.expand('~/venvs'),
        -- Something to do after setting an environment, for example call vim.cmd.LspRestart
        post_set_venv = nil,
      })
      
      vim.keymap.set("n", "<leader>ve", "<cmd>lua require('swenv.api').pick_venv()<CR>", { desc = "Choose Python venv" })
    end,
  },
}
