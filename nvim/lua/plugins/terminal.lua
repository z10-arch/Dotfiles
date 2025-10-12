return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      float_opts = {
        border = "curved", -- 'single' | 'double' | 'shadow' | 'curved'
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- Custom terminal functions
      local Terminal = require("toggleterm.terminal").Terminal

      -- Lazygit integration
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "double",
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
      })

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      -- Go run terminal
      local function go_run()
        local file = vim.fn.expand("%:p")
        if vim.fn.filereadable(file) == 1 then
          local go_run_term = Terminal:new({
            cmd = "go run " .. file,
            direction = "float",
            close_on_exit = false,
            on_open = function(term)
              vim.cmd("startinsert!")
            end,
          })
          go_run_term:toggle()
        else
          vim.notify("File not found: " .. file, vim.log.levels.ERROR)
        end
      end

      function _GO_RUN()
        go_run()
      end

      -- Go test terminal
      local function go_test()
        local go_test_term = Terminal:new({
          cmd = "go test -v ./...",
          direction = "float",
          close_on_exit = false,
        })
        go_test_term:toggle()
      end

      function _GO_TEST()
        go_test()
      end

      -- Node REPL
      local node = Terminal:new({ cmd = "node", hidden = true })

      function _NODE_TOGGLE()
        node:toggle()
      end

      -- Python REPL
      local python = Terminal:new({ cmd = "python3", hidden = true })

      function _PYTHON_TOGGLE()
        python:toggle()
      end

      -- Keymaps
      local map = vim.keymap.set
      local opts_map = { noremap = true, silent = true }

      -- Toggle terminal
      map("n", "<C-\\>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal", noremap = true, silent = true })
      map("t", "<C-\\>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal", noremap = true, silent = true })

      -- Terminal navigation
      map("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts_map)
      map("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts_map)
      map("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts_map)
      map("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts_map)
      map("t", "<esc>", [[<C-\><C-n>]], opts_map)

      -- Go specific
      map("n", "<leader>gr", "<cmd>lua _GO_RUN()<CR>", { desc = "Go: Run file", noremap = true, silent = true })
      map("n", "<leader>gt", "<cmd>lua _GO_TEST()<CR>", { desc = "Go: Test", noremap = true, silent = true })

      -- Git
      map("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Lazygit", noremap = true, silent = true })

      -- Send lines to terminal
      map("n", "<leader>ts", "<cmd>ToggleTermSendCurrentLine<CR>", { desc = "Send line to terminal" })
      map("v", "<leader>ts", "<cmd>ToggleTermSendVisualSelection<CR>", { desc = "Send selection to terminal" })

      -- Multiple terminals
      map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal: Float" })
      map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Terminal: Horizontal" })
      map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Terminal: Vertical" })
    end,
  },
}
