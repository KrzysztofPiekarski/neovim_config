return {
  -- Enhanced C/C++ Development
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("clangd_extensions").setup({
        inlay_hints = {
          inline = vim.fn.has("nvim-0.10") == 1,
          -- Options other than `highlight' and `priority' only work
          -- if `inline' is disabled
          only_current_line = false,
          only_current_line_autocmd = "CursorHold",
          show_parameter_hints = true,
          parameter_hints_prefix = "<- ",
          other_hints_prefix = "=> ",
          max_len_align = false,
          max_len_align_padding = 1,
          right_align = false,
          right_align_padding = 7,
          highlight = "Comment",
          priority = 100,
        },
        ast = {
          role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
          },
          kind_icons = {
            Compound = "",
            Recovery = "",
            TranslationUnit = "",
            PackExpansion = "",
            TemplateTypeParm = "",
            TemplateTemplateParm = "",
            TemplateParamObject = "",
          },
        },
        memory_usage = {
          border = "none",
        },
        symbol_info = {
          border = "none",
        },
      })
    end,
  },

  -- CMake support
  {
    "Civitasv/cmake-tools.nvim",
    ft = { "c", "cpp", "cmake" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("cmake-tools").setup({
        cmake_command = "cmake",
        ctest_command = "ctest",
        cmake_use_preset = true,
        cmake_regenerate_on_save = true,
        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
        cmake_build_options = {},
        cmake_build_directory = "build/${variant:buildType}",
        cmake_soft_link_compile_commands = true,
        cmake_compile_commands_from_lsp = false,
        cmake_kits_path = nil,
        cmake_variants_message = {
          short = { show = true },
          long = { show = true, max_length = 40 },
        },
        cmake_dap_configuration = {
          name = "cpp",
          type = "codelldb",
          request = "launch",
        },
        cmake_executor = {
          name = "quickfix",
          opts = {},
          default_opts = {
            quickfix = {
              show = "always",
              position = "belowright",
              size = 10,
              encoding = "utf-8",
              auto_close_when_success = true,
            },
          },
        },
        cmake_runner = {
          name = "terminal",
          opts = {},
          default_opts = {
            quickfix = {
              show = "always",
              position = "belowright",
              size = 10,
              encoding = "utf-8",
              auto_close_when_success = false,
            },
            toggleterm = {
              direction = "float",
              close_on_exit = false,
              auto_scroll = true,
            },
            overseer = {
              new_task_opts = {
                strategy = {
                  "toggleterm",
                  direction = "horizontal",
                  autos_croll = true,
                  quit_on_exit = "success"
                }
              },
            },
            terminal = {
              name = "Main Terminal",
              prefix_name = "[CMakeTools]: ",
              split_direction = "horizontal",
              split_size = 11,
            },
          },
        },
        cmake_notifications = {
          runner = { enabled = true },
          executor = { enabled = true },
          spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
        },
      })

      -- CMake keymaps
      local keymap = vim.keymap
      
      keymap.set("n", "<leader>cg", "<cmd>CMakeGenerate<CR>", { desc = "CMake Generate" })
      keymap.set("n", "<leader>cb", "<cmd>CMakeBuild<CR>", { desc = "CMake Build" })
      keymap.set("n", "<leader>cr", "<cmd>CMakeRun<CR>", { desc = "CMake Run" })
      keymap.set("n", "<leader>cd", "<cmd>CMakeDebug<CR>", { desc = "CMake Debug" })
      keymap.set("n", "<leader>cy", "<cmd>CMakeSelectBuildType<CR>", { desc = "CMake Select Build Type" })
      keymap.set("n", "<leader>ct", "<cmd>CMakeSelectBuildTarget<CR>", { desc = "CMake Select Build Target" })
      keymap.set("n", "<leader>cT", "<cmd>CMakeSelectLaunchTarget<CR>", { desc = "CMake Select Launch Target" })
      keymap.set("n", "<leader>cc", "<cmd>CMakeClean<CR>", { desc = "CMake Clean" })
      keymap.set("n", "<leader>cs", "<cmd>CMakeStop<CR>", { desc = "CMake Stop" })
      keymap.set("n", "<leader>ci", "<cmd>CMakeInstall<CR>", { desc = "CMake Install" })
      keymap.set("n", "<leader>cq", "<cmd>CMakeQuickBuild<CR>", { desc = "CMake Quick Build" })
      keymap.set("n", "<leader>cQ", "<cmd>CMakeQuickRun<CR>", { desc = "CMake Quick Run" })
      keymap.set("n", "<leader>cD", "<cmd>CMakeQuickDebug<CR>", { desc = "CMake Quick Debug" })
    end,
  },

  -- C/C++ Header/Source switching
  {
    "jakemason/ouroboros",
    ft = { "c", "cpp", "objc", "objcpp" },
    config = function()
      require("ouroboros").setup({
        -- Example configuration
        extension_preferences_table = {
          c = { h = 2, hpp = 1 },
          h = { c = 2, cpp = 1, cc = 1 },
          cpp = { hpp = 2, h = 1 },
          hpp = { cpp = 2, c = 1 },
        },
        switch_to_open_pane_if_possible = true,
      })

      vim.keymap.set("n", "<leader>ch", "<cmd>Ouroboros<CR>", { desc = "Switch Header/Source" })
    end,
  },

  -- C/C++ specific DAP configuration enhancement
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      
      -- C/C++ debugger configuration
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.exepath("codelldb"),
          args = { "--port", "${port}" },
        },
      }
      
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
        {
          name = "Launch file with arguments",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
          end,
        },
      }
      
      -- Copy cpp configuration to c
      dap.configurations.c = dap.configurations.cpp
    end,
  },
}
