return {
  "williamboman/mason.nvim",
  priority = 1000, -- Wysokий priorytet - ładuje się jako pierwszy
  dependencies = {
    -- "williamboman/mason-lspconfig.nvim", -- USUNIĘTE - powoduje problemy z setup_handlers
    "WhoIsSethDaniel/mason-tool-installer.nvim", -- automatyczna instalacja narzędzi
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-tool-installer
    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- USUNIĘTO mason-lspconfig.setup() - powodowało problemy z setup_handlers
    -- LSP serwery są teraz konfigurowane bezpośrednio w lspconfig.lua
    -- Mason configured silently (direct LSP setup - no mason-lspconfig)

    -- instalacja dodatkowych narzędzi (formattery, lintery itp.)
    mason_tool_installer.setup({
      ensure_installed = {
        -- 🚨 PODSTAWOWE SERWERY LSP - TYLKO DOSTĘPNE PAKIETY!
        "lua-language-server", -- Lua LSP ✅
        "pyright",             -- Python LSP ✅
        "clangd",              -- C/C++ LSP ✅
        "json-lsp",            -- JSON LSP ✅
        "yaml-language-server", -- YAML LSP ✅
        "tailwindcss-language-server", -- Tailwind CSS LSP ✅
        
        -- Python tools (Ruff-first)
        "mypy",      -- type checker ✅
        "ruff",      -- fast linter/formatter ✅
        "ruff-lsp",  -- Ruff LSP ✅
        "debugpy",   -- Python debugger ✅
        
        -- JavaScript/TypeScript tools
        "prettier",   -- formatter ✅
        "eslint-lsp", -- ESLint language server ✅
        
        -- Go tools
        "gofumpt",   -- formatter ✅
        "golangci-lint", -- linter ✅
        "golines",   -- line length formatter ✅
        "gotests",   -- generate Go tests ✅
        "impl",      -- generate Go interface implementations ✅
        "delve",     -- Go debugger ✅
        
        -- Lua tools
        "stylua",    -- formatter ✅
        
        -- C/C++ tools (dla MQL5)
        "clang-format", -- formatter dla C/C++/MQL5 ✅
        "cpptools",     -- C/C++ debugger ✅
        "codelldb",     -- LLDB debugger dla C/C++ ✅
        
        -- Java tools
        "java-debug-adapter", -- Java debugger ✅
        "java-test",         -- Java test runner ✅
        "google-java-format", -- Java formatter ✅
        
        -- Rust tools
        "rustfmt",           -- Rust formatter ✅
        "rust-analyzer",     -- Rust language server (backup) ✅
        
        -- Podstawowe narzędzia
        "shellcheck", -- shell linter ✅
      },
      auto_update = false,
      run_on_start = true,
    })
  end,
}