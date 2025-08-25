return {
  "Exafunction/windsurf.vim",
  event = "BufEnter",
  config = function()
    -- Change '<C-g>' here to any keycode you like.
    vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true, desc = "Accept Codeium suggestion" })
    vim.keymap.set('i', '<C-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true, desc = "Next Codeium suggestion" })
    vim.keymap.set('i', '<C-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true, desc = "Previous Codeium suggestion" })
    vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true, desc = "Clear Codeium suggestion" })
    
    -- Additional keymaps for normal mode
    local keymap = vim.keymap -- for conciseness
    
    -- Codeium chat and actions
    keymap.set('n', '<leader>cc', '<cmd>Codeium Chat<cr>', { desc = "Open Codeium Chat" })
    keymap.set('n', '<leader>ce', '<cmd>Codeium Enable<cr>', { desc = "Enable Codeium" })
    keymap.set('n', '<leader>cd', '<cmd>Codeium Disable<cr>', { desc = "Disable Codeium" })
    keymap.set('n', '<leader>cs', '<cmd>Codeium Auth<cr>', { desc = "Codeium Authentication" })
    
    -- Visual mode for explain/refactor
    keymap.set('v', '<leader>ce', '<cmd>Codeium Explain<cr>', { desc = "Explain selected code" })
    keymap.set('v', '<leader>cr', '<cmd>Codeium Refactor<cr>', { desc = "Refactor selected code" })
  end,
}