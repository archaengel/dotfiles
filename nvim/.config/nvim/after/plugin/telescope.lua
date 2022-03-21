local actions = require('telescope.actions')

require('telescope').setup {
    pickers = {
        buffers = {
            attach_mappings = function(_, map)
                map('n', 'dd', actions.delete_buffer)

                return true
            end
        }
    }
}
require('telescope').load_extension('fzy_native')

