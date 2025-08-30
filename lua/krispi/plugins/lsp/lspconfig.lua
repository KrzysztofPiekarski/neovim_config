return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
    "b0o/schemastore.nvim",
  },
  config = function()
    -- 🚨 PROSTA KONFIGURACJA BEZ MASON - GWARANTOWANA STABILNOŚĆ
    -- Loading SIMPLE LSP config silently
    
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()
    local keymap = vim.keymap

    -- LSP keymaps on attach
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- Essential LSP keymaps
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", vim.tbl_extend("force", opts, { desc = "Show LSP references" }))
        keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", vim.tbl_extend("force", opts, { desc = "Show LSP definitions" }))
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", vim.tbl_extend("force", opts, { desc = "Show LSP implementations" }))
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", vim.tbl_extend("force", opts, { desc = "Show LSP type definitions" }))
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "See available code actions" }))
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Smart rename" }))
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", vim.tbl_extend("force", opts, { desc = "Show buffer diagnostics" }))
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show line diagnostics" }))
        keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Go to previous diagnostic" }))
        keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Go to next diagnostic" }))
        keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Show documentation for what is under cursor" }))
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", vim.tbl_extend("force", opts, { desc = "Restart LSP" }))
        keymap.set("n", "<leader>lf", function()
          vim.lsp.buf.format({ async = true })
        end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
        keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Show signature help" }))
      end,
    })

    -- Diagnostics configuration
    vim.diagnostic.config({
      virtual_text = { prefix = "●", source = "if_many" },
      float = { source = "if_many", border = "rounded" },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    -- LSP handlers with borders
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

    -- 🎯 PODSTAWOWE SERWERY LSP - KONFIGURACJA BEZPOŚREDNIA
    -- Sprawdzaj zarówno system jak i Mason bin directory
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/"
    
    local function is_executable(name)
      -- Sprawdź w systemie
      if vim.fn.executable(name) == 1 then
        return true
      end
      -- Sprawdź w Mason
      return vim.fn.executable(mason_bin .. name) == 1
    end
    
    -- Lua Language Server
    if is_executable("lua-language-server") then
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            completion = { callSnippet = "Replace" },
          },
        },
      })
    end

    -- Python
    if is_executable("pyright") then
      lspconfig.pyright.setup({ capabilities = capabilities })
    end

    -- [removed] TypeScript/JavaScript handled by typescript-tools.nvim

    -- JSON (with SchemaStore)
    if is_executable("vscode-json-language-server") then
      lspconfig.jsonls.setup({
        capabilities = capabilities,
        settings = {
          json = {
            validate = { enable = true },
            format = { enable = false }, -- formatowanie przez conform (Prettier)
            schemas = require("schemastore").json.schemas(),
          },
        },
        init_options = {
          provideFormatter = false,
        },
      })
    end

    -- YAML with SchemaStore (via yamlls)
    if is_executable("yaml-language-server") then
      lspconfig.yamlls.setup({
        capabilities = capabilities,
        settings = {
          yaml = {
            validate = true,
            hover = true,
            completion = true,
            format = { enable = false },
            schemaStore = {
              enable = true,
              url = "https://www.schemastore.org/api/json/catalog.json",
            },
            schemas = require('schemastore').yaml.schemas(),
          },
        },
      })
    end

    -- [removed] Go handled by go.nvim

    -- [removed] Rust handled by rustaceanvim

    -- C/C++
    if is_executable("clangd") then
      lspconfig.clangd.setup({
        capabilities = capabilities,
        cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
      })
    end

    -- [removed] Java handled by nvim-jdtls

    -- ESLint with auto-fix on save
    if is_executable("eslint-lsp") then
      lspconfig.eslint.setup({
        capabilities = capabilities,
        settings = {
          format = { enable = false }, -- format pozostaje w Prettier
        },
        on_attach = function(client, bufnr)
          local grp = vim.api.nvim_create_augroup("eslint_fix_on_save", { clear = false })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = grp,
            buffer = bufnr,
            command = "EslintFixAll",
            desc = "Run ESLint --fix on save",
          })
        end,
      })
    end

    -- Tailwind CSS
    if is_executable("tailwindcss-language-server") then
      lspconfig.tailwindcss.setup({ capabilities = capabilities })
    end

    -- Ruff LSP for Python
    if is_executable("ruff") or is_executable("ruff-lsp") then
      lspconfig.ruff.setup({ capabilities = capabilities })
    end

  end,
}