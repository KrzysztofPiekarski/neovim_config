return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
        languages = {
          lua = {
            __default = "-- %s",
            __multiline = "--[[ %s ]]",
            __single = "-- %s",
          },
          python = {
            __default = "# %s",
            __multiline = '""" %s """',
            __single = "# %s",
          },
          javascript = {
            __default = "// %s",
            __multiline = "/* %s */",
            __single = "// %s",
          },
          typescript = {
            __default = "// %s",
            __multiline = "/* %s */",
            __single = "// %s",
          },
          c = {
            __default = "// %s",
            __multiline = "/* %s */",
            __single = "// %s",
          },
          cpp = {
            __default = "// %s",
            __multiline = "/* %s */",
            __single = "// %s",
          },
          go = {
            __default = "// %s",
            __multiline = "/* %s */",
            __single = "// %s",
          },
          rust = {
            __default = "// %s",
            __multiline = "/* %s */",
            __single = "// %s",
          },
          java = {
            __default = "// %s",
            __multiline = "/* %s */",
            __single = "// %s",
          },
          html = {
            __default = "<!-- %s -->",
            __multiline = "<!-- %s -->",
            __single = "<!-- %s -->",
          },
          css = {
            __default = "/* %s */",
            __multiline = "/* %s */",
            __single = "/* %s */",
          },
          scss = {
            __default = "// %s",
            __multiline = "/* %s */",
            __single = "// %s",
          },
          json = {
            __default = "// %s",
            __multiline = "/* %s */",
            __single = "// %s",
          },
          yaml = {
            __default = "# %s",
            __multiline = "# %s",
            __single = "# %s",
          },
          markdown = {
            __default = "<!-- %s -->",
            __multiline = "<!-- %s -->",
            __single = "<!-- %s -->",
          },
          bash = {
            __default = "# %s",
            __multiline = "# %s",
            __single = "# %s",
          },
          fish = {
            __default = "# %s",
            __multiline = "# %s",
            __single = "# %s",
          },
          sql = {
            __default = "-- %s",
            __multiline = "/* %s */",
            __single = "-- %s",
          },
          toml = {
            __default = "# %s",
            __multiline = "# %s",
            __single = "# %s",
          },
          dockerfile = {
            __default = "# %s",
            __multiline = "# %s",
            __single = "# %s",
          },
          gitignore = {
            __default = "# %s",
            __multiline = "# %s",
            __single = "# %s",
          },
        },
      })
    end,
  },
}
