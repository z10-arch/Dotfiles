-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>tb", function()
  if vim.o.showtabline == 0 then
    vim.o.showtabline = 2
  else
    vim.o.showtabline = 0
  end
end, { desc = "Toggle tab/buffer bar" })

-- turn off LSP Lint and Turn on
vim.keymap.set("n", "<leader>td", function()
  local current = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = not current })
  print("Diagnostics " .. (current and "hidden" or "shown"))
end, { desc = "Toggle diagnostics" })

-- Move lines up/down (like VS Code Alt+Arrow)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- Or if you prefer using down/up arrows like VS Code
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })
