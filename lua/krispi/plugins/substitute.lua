return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local substitute = require("substitute")

    substitute.setup()

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    vim.keymap.set("n", "s", substitute.operator, { desc = "Substitute with motion" })
    vim.keymap.set("n", "ss", substitute.line, { desc = "Substitute line" })
    vim.keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line" })
    vim.keymap.set("x", "s", substitute.visual, { desc = "Substitute in visual mode" })
    
    -- Kolory Catppuccin Moka dla Substitute
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "Substitute", { fg = "#F9E2AF", bg = "#1E1E2E", bold = true })
      end,
    })
  end,
}
