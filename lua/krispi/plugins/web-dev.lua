return {
  -- Enhanced HTML/CSS/JavaScript Development
  
  -- Live server for web development
  {
    "barrett-ruth/live-server.nvim",
    build = "npm install -g live-server",
    cmd = { "LiveServerStart", "LiveServerStop" },
    config = function()
      require("live-server").setup({
        args = { "--port=8080", "--browser=default" },
      })
      
      -- Live server keymaps
      local keymap = vim.keymap
      keymap.set("n", "<leader>ls", "<cmd>LiveServerStart<CR>", { desc = "Start Live Server" })
      keymap.set("n", "<leader>lx", "<cmd>LiveServerStop<CR>", { desc = "Stop Live Server" })
    end,
  },

  -- Enhanced HTML editing
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue" },
    config = function()
      -- Emmet settings
      vim.g.user_emmet_leader_key = "<C-z>"
      vim.g.user_emmet_settings = {
        html = {
          snippets = {
            ["!"] = "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n\t<meta charset=\"UTF-8\">\n\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n\t<title>${1:Document}</title>\n</head>\n<body>\n\t${2}\n</body>\n</html>",
          },
        },
      }
      
      -- Emmet keymaps
      local keymap = vim.keymap
      keymap.set("n", "<leader>ee", "<C-z>,", { desc = "Emmet expand" })
      keymap.set("v", "<leader>ee", "<C-z>,", { desc = "Emmet expand" })
    end,
  },

  -- CSS color highlighting
  {
    "norcalli/nvim-colorizer.lua",
    ft = { "css", "scss", "sass", "html", "javascript", "typescript", "vue", "svelte" },
    config = function()
      require("colorizer").setup({
        filetypes = { "css", "scss", "sass", "html", "javascript", "typescript", "vue", "svelte" },
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = true, -- "Name" codes like Blue or blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          AARRGGBB = false, -- 0xAARRGGBB hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          mode = "background", -- Set the display mode
          tailwind = true, -- Enable tailwind colors
          sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
          virtualtext = "■",
        },
        buftypes = {},
      })
      
      -- Colorizer keymaps
      local keymap = vim.keymap
      keymap.set("n", "<leader>ct", "<cmd>ColorizerToggle<CR>", { desc = "Toggle Colorizer" })
      keymap.set("n", "<leader>cr", "<cmd>ColorizerReloadAllBuffers<CR>", { desc = "Reload Colorizer" })
    end,
  },

  -- TypeScript utilities
  {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup({
        on_attach = function(client, bufnr)
          -- Disable formatting (use prettier instead)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        settings = {
          -- spawn additional tsserver instance to calculate diagnostics on it
          separate_diagnostic_server = true,
          -- "change"|"insert_leave" determine when the client asks the server about diagnostic
          publish_diagnostic_on = "insert_leave",
          -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
          -- "remove_unused_imports"|"organize_imports") -- or string "all"
          -- to include all supported code actions
          expose_as_code_action = {},
          -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
          -- not exists then standard path resolution strategy is applied
          tsserver_path = nil,
          -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
          -- (see 💅 `styled-components` support section)
          tsserver_plugins = {},
          -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
          -- memory limit in megabytes or "auto"(basically no limit)
          tsserver_max_memory = "auto",
          -- described below
          tsserver_format_options = {},
          tsserver_file_preferences = {},
          -- locale of all tsserver messages, supported locales you can find here:
          -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
          tsserver_locale = "en",
          -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
          complete_function_calls = false,
          include_completions_with_insert_text = true,
          -- CodeLens
          -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
          -- possible values: ("off"|"all"|"implementations_only"|"references_only")
          code_lens = "off",
          -- by default code lenses are displayed on all referencable values and for some of you it can
          -- be too much this option reduce count of them by removing member references from lenses
          disable_member_code_lens = true,
          -- JSXCloseTag
          -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
          -- that maybe have a conflict if enable this feature. )
          jsx_close_tag = {
            enable = false,
            filetypes = { "javascriptreact", "typescriptreact" },
          },
        },
      })
      
      -- TypeScript keymaps
      local keymap = vim.keymap
      keymap.set("n", "<leader>tso", "<cmd>TSToolsOrganizeImports<CR>", { desc = "TS Organize Imports" })
      keymap.set("n", "<leader>tss", "<cmd>TSToolsSortImports<CR>", { desc = "TS Sort Imports" })
      keymap.set("n", "<leader>tsr", "<cmd>TSToolsRemoveUnusedImports<CR>", { desc = "TS Remove Unused Imports" })
      keymap.set("n", "<leader>tsa", "<cmd>TSToolsAddMissingImports<CR>", { desc = "TS Add Missing Imports" })
      keymap.set("n", "<leader>tsf", "<cmd>TSToolsFixAll<CR>", { desc = "TS Fix All" })
      keymap.set("n", "<leader>tsg", "<cmd>TSToolsGoToSourceDefinition<CR>", { desc = "TS Go to Source Definition" })
      keymap.set("n", "<leader>tsn", "<cmd>TSToolsRenameFile<CR>", { desc = "TS Rename File" })
      keymap.set("n", "<leader>tsR", "<cmd>TSToolsFileReferences<CR>", { desc = "TS File References" })
    end,
  },

  -- Package.json utilities
  {
    "vuki656/package-info.nvim",
    ft = "json",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("package-info").setup({
        colors = {
          up_to_date = "#3C4048", -- Text color for up to date dependency virtual text
          outdated = "#d19a66", -- Text color for outdated dependency virtual text
        },
        icons = {
          enable = true, -- Whether to display icons
          style = {
            up_to_date = "|  ", -- Icon for up to date dependencies
            outdated = "|  ", -- Icon for outdated dependencies
          },
        },
        autostart = true, -- Whether to autostart when `package.json` is opened
        hide_up_to_date = false, -- It hides up to date versions when displaying virtual text
        hide_unstable_versions = false, -- It hides unstable versions from version list e.g next-11.1.3-canary3
      })
      
      -- Package info keymaps
      local keymap = vim.keymap
      keymap.set("n", "<leader>ns", "<cmd>lua require('package-info').show()<CR>", { desc = "Show package versions" })
      keymap.set("n", "<leader>nc", "<cmd>lua require('package-info').hide()<CR>", { desc = "Hide package versions" })
      keymap.set("n", "<leader>nt", "<cmd>lua require('package-info').toggle()<CR>", { desc = "Toggle package versions" })
      keymap.set("n", "<leader>nu", "<cmd>lua require('package-info').update()<CR>", { desc = "Update package" })
      keymap.set("n", "<leader>nd", "<cmd>lua require('package-info').delete()<CR>", { desc = "Delete package" })
      keymap.set("n", "<leader>ni", "<cmd>lua require('package-info').install()<CR>", { desc = "Install package" })
      keymap.set("n", "<leader>np", "<cmd>lua require('package-info').change_version()<CR>", { desc = "Change package version" })
    end,
  },

  -- REST client for API testing
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup({
        -- Open request results in a horizontal split
        result_split_horizontal = false,
        -- Keep the http file buffer above|left when split horizontal|vertical
        result_split_in_place = false,
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = false,
        -- Encode URL before making request
        encode_url = true,
        -- Highlight request on run
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          -- toggle showing URL, HTTP info, headers at top the of result window
          show_url = true,
          show_http_info = true,
          show_headers = true,
          -- executables or functions for formatting response body [optional]
          -- set them to false if you want to disable them
          formatters = {
            json = "jq",
            html = function(body)
              return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
            end
          },
        },
        -- Jump to request line on run
        jump_to_request = false,
        env_file = '.env',
        custom_dynamic_variables = {},
        yank_dry_run = true,
      })
      
      -- REST client keymaps
      local keymap = vim.keymap
      keymap.set("n", "<leader>rr", "<cmd>lua require('rest-nvim').run()<CR>", { desc = "Run REST request" })
      keymap.set("n", "<leader>rp", "<cmd>lua require('rest-nvim').run(true)<CR>", { desc = "Preview REST request" })
      keymap.set("n", "<leader>rl", "<cmd>lua require('rest-nvim').last()<CR>", { desc = "Run last REST request" })
    end,
  },

  -- Tailwind CSS support
  {
    "luckasRanarison/tailwind-tools.nvim",
    ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      document_color = {
        enabled = true, -- can be toggled by commands
        kind = "inline", -- "inline" | "foreground" | "background"
        inline_symbol = "󰝤 ", -- only used in inline mode
        debounce = 200, -- in milliseconds, only applied in insert mode
      },
      conceal = {
        enabled = false, -- can be toggled by commands
        min_length = nil, -- only conceal classes exceeding the provided length
        symbol = "󱏿", -- only a single character is allowed
        highlight = {
          fg = "#38BDF8", -- foreground color, text will be rendered with this color
          bg = "#374151", -- background color
        },
      },
      custom_filetypes = {} -- see the extension section to learn how it works
    },
    config = function(_, opts)
      require("tailwind-tools").setup(opts)
      
      -- Tailwind keymaps
      local keymap = vim.keymap
      keymap.set("n", "<leader>tw", "<cmd>TailwindConcealToggle<CR>", { desc = "Toggle Tailwind conceal" })
      keymap.set("n", "<leader>tc", "<cmd>TailwindColorToggle<CR>", { desc = "Toggle Tailwind colors" })
      keymap.set("n", "<leader>ts", "<cmd>TailwindSort<CR>", { desc = "Sort Tailwind classes" })
    end,
  },

  -- JavaScript/TypeScript testing
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
    },
    opts = {
      adapters = {
        ["neotest-jest"] = {
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        },
        ["neotest-vitest"] = {
          -- Filter directories when searching for test files. Useful in large projects (see Filter directories notes).
          filter_dir = function(name, rel_path, root)
            return name ~= "node_modules"
          end,
        },
      },
    },
  },

  -- Browser integration
  {
    "tyru/open-browser.vim",
    cmd = { "OpenBrowser", "OpenBrowserSearch" },
    config = function()
      -- Browser keymaps
      local keymap = vim.keymap
      keymap.set("n", "<leader>ob", "<cmd>OpenBrowser <C-R>=expand('<cWORD>')<CR><CR>", { desc = "Open URL under cursor" })
      keymap.set("v", "<leader>ob", ":<C-u>OpenBrowser <C-R>=@*<CR><CR>", { desc = "Open selected URL" })
      keymap.set("n", "<leader>os", "<cmd>OpenBrowserSearch ", { desc = "Search in browser" })
    end,
  },

  -- HTML tag matching
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_hi_surround_always = 1
    end,
  },

  -- CSS/SCSS/SASS enhanced support
  {
    "hail2u/vim-css3-syntax",
    ft = { "css", "scss", "sass" },
  },

  -- Vue.js support (if needed)
  {
    "posva/vim-vue",
    ft = "vue",
  },
}
