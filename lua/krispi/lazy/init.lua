print("🚀 lazy.lua STARTED - file is being loaded!")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

print("🔧 Lazy.nvim path:", lazypath)
print("🔧 Lazy.nvim exists:", vim.inspect(vim.loop.fs_stat(lazypath)))

local ok, lazy = pcall(require, "lazy")
if not ok then
  print("❌ Failed to load Lazy.nvim:", lazy)
  return
end

print("✅ Lazy.nvim loaded successfully!")

print("🔧 About to call lazy.setup...")

local ok2, result = pcall(function()
  print("🔧 Starting Lazy.nvim setup...")
  
  print("🔧 Creating plugin table...")
  local plugins = {
    -- Test plugin - sprawdzamy czy Lazy.nvim działa
    {
      "nvim-lua/plenary.nvim",
      config = function()
        print("🧪 Lazy.nvim test plugin loaded successfully!")
      end,
    },
    
    -- Test import - sprawdzamy czy system importów działa
    {
      "nvim-lua/plenary.nvim",
      config = function()
        print("🧪 Test import plugin loaded successfully!")
      end,
    },
    
    -- Importy pluginów
    { import = "krispi.plugins" },
    { import = "krispi.plugins.lsp" }
  }
  
  print("🔧 Plugin table created, about to call lazy.setup...")
  print("🔧 Plugins count:", #plugins)
  
  lazy.setup(plugins, {
    checker = {
      enabled = true,
      notify = false,
    },
    change_detection = {
      notify = false,
    },
  })
  
  print("🔧 Lazy.nvim setup function completed!")
end)

print("🔧 After pcall - ok2:", ok2, "result:", result)

if not ok2 then
  print("❌ Failed to setup Lazy.nvim:", result)
  return
end

print("✅ Lazy.nvim setup completed!")
