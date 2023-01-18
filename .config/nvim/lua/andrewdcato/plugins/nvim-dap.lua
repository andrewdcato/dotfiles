local jsdebugger_installed, dap_vscode_js = pcall(require, "dap-vscode-js")
if not jsdebugger_installed then return end

local dap_installed, dap = pcall(require, "dap")
if not dap_installed then return end

local dap_ui_installed, dap_ui = pcall(require, "dapui")
if not dap_ui_installed then return end

dap_vscode_js.setup({
  debugger_path = "/Users/andrewcato/.local/share/nvim/site/pack/packer/opt/vscode-js-debug",
  adapters = { 'pwa-node', 'pwa-chrome' }, -- which adapters to register in nvim-dap
})

dap_ui.setup()

for _, language in ipairs({ "typescript", "javascript" }) do
  -- ignore external modules and node.js guts when stepping through code
  local skipFiles = {
    "${workspaceFolder}/<node_internals>/**",
    "${workspaceFolder}/node_modules/**"
  }

  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch `start-dev` script",
      cwd = "${workspaceFolder}",
      skipFiles = skipFiles,
      runtimeExecutable = "npm",
      restart = true,
      runtimeArgs = {
        "run-script", "start-dev"
      }
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to Process",
      processId = require('dap.utils').pick_process,
      cwd = "${workspaceFolder}",
      skipFiles = skipFiles,
    }
  }
end
