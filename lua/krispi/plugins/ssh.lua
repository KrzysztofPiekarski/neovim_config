return {
  -- SSH Remote Development Support
  {
    -- Remote file editing via SSH
    "chipsenkbeil/distant.nvim",
    branch = "v0.3",
    config = function()
      require("distant"):setup({
        -- New servers field structure (v0.3+)
        servers = {
          -- Default server settings
          ['*'] = {
            -- Use SSH by default
            ssh = {
              -- Use system SSH config
              config = true,
            },
          },
        },
      })

      -- SSH keymaps
      local keymap = vim.keymap
      local opts = { silent = true }

      -- Connection management
      keymap.set("n", "<leader>sc", "<cmd>DistantConnect<CR>", vim.tbl_extend("force", opts, { desc = "SSH Connect" }))
      keymap.set("n", "<leader>sd", "<cmd>DistantDisconnect<CR>", vim.tbl_extend("force", opts, { desc = "SSH Disconnect" }))
      keymap.set("n", "<leader>sl", "<cmd>DistantList<CR>", vim.tbl_extend("force", opts, { desc = "SSH List connections" }))

      -- File operations
      keymap.set("n", "<leader>so", "<cmd>DistantOpen<CR>", vim.tbl_extend("force", opts, { desc = "SSH Open file/directory" }))
      keymap.set("n", "<leader>sb", "<cmd>DistantBrowse<CR>", vim.tbl_extend("force", opts, { desc = "SSH Browse remote directory" }))
      
      -- Terminal
      keymap.set("n", "<leader>st", "<cmd>DistantShell<CR>", vim.tbl_extend("force", opts, { desc = "SSH Terminal" }))
      
      -- Quick connections (customize these for your servers)
      keymap.set("n", "<leader>s1", function()
        vim.cmd("DistantConnect ssh://user@server1.example.com")
      end, vim.tbl_extend("force", opts, { desc = "SSH Connect to server1" }))
      
      keymap.set("n", "<leader>s2", function()
        vim.cmd("DistantConnect ssh://user@server2.example.com")
      end, vim.tbl_extend("force", opts, { desc = "SSH Connect to server2" }))
    end,
  },

  {
    -- SSH config syntax highlighting and LSP
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ssh_config" })
      end
    end,
  },

  {
    -- Enhanced terminal for SSH connections
    "akinsho/toggleterm.nvim",
    optional = true,
    opts = function(_, opts)
      opts.float_opts = opts.float_opts or {}
      opts.float_opts.border = "curved"
      return opts
    end,
    keys = {
      {
        "<leader>sT",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local ssh_term = Terminal:new({
            cmd = "ssh",
            direction = "float",
            float_opts = {
              border = "curved",
            },
            on_open = function(term)
              vim.cmd("startinsert!")
              vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
            end,
          })
          ssh_term:toggle()
        end,
        desc = "SSH Terminal (floating)",
      },
    },
  },

  {
    -- SSH key management and utilities
    "nvim-lua/plenary.nvim",
    config = function()
      -- SSH utilities
      local function check_ssh_agent()
        local ssh_auth_sock = os.getenv("SSH_AUTH_SOCK")
        if ssh_auth_sock and vim.fn.filereadable(ssh_auth_sock) == 1 then
          vim.notify("✅ SSH Agent is running", vim.log.levels.INFO)
          
          -- List loaded keys
          local handle = io.popen("ssh-add -l 2>/dev/null")
          if handle then
            local result = handle:read("*a")
            handle:close()
            
            if result and result ~= "" then
              local key_count = 0
              for _ in result:gmatch("\n") do
                key_count = key_count + 1
              end
              vim.notify(string.format("🔑 %d SSH keys loaded", key_count), vim.log.levels.INFO)
            else
              vim.notify("⚠️  SSH Agent running but no keys loaded", vim.log.levels.WARN)
            end
          end
        else
          vim.notify("❌ SSH Agent not running. Start with: eval $(ssh-agent)", vim.log.levels.ERROR)
        end
      end

      local function add_ssh_key()
        vim.ui.input({ prompt = "SSH key path (default: ~/.ssh/id_rsa): " }, function(key_path)
          if not key_path or key_path == "" then
            key_path = "~/.ssh/id_rsa"
          end
          
          key_path = vim.fn.expand(key_path)
          
          if vim.fn.filereadable(key_path) == 1 then
            vim.fn.jobstart(string.format("ssh-add %s", key_path), {
              on_exit = function(_, exit_code)
                if exit_code == 0 then
                  vim.notify("✅ SSH key added successfully", vim.log.levels.INFO)
                else
                  vim.notify("❌ Failed to add SSH key", vim.log.levels.ERROR)
                end
              end,
            })
          else
            vim.notify("❌ SSH key file not found: " .. key_path, vim.log.levels.ERROR)
          end
        end)
      end

      local function ssh_config_check()
        local ssh_config = vim.fn.expand("~/.ssh/config")
        if vim.fn.filereadable(ssh_config) == 1 then
          vim.notify("✅ SSH config found: " .. ssh_config, vim.log.levels.INFO)
          
          -- Show first few hosts from config
          local handle = io.popen("grep '^Host ' ~/.ssh/config | head -5")
          if handle then
            local hosts = handle:read("*a")
            handle:close()
            
            if hosts and hosts ~= "" then
              vim.notify("🖥️  Available hosts:\n" .. hosts, vim.log.levels.INFO)
            end
          end
        else
          vim.notify("⚠️  SSH config not found. Create ~/.ssh/config for easier connections", vim.log.levels.WARN)
        end
      end

      -- SSH commands
      vim.api.nvim_create_user_command("SshCheck", check_ssh_agent, {
        desc = "Check SSH agent status and loaded keys"
      })
      
      vim.api.nvim_create_user_command("SshAddKey", add_ssh_key, {
        desc = "Add SSH key to agent"
      })
      
      vim.api.nvim_create_user_command("SshConfig", function()
        vim.cmd("edit ~/.ssh/config")
      end, {
        desc = "Edit SSH config file"
      })
      
      vim.api.nvim_create_user_command("SshConfigCheck", ssh_config_check, {
        desc = "Check SSH configuration"
      })

      -- SSH config file settings
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*/ssh/config", "*/.ssh/config", "ssh_config", "sshd_config" },
        callback = function()
          vim.bo.filetype = "sshconfig"
          vim.opt_local.commentstring = "# %s"
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          vim.opt_local.expandtab = true
        end,
      })
    end,
  },

  {
    -- File manager integration for remote files
    "nvim-tree/nvim-tree.lua",
    optional = true,
    opts = function(_, opts)
      -- Enable remote file support in nvim-tree
      opts.filesystem_watchers = opts.filesystem_watchers or {}
      opts.filesystem_watchers.enable = true
      return opts
    end,
  },

  {
    -- Telescope integration for SSH
    "nvim-telescope/telescope.nvim",
    optional = true,
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      
      -- SSH-specific telescope functions
      local function find_ssh_config()
        builtin.find_files({
          prompt_title = "SSH Config Files",
          cwd = vim.fn.expand("~/.ssh"),
          hidden = true,
        })
      end

      local function grep_ssh_config()
        builtin.live_grep({
          prompt_title = "Search SSH Config",
          cwd = vim.fn.expand("~/.ssh"),
        })
      end

      -- SSH keymaps for Telescope
      local keymap = vim.keymap
      local opts = { silent = true }
      
      keymap.set("n", "<leader>sf", find_ssh_config, vim.tbl_extend("force", opts, { desc = "Find SSH config files" }))
      keymap.set("n", "<leader>sg", grep_ssh_config, vim.tbl_extend("force", opts, { desc = "Grep SSH config" }))
    end,
  },
}
