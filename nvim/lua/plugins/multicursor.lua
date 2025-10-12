return {
  {
    "terryma/vim-multiple-cursors",
    keys = {
      { "<C-n>", mode = { "n", "v" } },
    },
    init = function()
      vim.g.multi_cursor_use_default_mapping = 0
      vim.g.multi_cursor_start_word_key = "<C-n>"
      vim.g.multi_cursor_next_key = "<C-n>"
      vim.g.multi_cursor_skip_key = "<C-x>"
      vim.g.multi_cursor_quit_key = "<Esc>"
    end,
  },
}
