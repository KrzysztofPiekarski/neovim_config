return {
  -- Podstawowe pluginy Lua (muszą być pierwsze)
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  
  -- Nawigacja między oknami
  "christoomey/vim-tmux-navigator", -- tmux & split window navigation
  
  -- Ikony (muszą być załadowane przed innymi pluginami)
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false, -- ładuj od razu
    priority = 1000, -- wysoki priorytet
  },
  
  -- Import wszystkich pluginów
  { import = "krispi.plugins.ui" },
  { import = "krispi.plugins.lsp" },
}
