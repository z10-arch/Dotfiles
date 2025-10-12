-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- Auto-save configuration
-- Auto-save configuration
local autosave_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })
local autosave_enabled = true

-- Auto-save function
local function autosave()
  if not autosave_enabled then
    return
  end

  local buf = vim.api.nvim_get_current_buf()
  
  -- Check if buffer can be saved
  if vim.bo[buf].modified 
     and vim.bo[buf].modifiable 
     and vim.bo[buf].buftype == "" 
     and vim.fn.expand("%") ~= "" then
    
    -- Save silently
    vim.cmd("silent! write")
    
    -- Show notification (optional - comment out if annoying)
    vim.notify("💾 Auto-saved", vim.log.levels.INFO, { timeout = 500 })
  end
end

-- Trigger auto-save on these events
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  group = autosave_group,
  pattern = "*",
  callback = function()
    -- Debounce - wait a bit before saving
    vim.defer_fn(autosave, 1000) -- 1 second delay
  end,
})

-- Save immediately when leaving buffer or losing focus
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  group = autosave_group,
  pattern = "*",
  callback = autosave,
})

-- Toggle auto-save with keybinding
vim.keymap.set("n", "<leader>as", function()
  autosave_enabled = not autosave_enabled
  if autosave_enabled then
    vim.notify("✅ Auto-save enabled", vim.log.levels.INFO)
  else
    vim.notify("⛔ Auto-save disabled", vim.log.levels.WARN)
  end
end, { desc = "Toggle auto-save" })

-- Show auto-save status
vim.keymap.set("n", "<leader>aS", function()
  local status = autosave_enabled and "enabled" or "disabled"
  vim.notify("Auto-save is " .. status, vim.log.levels.INFO)
end, { desc = "Auto-save status" })
