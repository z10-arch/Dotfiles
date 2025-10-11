-- OSC 52 Clipboard Support
return {
  {
    "ojroques/nvim-osc52",
    lazy = false, -- Load immediately
    config = function()
      require("osc52").setup({
        max_length = 0,
        silent = false,
        trim = false,
      })

      -- Auto copy to clipboard on yank
      vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
          if vim.v.event.operator == "y" then
            require("osc52").copy_register("+")
          end
        end,
      })
    end,
  },
}
