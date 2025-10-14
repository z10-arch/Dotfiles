-- Multi-cursor plugin for LazyVim
-- Save this as: nvim/lua/plugins/multicursor.lua

return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
    init = function()
      -- VSCode-like keybindings
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",           -- Ctrl+D to select next word
        ["Find Subword Under"] = "<C-d>",   -- Same for partial words
        ["Add Cursor Down"] = "<C-Down>",   -- Ctrl+Down to add cursor below
        ["Add Cursor Up"] = "<C-Up>",       -- Ctrl+Up to add cursor above
        ["Select All"] = "<C-S-l>",         -- Ctrl+Shift+L to select all
        ["Mouse Cursor"] = "<C-LeftMouse>", -- Ctrl+Click to add cursor
        ["Skip Region"] = "q",              -- Skip current selection
        ["Remove Region"] = "Q",            -- Remove current cursor
        ["Undo"] = "u",
        ["Redo"] = "<C-r>",
      }

      -- Settings
      vim.g.VM_theme = "ocean"
      vim.g.VM_highlight_matches = "underline"
      vim.g.VM_silent_exit = 1
      vim.g.VM_set_statusline = 2
      vim.g.VM_show_warnings = 0

      -- Custom highlights
      vim.g.VM_Mono_hl = "DiffText"
      vim.g.VM_Extend_hl = "DiffAdd"
      vim.g.VM_Cursor_hl = "Visual"
      vim.g.VM_Insert_hl = "DiffChange"
    end,
  },
}
