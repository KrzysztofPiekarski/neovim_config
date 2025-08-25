return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "javascript",
          "typescript",
          "c",
          "cpp",
          "go",
          "rust",
          "python",
          "java",
          "json",
          "yaml",
          "html",
          "css",
          "scss",
          "markdown",
          "markdown_inline",
          "bash",
          "fish",
          "sql",
          "toml",
          "dockerfile",
          "gitignore",
          "comment",
          "regex",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })

      -- Treesitter Context
      require("treesitter-context").setup({
        enable = true,
        max_lines = 0,
        trim_scope = "outer",
        patterns = {
          default = {
            "class",
            "function",
            "method",
            "for",
            "while",
            "if",
            "switch",
            "case",
          },
        },
        exact_patterns = {},
        z_index = 20,
        mode = "cursor",
        separator = nil,
        min_window_height = 0,
      })
    end,
  },
}
