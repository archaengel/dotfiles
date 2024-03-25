require('remote-sshfs').setup {
    connections = {
        ssh_configs = { vim.fn.expand("$HOME") .. "/.ssh/config" }
    },
    log = {
        enable = true,
        types = {
            all = false,
            util = false,
            handler = false,
            sshfs = false,
        },

    }
}
