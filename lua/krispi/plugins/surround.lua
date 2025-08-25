return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
        },
        surrounds = {
          -- HTML-like surrounds
          ["<"] = {
            add = function()
              local input = vim.fn.input("Enter tag name: ")
              if input and input ~= "" then
                return { { "<" .. input .. ">" }, { "</" .. input .. ">" } }
              end
              return { { "<" }, { ">" } }
            end,
            find = "%b<>",
            delete = "^(%s*).-(%s*)$",
            change = {
              target = "^%s*<.->%s*(.-)%s*</.->%s*$",
              replacement = function()
                local input = vim.fn.input("Enter new tag name: ")
                if input and input ~= "" then
                  return "<" .. input .. ">%1</" .. input .. ">"
                end
                return "<%1>"
              end,
            },
          },
          -- Markdown surrounds
          ["*"] = { { "*" }, { "*" } },
          ["**"] = { { "**" }, { "**" } },
          ["_"] = { { "_" }, { "_" } },
          ["__"] = { { "__" }, { "__" } },
          ["`"] = { { "`" }, { "`" } },
          ["``"] = { { "``" }, { "``" } },
          ["~~"] = { { "~~" }, { "~~" } },
          -- LaTeX surrounds
          ["$"] = { { "$" }, { "$" } },
          ["$$"] = { { "$$" }, { "$$" } },
          ["\\("] = { { "\\(" }, { "\\)" } },
          ["\\["] = { { "\\[" }, { "\\]" } },
          -- Programming surrounds
          ["("] = { { "(" }, { ")" } },
          [")"] = { { "(" }, { ")" } },
          ["["] = { { "[" }, { "]" } },
          ["]"] = { { "[" }, { "]" } },
          ["{"] = { { "{" }, { "}" } },
          ["}"] = { { "{" }, { "}" } },
          ["<"] = { { "<" }, { ">" } },
          [">"] = { { "<" }, { ">" } },
          -- Quote surrounds
          ["'"] = { { "'" }, { "'" } },
          ['"'] = { { '"' }, { '"' } },
          ["`"] = { { "`" }, { "`" } },
          -- Special surrounds
          ["t"] = { { "<" }, { ">" } }, -- HTML tags
          ["T"] = { { "<" }, { ">" } }, -- HTML tags with attributes
          ["b"] = { { "(" }, { ")" } }, -- Brackets
          ["B"] = { { "{" }, { "}" } }, -- Braces
          ["r"] = { { "[" }, { "]" } }, -- Square brackets
          ["a"] = { { "<" }, { ">" } }, -- Angle brackets
          ["q"] = { { '"' }, { '"' } }, -- Double quotes
          ["Q"] = { { "'" }, { "'" } }, -- Single quotes
          ["s"] = { { " " }, { " " } }, -- Spaces
          ["S"] = { { "  " }, { "  " } }, -- Double spaces
          ["n"] = { { "\n" }, { "\n" } }, -- Newlines
          ["N"] = { { "\n\n" }, { "\n\n" } }, -- Double newlines
        },
        aliases = {
          -- HTML aliases
          ["a"] = ">",
          ["b"] = ")",
          ["B"] = "}",
          ["r"] = "]",
          ["q"] = '"',
          ["Q"] = "'",
          ["s"] = " ",
          ["S"] = "  ",
          ["n"] = "\n",
          ["N"] = "\n\n",
          -- Programming aliases
          ["f"] = ")",
          ["F"] = "}",
          ["c"] = "]",
          ["C"] = ">",
          ["v"] = '"',
          ["V"] = "'",
          ["w"] = " ",
          ["W"] = "  ",
          ["x"] = "\n",
          ["X"] = "\n\n",
        },
      })
    end,
  },
}
