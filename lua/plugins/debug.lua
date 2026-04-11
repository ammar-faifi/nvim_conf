-- debug.lua
--

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- User Interface for DAP
      { 'rcarriga/nvim-dap-ui', dependencies = { 'nvim-neotest/nvim-nio' } },
      -- Automatic installation of debug adapters
      'jay-babu/mason-nvim-dap.nvim',
      -- Virtual text for variables
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      -- Setup adapters through mason
      require('mason-nvim-dap').setup {
        ensure_installed = { 'python', 'delve' }, -- Add your debuggers here
        automatic_installation = true,
      }

      -- UI setup
      dapui.setup()
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
    -- Lazy load on specific keys or events
    keys = {
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle Breakpoint',
      },
      {
        '<leader>dc',
        function()
          require('dap').continue()
        end,
        desc = 'Continue',
      },
    },
  },

  {
    'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup(vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python')
    end,
  },
}
