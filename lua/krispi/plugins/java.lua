return {
  -- Java Development z nvim-jdtls
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = {
      "mfussenegger/nvim-dap", -- Debugging support
      "rcarriga/nvim-dap-ui", -- DAP UI
    },
    config = function()
      -- Konfiguracja jdtls zostanie załadowana przez autocmd
      local jdtls_group = vim.api.nvim_create_augroup("jdtls_lsp", { clear = true })
      
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        group = jdtls_group,
        callback = function()
          local jdtls = require("jdtls")
          local mason_registry = require("mason-registry")
          
          -- Ścieżka do jdtls zainstalowanego przez Mason
          local jdtls_install = mason_registry.get_package("jdtls"):get_install_path()
          
          -- Znajdź wersję Eclipse JDT LS
          local jdtls_jar = vim.fn.glob(jdtls_install .. "/plugins/org.eclipse.jdt.ls.core_*.jar")
          if jdtls_jar == "" then
            vim.notify("JDTLS jar not found!", vim.log.levels.ERROR)
            return
          end
          
          -- Konfiguracja workspace (unikalna dla każdego projektu)
          local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
          local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name
          
          -- Konfiguracja JDTLS
          local config = {
            cmd = {
              "java",
              "-Declipse.application=org.eclipse.jdt.ls.core.id1",
              "-Dosgi.bundles.defaultStartLevel=4",
              "-Declipse.product=org.eclipse.jdt.ls.core.product",
              "-Dlog.protocol=true",
              "-Dlog.level=ALL",
              "-Xmx1g",
              "--add-modules=ALL-SYSTEM",
              "--add-opens", "java.base/java.util=ALL-UNNAMED",
              "--add-opens", "java.base/java.lang=ALL-UNNAMED",
              "-jar", jdtls_jar,
              "-configuration", jdtls_install .. "/config_linux",
              "-data", workspace_dir,
            },
            
            root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
            
            settings = {
              java = {
                eclipse = {
                  downloadSources = true,
                },
                configuration = {
                  updateBuildConfiguration = "interactive",
                },
                maven = {
                  downloadSources = true,
                },
                implementationsCodeLens = {
                  enabled = true,
                },
                referencesCodeLens = {
                  enabled = true,
                },
                references = {
                  includeDecompiledSources = true,
                },
                format = {
                  enabled = true,
                  settings = {
                    url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
                    profile = "GoogleStyle",
                  },
                },
              },
              signatureHelp = { enabled = true },
              completion = {
                favoriteStaticMembers = {
                  "org.hamcrest.MatcherAssert.assertThat",
                  "org.hamcrest.Matchers.*",
                  "org.hamcrest.CoreMatchers.*",
                  "org.junit.jupiter.api.Assertions.*",
                  "java.util.Objects.requireNonNull",
                  "java.util.Objects.requireNonNullElse",
                  "org.mockito.Mockito.*",
                },
              },
              contentProvider = { preferred = "fernflower" },
              extendedClientCapabilities = jdtls.extendedClientCapabilities,
              sources = {
                organizeImports = {
                  starThreshold = 9999,
                  staticStarThreshold = 9999,
                },
              },
              codeGeneration = {
                toString = {
                  template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                useBlocks = true,
              },
            },
            
            flags = {
              allow_incremental_sync = true,
            },
            
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            
            -- Inicjalizacja
            init_options = {
              bundles = {},
            },
          }
          
          -- Skróty klawiszowe specyficzne dla Java
          config.on_attach = function(client, bufnr)
            local keymap = vim.keymap
            local opts = { buffer = bufnr, silent = true }
            
            -- Java-specific keymaps
            opts.desc = "Organize imports"
            keymap.set("n", "<leader>jo", "<cmd>lua require('jdtls').organize_imports()<CR>", opts)
            
            opts.desc = "Extract variable"
            keymap.set("n", "<leader>jv", "<cmd>lua require('jdtls').extract_variable()<CR>", opts)
            keymap.set("v", "<leader>jv", "<cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
            
            opts.desc = "Extract constant"
            keymap.set("n", "<leader>jc", "<cmd>lua require('jdtls').extract_constant()<CR>", opts)
            keymap.set("v", "<leader>jc", "<cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
            
            opts.desc = "Extract method"
            keymap.set("v", "<leader>jm", "<cmd>lua require('jdtls').extract_method(true)<CR>", opts)
            
            opts.desc = "Test nearest method"
            keymap.set("n", "<leader>jt", "<cmd>lua require('jdtls').test_nearest_method()<CR>", opts)
            
            opts.desc = "Test class"
            keymap.set("n", "<leader>jT", "<cmd>lua require('jdtls').test_class()<CR>", opts)
            
            opts.desc = "Update project config"
            keymap.set("n", "<leader>ju", "<cmd>JdtUpdateConfig<CR>", opts)
            
            -- DAP (debugging)
            opts.desc = "Debug nearest method"
            keymap.set("n", "<leader>jd", "<cmd>lua require('jdtls').test_nearest_method({config_overrides = {type = 'java'}})<CR>", opts)
            
            -- Compile
            opts.desc = "Compile workspace"
            keymap.set("n", "<leader>jw", "<cmd>lua require('jdtls').compile('full')<CR>", opts)
          end
          
          -- Uruchom JDTLS
          jdtls.start_or_attach(config)
        end,
      })
    end,
  },
  
  -- DAP (Debug Adapter Protocol) dla Java
  {
    "mfussenegger/nvim-dap",
    ft = { "java", "c", "cpp" },
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      
      -- Konfiguracja DAP UI
      dapui.setup()
      
      -- Virtual text podczas debugowania
      require("nvim-dap-virtual-text").setup()
      
      -- Automatyczne otwieranie/zamykanie DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      
      -- Skróty klawiszowe dla debugowania
      local keymap = vim.keymap
      
      keymap.set("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", { desc = "Toggle breakpoint" })
      keymap.set("n", "<leader>dc", "<cmd>lua require('dap').continue()<CR>", { desc = "Continue debugging" })
      keymap.set("n", "<leader>di", "<cmd>lua require('dap').step_into()<CR>", { desc = "Step into" })
      keymap.set("n", "<leader>do", "<cmd>lua require('dap').step_over()<CR>", { desc = "Step over" })
      keymap.set("n", "<leader>dO", "<cmd>lua require('dap').step_out()<CR>", { desc = "Step out" })
      keymap.set("n", "<leader>dr", "<cmd>lua require('dap').repl.open()<CR>", { desc = "Open REPL" })
      keymap.set("n", "<leader>dl", "<cmd>lua require('dap').run_last()<CR>", { desc = "Run last" })
      keymap.set("n", "<leader>du", "<cmd>lua require('dapui').toggle()<CR>", { desc = "Toggle DAP UI" })
      keymap.set("n", "<leader>dt", "<cmd>lua require('dap').terminate()<CR>", { desc = "Terminate debugging" })
    end,
  },
  
  -- Testowanie Java (opcjonalne)
  {
    "nvim-neotest/neotest",
    ft = { "java", "c", "cpp" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "rcasia/neotest-java", -- Java test adapter
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-java")({
            ignore_wrapper = false, -- don't ignore Gradle/Maven wrapper
          }),
        },
      })
      
      -- Skróty klawiszowe dla testów
      local keymap = vim.keymap
      
      keymap.set("n", "<leader>tn", "<cmd>lua require('neotest').run.run()<CR>", { desc = "Run nearest test" })
      keymap.set("n", "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", { desc = "Run file tests" })
      keymap.set("n", "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", { desc = "Debug nearest test" })
      keymap.set("n", "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<CR>", { desc = "Toggle test summary" })
      keymap.set("n", "<leader>to", "<cmd>lua require('neotest').output.open({enter = true})<CR>", { desc = "Show test output" })
    end,
  },
}
