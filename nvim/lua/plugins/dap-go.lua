-- ~/.config/nvim/lua/custom/plugins/dap-go.lua

return {
  -- 🧠 Core Debug Adapter Protocol (DAP)
  { "mfussenegger/nvim-dap" },

  -- 🧩 Required dependency for async operations (needed by nvim-dap-ui)
  { "nvim-neotest/nvim-nio" },

  -- 🖥️ DAP User Interface
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      -- Auto open/close DAP UI when debugging starts or stops
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- 🐹 Go DAP integration (auto-configures delve adapter)
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-go").setup()
    end,
  },

  -- 🎯 Optional: handy keymaps for debugging (you can move this elsewhere)
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      local map = vim.keymap.set
      map("n", "<F5>", dap.continue, { desc = "DAP: Start / Continue" })
      map("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
      map("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
      map("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })
      map("n", "<Leader>b", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
      map("n", "<Leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP: Conditional Breakpoint" })
      map("n", "<Leader>dr", dap.repl.open, { desc = "DAP: Open REPL" })
      map("n", "<Leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })
      map("n", "<Leader>dt", function()
        require("dap-go").debug_test()
      end, { desc = "DAP: Debug Go test" })
    end,
  },
}
