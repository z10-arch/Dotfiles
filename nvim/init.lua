-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.transparency")
-- Enable OSC52 clipboard (works over SSH)
vim.g.clipboard = 'osc52'

-- Use system clipboard for all yank/paste operations
vim.opt.clipboard = 'unnamedplus'
