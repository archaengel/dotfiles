local actions = require('telescope.actions')

require('telescope').setup {
    pickers = {
        buffers = {
            attach_mappings = function(_, map)
                map('n', 'dd', actions.delete_buffer)

                return true
            end
        }
    },
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown()
        }
    }
}
pcall(require('telescope').load_extension, 'fzf')
require('telescope').load_extension('ui-select')
require('telescope').load_extension('remote-sshfs')
