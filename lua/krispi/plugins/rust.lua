return {
  -- Complete Rust Development Environment
  {
    -- Main Rust plugin with LSP and tools integration
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          -- Hover actions
          hover_actions = {
            auto_focus = true,
            border = "rounded",
          },
          -- Code actions
          code_actions = {
            ui_select_fallback = true,
          },
          -- Float window options
          float_win_config = {
            border = "rounded",
          },
        },
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            -- Custom on_attach function for Rust
            local keymap = vim.keymap
            local opts = { buffer = bufnr, silent = true }

            -- Rust-specific keymaps
            keymap.set("n", "<leader>rr", "<cmd>RustLsp runnables<CR>", 
              vim.tbl_extend("force", opts, { desc = "Rust Runnables" }))
            
            keymap.set("n", "<leader>rd", "<cmd>RustLsp debuggables<CR>", 
              vim.tbl_extend("force", opts, { desc = "Rust Debuggables" }))
            
            keymap.set("n", "<leader>rt", "<cmd>RustLsp testables<CR>", 
              vim.tbl_extend("force", opts, { desc = "Rust Testables" }))
            
            keymap.set("n", "<leader>re", "<cmd>RustLsp expandMacro<CR>", 
              vim.tbl_extend("force", opts, { desc = "Expand Rust Macro" }))
            
            keymap.set("n", "<leader>rc", "<cmd>RustLsp openCargo<CR>", 
              vim.tbl_extend("force", opts, { desc = "Open Cargo.toml" }))
            
            keymap.set("n", "<leader>rp", "<cmd>RustLsp parentModule<CR>", 
              vim.tbl_extend("force", opts, { desc = "Parent Module" }))
            
            keymap.set("n", "<leader>rm", "<cmd>RustLsp rebuildProcMacros<CR>", 
              vim.tbl_extend("force", opts, { desc = "Rebuild Proc Macros" }))
            
            keymap.set("n", "<leader>rh", "<cmd>RustLsp renderDiagnostic<CR>", 
              vim.tbl_extend("force", opts, { desc = "Render Diagnostic" }))
            
            keymap.set("n", "<leader>rE", "<cmd>RustLsp explainError<CR>", 
              vim.tbl_extend("force", opts, { desc = "Explain Error" }))
            
            keymap.set("n", "<leader>rC", "<cmd>RustLsp openDocs<CR>", 
              vim.tbl_extend("force", opts, { desc = "Open Rust Docs" }))

            -- Hover and signature help
            keymap.set("n", "K", "<cmd>RustLsp hover actions<CR>", 
              vim.tbl_extend("force", opts, { desc = "Hover Actions" }))
            
            keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, 
              vim.tbl_extend("force", opts, { desc = "Signature Help" }))

            -- Code actions with Rust-specific actions
            keymap.set({ "n", "v" }, "<leader>ca", "<cmd>RustLsp codeAction<CR>", 
              vim.tbl_extend("force", opts, { desc = "Code Action" }))
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              -- Add clippy lints for Rust
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
              -- Inlay hints
              inlayHints = {
                bindingModeHints = {
                  enable = false,
                },
                chainingHints = {
                  enable = true,
                },
                closingBraceHints = {
                  enable = true,
                  minLines = 25,
                },
                closureReturnTypeHints = {
                  enable = "never",
                },
                lifetimeElisionHints = {
                  enable = "never",
                  useParameterNames = false,
                },
                maxLength = 25,
                parameterHints = {
                  enable = true,
                },
                reborrowHints = {
                  enable = "never",
                },
                renderColons = true,
                typeHints = {
                  enable = true,
                  hideClosureInitialization = false,
                  hideNamedConstructor = false,
                },
              },
            },
          },
        },
        -- DAP configuration
        dap = {
          adapter = {
            type = "executable",
            command = "lldb-vscode", -- or codelldb
            name = "rt_lldb",
          },
        },
      }

      -- Additional Rust commands
      vim.api.nvim_create_user_command("RustAnalyzerRestart", function()
        vim.cmd("RustLsp restart")
      end, { desc = "Restart Rust Analyzer" })

      vim.api.nvim_create_user_command("RustCheck", function()
        vim.fn.jobstart("cargo check", {
          on_exit = function(_, exit_code)
            if exit_code == 0 then
              vim.notify("✅ Cargo check passed!", vim.log.levels.INFO)
            else
              vim.notify("❌ Cargo check failed!", vim.log.levels.ERROR)
            end
          end,
        })
      end, { desc = "Run cargo check" })

      vim.api.nvim_create_user_command("RustTest", function()
        vim.fn.jobstart("cargo test", {
          on_exit = function(_, exit_code)
            if exit_code == 0 then
              vim.notify("✅ All tests passed!", vim.log.levels.INFO)
            else
              vim.notify("❌ Some tests failed!", vim.log.levels.ERROR)
            end
          end,
        })
      end, { desc = "Run cargo test" })

      vim.api.nvim_create_user_command("RustBuild", function()
        vim.fn.jobstart("cargo build", {
          on_exit = function(_, exit_code)
            if exit_code == 0 then
              vim.notify("✅ Build successful!", vim.log.levels.INFO)
            else
              vim.notify("❌ Build failed!", vim.log.levels.ERROR)
            end
          end,
        })
      end, { desc = "Run cargo build" })

      vim.api.nvim_create_user_command("RustRun", function()
        vim.cmd("RustLsp runnables")
      end, { desc = "Show Rust runnables" })
    end,
  },

  {
    -- Crates.io integration for Cargo.toml
    "saecki/crates.nvim",
    tag = "stable",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({
        -- null_ls integration disabled - using conform.nvim and nvim-lint instead
        null_ls = {
          enabled = false,
          name = "crates.nvim",
        },
        popup = {
          border = "rounded",
        },
      })

      -- Crates.nvim keymaps
      local keymap = vim.keymap
      local opts = { silent = true }

      keymap.set("n", "<leader>rct", function()
        require("crates").toggle()
      end, vim.tbl_extend("force", opts, { desc = "Toggle crates" }))

      keymap.set("n", "<leader>rcr", function()
        require("crates").reload()
      end, vim.tbl_extend("force", opts, { desc = "Reload crates" }))

      keymap.set("n", "<leader>rcv", function()
        require("crates").show_versions_popup()
      end, vim.tbl_extend("force", opts, { desc = "Show versions popup" }))

      keymap.set("n", "<leader>rcf", function()
        require("crates").show_features_popup()
      end, vim.tbl_extend("force", opts, { desc = "Show features popup" }))

      keymap.set("n", "<leader>rcd", function()
        require("crates").show_dependencies_popup()
      end, vim.tbl_extend("force", opts, { desc = "Show dependencies popup" }))

      keymap.set("n", "<leader>rcu", function()
        require("crates").update_crate()
      end, vim.tbl_extend("force", opts, { desc = "Update crate" }))

      keymap.set("v", "<leader>rcu", function()
        require("crates").update_crates()
      end, vim.tbl_extend("force", opts, { desc = "Update crates" }))

      keymap.set("n", "<leader>rca", function()
        require("crates").update_all_crates()
      end, vim.tbl_extend("force", opts, { desc = "Update all crates" }))

      keymap.set("n", "<leader>rcU", function()
        require("crates").upgrade_crate()
      end, vim.tbl_extend("force", opts, { desc = "Upgrade crate" }))

      keymap.set("v", "<leader>rcU", function()
        require("crates").upgrade_crates()
      end, vim.tbl_extend("force", opts, { desc = "Upgrade crates" }))

      keymap.set("n", "<leader>rcA", function()
        require("crates").upgrade_all_crates()
      end, vim.tbl_extend("force", opts, { desc = "Upgrade all crates" }))

      keymap.set("n", "<leader>rcH", function()
        require("crates").open_homepage()
      end, vim.tbl_extend("force", opts, { desc = "Open homepage" }))

      keymap.set("n", "<leader>rcR", function()
        require("crates").open_repository()
      end, vim.tbl_extend("force", opts, { desc = "Open repository" }))

      keymap.set("n", "<leader>rcD", function()
        require("crates").open_documentation()
      end, vim.tbl_extend("force", opts, { desc = "Open documentation" }))

      keymap.set("n", "<leader>rcC", function()
        require("crates").open_crates_io()
      end, vim.tbl_extend("force", opts, { desc = "Open crates.io" }))
    end,
  },

  {
    -- Better Rust testing with neotest
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "rouge8/neotest-rust",
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      table.insert(opts.adapters, require("neotest-rust")({
        args = { "--no-capture" },
        dap_adapter = "rt_lldb",
      }))
      return opts
    end,
  },

  {
    -- Rust debugging with DAP
    "mfussenegger/nvim-dap",
    optional = true,
    config = function()
      local dap = require("dap")
      
      -- Rust DAP configuration
      dap.adapters.rt_lldb = {
        type = "executable",
        command = "lldb-vscode", -- or use 'codelldb'
        name = "rt_lldb",
      }

      dap.configurations.rust = {
        {
          name = "Launch",
          type = "rt_lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
          runInTerminal = false,
        },
        {
          name = "Attach to process",
          type = "rt_lldb",
          request = "attach",
          pid = require("dap.utils").pick_process,
          args = {},
        },
      }
    end,
  },

  {
    -- Enhanced syntax highlighting for Rust
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "rust", "toml" })
      end
    end,
  },

  {
    -- Rust-specific snippets
    "L3MON4D3/LuaSnip",
    optional = true,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      -- Load Rust snippets
      require("luasnip.loaders.from_vscode").lazy_load({
        include = { "rust" },
      })

      -- Custom Rust snippets
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      ls.add_snippets("rust", {
        s("fn", {
          t("fn "), i(1, "name"), t("("), i(2), t(") -> "), i(3, "()"), t(" {"),
          t({"", "    "}), i(0),
          t({"", "}"}),
        }),
        s("test", {
          t("#[test]"),
          t({"", "fn "}), i(1, "test_name"), t("() {"),
          t({"", "    "}), i(0),
          t({"", "}"}),
        }),
        s("derive", {
          t("#[derive("), i(1, "Debug"), t(")]"),
        }),
        s("allow", {
          t("#[allow("), i(1, "dead_code"), t(")]"),
        }),
        s("cfg", {
          t("#[cfg("), i(1, "test"), t(")]"),
        }),
        s("main", {
          t("fn main() {"),
          t({"", "    "}), i(0),
          t({"", "}"}),
        }),
        s("impl", {
          t("impl "), i(1, "Type"), t(" {"),
          t({"", "    "}), i(0),
          t({"", "}"}),
        }),
        s("match", {
          t("match "), i(1, "expr"), t(" {"),
          t({"", "    "}), i(2, "pattern"), t(" => "), i(3, "value"), t(","),
          t({"", "    "}), i(0),
          t({"", "}"}),
        }),
      })
    end,
  },

  {
    -- Rust project templates and initialization
    "nvim-lua/plenary.nvim",
    config = function()
      -- Rust project utilities
      local function create_rust_project()
        vim.ui.input({ prompt = "Project name: " }, function(name)
          if not name or name == "" then
            vim.notify("Project name required", vim.log.levels.ERROR)
            return
          end

          local project_types = {
            "Binary (executable)",
            "Library (lib)",
            "Binary and Library (both)",
          }

          vim.ui.select(project_types, {
            prompt = "Select project type:",
          }, function(choice)
            if not choice then return end

            local cmd = "cargo new " .. name
            if choice:match("Library") and not choice:match("both") then
              cmd = cmd .. " --lib"
            end

            vim.fn.jobstart(cmd, {
              on_exit = function(_, exit_code)
                if exit_code == 0 then
                  vim.notify("✅ Created Rust project: " .. name, vim.log.levels.INFO)
                  
                  -- Ask if user wants to open the project
                  vim.ui.select({ "Yes", "No" }, {
                    prompt = "Open project in new tab?",
                  }, function(open_choice)
                    if open_choice == "Yes" then
                      vim.cmd("tabnew")
                      vim.cmd("cd " .. name)
                      vim.cmd("edit Cargo.toml")
                    end
                  end)
                else
                  vim.notify("❌ Failed to create project", vim.log.levels.ERROR)
                end
              end,
            })
          end)
        end)
      end

      local function add_rust_dependency()
        vim.ui.input({ prompt = "Crate name: " }, function(crate_name)
          if not crate_name or crate_name == "" then
            vim.notify("Crate name required", vim.log.levels.ERROR)
            return
          end

          vim.ui.input({ prompt = "Version (optional): " }, function(version)
            local cmd = "cargo add " .. crate_name
            if version and version ~= "" then
              cmd = cmd .. "@" .. version
            end

            vim.fn.jobstart(cmd, {
              on_exit = function(_, exit_code)
                if exit_code == 0 then
                  vim.notify("✅ Added dependency: " .. crate_name, vim.log.levels.INFO)
                else
                  vim.notify("❌ Failed to add dependency", vim.log.levels.ERROR)
                end
              end,
            })
          end)
        end)
      end

      -- Rust project commands
      vim.api.nvim_create_user_command("RustNewProject", create_rust_project, {
        desc = "Create new Rust project with cargo"
      })

      vim.api.nvim_create_user_command("RustAddDep", add_rust_dependency, {
        desc = "Add Rust dependency with cargo"
      })

      vim.api.nvim_create_user_command("RustDoc", function()
        vim.fn.jobstart("cargo doc --open", {
          detach = true,
          on_exit = function(_, exit_code)
            if exit_code == 0 then
              vim.notify("📚 Documentation generated and opened", vim.log.levels.INFO)
            else
              vim.notify("❌ Failed to generate documentation", vim.log.levels.ERROR)
            end
          end,
        })
      end, { desc = "Generate and open Rust documentation" })

      vim.api.nvim_create_user_command("RustClippy", function()
        vim.fn.jobstart("cargo clippy", {
          on_exit = function(_, exit_code)
            if exit_code == 0 then
              vim.notify("✅ Clippy check passed!", vim.log.levels.INFO)
            else
              vim.notify("⚠️  Clippy found issues", vim.log.levels.WARN)
            end
          end,
        })
      end, { desc = "Run Rust Clippy linter" })

      vim.api.nvim_create_user_command("RustFmt", function()
        vim.fn.jobstart("cargo fmt", {
          on_exit = function(_, exit_code)
            if exit_code == 0 then
              vim.notify("✅ Code formatted with rustfmt", vim.log.levels.INFO)
            else
              vim.notify("❌ Failed to format code", vim.log.levels.ERROR)
            end
          end,
        })
      end, { desc = "Format Rust code with rustfmt" })
    end,
  },
}
