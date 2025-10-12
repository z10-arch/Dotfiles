return {
  -- You can install individual mini.nvim modules
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      -- Example: Install mini.surround
      require('mini.surround').setup()
      
      -- Example: Install mini.pairs (auto-pairs)
      require('mini.pairs').setup()
      
      -- Example: Install mini.comment
      require('mini.comment').setup()
      
      -- Add more mini modules as needed
    end,
  },
}
