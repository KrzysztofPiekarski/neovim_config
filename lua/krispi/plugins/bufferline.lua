return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    opts = {
      options = {
        mode = "tabs",
        separator_style = "slant",
        always_show_bufferline = false,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        tab_size = 18,
        max_name_length = 18,
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
        color_icons = true,
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "󰅖",
        left_trunc_marker = "󰅒",
        right_trunc_marker = "󰅓",
        -- Kolory Catppuccin Moka
        highlights = {
          fill = {
            bg = "#1E1E2E",
          },
          background = {
            bg = "#1E1E2E",
            fg = "#CDD6F4",
          },
          tab = {
            bg = "#1E1E2E",
            fg = "#6C7086",
          },
          tab_selected = {
            bg = "#313244",
            fg = "#CDD6F4",
            bold = true,
          },
          tab_close = {
            bg = "#1E1E2E",
            fg = "#F38BA8",
          },
          close_button = {
            bg = "#1E1E2E",
            fg = "#6C7086",
          },
          close_button_visible = {
            bg = "#1E1E2E",
            fg = "#6C7086",
          },
          close_button_selected = {
            bg = "#313244",
            fg = "#F38BA8",
          },
          buffer_visible = {
            bg = "#1E1E2E",
            fg = "#6C7086",
          },
          buffer_selected = {
            bg = "#313244",
            fg = "#CDD6F4",
            bold = true,
          },
          modified = {
            bg = "#1E1E2E",
            fg = "#FAB387",
          },
          modified_visible = {
            bg = "#1E1E2E",
            fg = "#FAB387",
          },
          modified_selected = {
            bg = "#313244",
            fg = "#FAB387",
          },
          separator = {
            bg = "#1E1E2E",
            fg = "#6C7086",
          },
          separator_visible = {
            bg = "#1E1E2E",
            fg = "#6C7086",
          },
          separator_selected = {
            bg = "#313244",
            fg = "#6C7086",
          },
          indicator_selected = {
            bg = "#313244",
            fg = "#CBA6F7",
          },
          duplicate = {
            bg = "#1E1E2E",
            fg = "#6C7086",
          },
          duplicate_visible = {
            bg = "#1E1E2E",
            fg = "#6C7086",
          },
          duplicate_selected = {
            bg = "#313244",
            fg = "#6C7086",
          },
        },
      },
    },
  },
}
