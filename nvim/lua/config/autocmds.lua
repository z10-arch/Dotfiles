-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Auto-save with subtle indicator
-- Auto-save with subtle feedback
-- Auto-save with controlled notification
local autosave = vim.api.nvim_create_augroup("AutoSave", { clear = true })
local autosave_enabled = true

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  group = autosave,
  pattern = "*",
  callback = function()
    if autosave_enabled and vim.bo.modified and vim.bo.modifiable and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! write")
      
      -- Notification with 100ms timeout
      vim.notify("💾 Saved!", vim.log.levels.INFO, {
        timeout = 100,
        title = "",
      })
    end
  end,
})

-- Toggle auto-save
vim.keymap.set("n", "<leader>as", function()
  autosave_enabled = not autosave_enabled
  if autosave_enabled then
    vim.notify("✅ Auto-save enabled", vim.log.levels.INFO)
  else
    vim.notify("⛔ Auto-save disabled", vim.log.levels.WARN)
  end
end, { desc = "Toggle auto-save" })

-- Check if auto-save is enabled
vim.keymap.set("n", "<leader>aS", function()
  local status = autosave_enabled and "enabled ✓" or "disabled ✗"
  vim.notify("Auto-save is " .. status, vim.log.levels.INFO)
end, { desc = "Auto-save status" })
