local dap = require('dap')
local ui = require('dap-view')
require("dap-vscode-js").setup({
    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
})

vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpoint', { text = '👉', texthl = '', linehl = '', numhl = '' })

for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
    require("dap").configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require 'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-chrome",
            request = "attach",
            name = "Attach",
            port = "9222",
            cwd = "${workspaceFolder}",
        },
    }
end

local dapgo = require('dap-go')
dapgo.setup {
    -- :help dap-configuration
    dap_configurations = {
        {
            -- Must be "go" or it will be ignored by the plugin
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
        },
    },
    -- delve configurations
    delve = {
        -- the path to the executable dlv which will be used for debugging.
        -- by default, this is the "dlv" executable on your PATH.
        path = "dlv",
        initialize_timeout_sec = 20,
        port = "${port}",
        args = {},
        build_flags = {},
        detached = vim.fn.has("win32") == 0,
        cwd = nil,
    },
    -- options related to running closest test
    tests = {
        -- enables verbosity when running the test.
        verbose = false,
    },
}

vim.keymap.set("n", "<space>dbb", dap.toggle_breakpoint)
vim.keymap.set("n", "<space>dg", dap.run_to_cursor)

vim.keymap.set("n", "<space>dc", dap.continue)
vim.keymap.set("n", "<space>di", dap.step_into)
vim.keymap.set("n", "<space>dv", dap.step_over)
vim.keymap.set("n", "<space>do", dap.step_out)
vim.keymap.set("n", "<space>du", dap.step_back)
vim.keymap.set("n", "<space>dr", dap.restart)
vim.keymap.set("n", "<space>dT", dapgo.debug_last_test)
vim.keymap.set("n", "<space>dt", dapgo.debug_test)

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
