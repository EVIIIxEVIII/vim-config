return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup({
          layouts = {
            { position = "left", size = 40, elements = { "scopes", "watches", "stacks", "breakpoints" } },
            { position = "bottom", size = 10, elements = { "repl", "console" } },
          },
          floating = { border = "rounded" },
      })

      require("nvim-dap-virtual-text").setup()

      dap.adapters.cppdbg = {
          id = 'cppdbg',
          type = 'executable',
          command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
      }

      dap.configurations.cpp = {
        {
          name = "Launch with args",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          args = function()
            local input = vim.fn.input("Program arguments: ")
            return vim.split(input, " ", { trimempty = true })
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = true,
          setupCommands = {
            {
              text = "-enable-pretty-printing",
              description = "enable pretty printing",
              ignoreFailures = true
            },
          },
        },
      }
      dap.configurations.c = dap.configurations.cpp

      vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
      vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

      vim.keymap.set("n", "<space>?", function()
        require("dapui").eval(nil, { enter = true })
      end)

      vim.keymap.set("n", "<F1>", dap.continue)
      vim.keymap.set("n", "<F2>", dap.step_into)
      vim.keymap.set("n", "<F3>", dap.step_over)
      vim.keymap.set("n", "<F4>", dap.step_out)
      vim.keymap.set("n", "<F5>", dap.step_back)
      vim.keymap.set("n", "<F6>", dap.restart)
      vim.keymap.set("n", "<F12>", function()
        require("dap").terminate()
        require("dapui").close()
      end, { desc = "Stop debugger" })

      vim.keymap.set({ "n", "v" }, "<leader>e", function()
        require("dapui").eval(nil, { enter = true })
      end, { desc = "DAP eval" })

      vim.keymap.set("n", "<leader>r", function()
        require("dap").repl.toggle()
      end, { desc = "DAP REPL" })

      vim.keymap.set("n", "<leader>dv", function()
        require("nvim-dap-virtual-text").toggle()
      end, { desc = "Toggle DAP virtual text" })

      vim.keymap.set("n", "<leader>w", function()
        require("dapui").elements.watches.add()
      end, { desc = "Add watch" })

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
