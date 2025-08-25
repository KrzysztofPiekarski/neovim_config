return {
  -- Go Development Enhancement
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua", -- GUI framework
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        -- Podstawowe ustawienia
        go = "go", -- set to go1.18beta1 if you want to use go1.18beta1
        goimport = "gopls", -- goimport command, can be gopls[default] or goimport
        fillstruct = "gopls", -- can be nil (use fillstruct, slower) and gopls
        gofmt = "gofumpt", -- gofmt cmd,
        max_line_len = 120, -- max line length in golines format, Target maximum line length for golines
        
        -- LSP configuration
        lsp_cfg = true, -- false: use your own lspconfig
        lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
        lsp_on_attach = nil, -- use on_attach from go.nvim
        lsp_keymaps = true, -- set to false to disable gopls/lsp keymap
        lsp_codelens = true, -- set to false to disable codelens, true by default, you can use a function
        lsp_diag_hdlr = true, -- hook lsp diag handler
        lsp_diag_underline = true,
        lsp_diag_virtual_text = { space = 0, prefix = "" },
        lsp_diag_signs = true,
        lsp_diag_update_in_insert = false,
        lsp_document_formatting = false,
        
        -- DAP (Debug Adapter Protocol)
        dap_debug = true,
        dap_debug_keymap = true, -- true: use keymap for debugger defined in go/dap.lua
        dap_debug_gui = {}, -- bool|table put your dap-ui setup here set to false to disable
        dap_debug_vt = { enabled_commands = true, all_frames = true }, -- bool|table put your dap-virtual-text setup here set to false to disable
        
        -- Build tags
        build_tags = "", -- set default build tags
        textobjects = true, -- enable default text objects through treesittter-text-objects
        test_runner = "go", -- one of {`go`, `richgo`, `dlv`, `ginkgo`, `gotestsum`}
        verbose_tests = true, -- set to add verbose flag to tests
        run_in_floaterm = false, -- set to true to run in a float window. :GoTermClose closes the floatterm
        
        -- Test options
        trouble = true, -- true: use trouble to open quickfix
        test_efm = false, -- errorfomat for quickfix, default mix mode, set to true will be efm only
        luasnip = true, -- enable included luasnip snippets. B
        
        -- Icons
        icons = {
          breakpoint = "🔴",
          currentpos = "👉",
        },
        
        -- Verbose output
        verbose = false, -- output loginf in messages
        log_path = vim.fn.expand("$HOME") .. "/tmp/gonvim.log",
        
        -- Auto commands
        auto_format = false,
        auto_lint = true,
      })
      
      -- Go specific keymaps
      local keymap = vim.keymap
      
      -- Go run and build
      keymap.set("n", "<leader>gr", "<cmd>GoRun<CR>", { desc = "Go Run" })
      keymap.set("n", "<leader>gb", "<cmd>GoBuild<CR>", { desc = "Go Build" })
      keymap.set("n", "<leader>gi", "<cmd>GoInstall<CR>", { desc = "Go Install" })
      keymap.set("n", "<leader>gc", "<cmd>GoCoverage<CR>", { desc = "Go Coverage" })
      keymap.set("n", "<leader>gC", "<cmd>GoCoverageClear<CR>", { desc = "Go Coverage Clear" })
      
      -- Go testing
      keymap.set("n", "<leader>gt", "<cmd>GoTest<CR>", { desc = "Go Test" })
      keymap.set("n", "<leader>gT", "<cmd>GoTestFile<CR>", { desc = "Go Test File" })
      keymap.set("n", "<leader>ga", "<cmd>GoTestAdd<CR>", { desc = "Go Add Test" })
      keymap.set("n", "<leader>gA", "<cmd>GoTestsAll<CR>", { desc = "Go All Tests" })
      keymap.set("n", "<leader>ge", "<cmd>GoTestsExp<CR>", { desc = "Go Exported Tests" })
      
      -- Go tools
      keymap.set("n", "<leader>gf", "<cmd>GoFmt<CR>", { desc = "Go Format" })
      keymap.set("n", "<leader>gI", "<cmd>GoImport<CR>", { desc = "Go Import" })
      keymap.set("n", "<leader>gm", "<cmd>GoMod<CR>", { desc = "Go Mod" })
      keymap.set("n", "<leader>gM", "<cmd>GoModTidy<CR>", { desc = "Go Mod Tidy" })
      
      -- Go generate and fill
      keymap.set("n", "<leader>gg", "<cmd>GoGenerate<CR>", { desc = "Go Generate" })
      keymap.set("n", "<leader>gF", "<cmd>GoFillStruct<CR>", { desc = "Go Fill Struct" })
      keymap.set("n", "<leader>gS", "<cmd>GoFillSwitch<CR>", { desc = "Go Fill Switch" })
      
      -- Go debugging
      keymap.set("n", "<leader>gd", "<cmd>GoDebug<CR>", { desc = "Go Debug" })
      keymap.set("n", "<leader>gD", "<cmd>GoDbgStop<CR>", { desc = "Go Debug Stop" })
      keymap.set("n", "<leader>gB", "<cmd>GoBreakToggle<CR>", { desc = "Go Break Toggle" })
      
      -- Go refactoring
      keymap.set("n", "<leader>gsj", "<cmd>GoTagAdd json<CR>", { desc = "Go Add JSON tags" })
      keymap.set("n", "<leader>gsy", "<cmd>GoTagAdd yaml<CR>", { desc = "Go Add YAML tags" })
      keymap.set("n", "<leader>gst", "<cmd>GoTagAdd toml<CR>", { desc = "Go Add TOML tags" })
      keymap.set("n", "<leader>gsr", "<cmd>GoTagRm<CR>", { desc = "Go Remove tags" })
      
      -- Go navigation
      keymap.set("n", "<leader>gfs", "<cmd>GoFillStruct<CR>", { desc = "Go Fill Struct" })
      keymap.set("n", "<leader>gif", "<cmd>GoIfErr<CR>", { desc = "Go If Err" })
      keymap.set("n", "<leader>gal", "<cmd>GoAlt<CR>", { desc = "Go Alternate" })
      keymap.set("n", "<leader>gav", "<cmd>GoAltV<CR>", { desc = "Go Alternate Vertical" })
      keymap.set("n", "<leader>gas", "<cmd>GoAltS<CR>", { desc = "Go Alternate Split" })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  
  -- Go test enhancement
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-go",
    },
    opts = {
      adapters = {
        ["neotest-go"] = {
          -- Here we can set options for neotest-go, e.g.
          -- args = { "-tags=integration" }
          experimental = {
            test_table = true,
          },
          args = { "-count=1", "-timeout=60s" },
        },
      },
    },
  },
  
  -- Go debugging enhancement
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "leoluz/nvim-dap-go",
    },
    opts = function()
      require("dap-go").setup()
    end,
  },
  
  -- Go snippets and text objects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    optional = true,
    opts = {
      textobjects = {
        select = {
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
      },
    },
  },
}
