-- TODO(archaengel): Figure out how to suport dev icons in status line
local gl = require('galaxyline')
local fileinfo = require 'galaxyline.providers.fileinfo'
-- local colors = require('galaxyline.theme').default
local colors = require 'tokyonight.colors'.setup {}
local condition = require('galaxyline.condition')
local gls = gl.section
local cmd = vim.cmd

cmd('highlight GalaxylineFillSection guibg=' .. colors.bg_statusline)

gl.short_line_list = { 'NvimTree', 'vista', 'dbui' }

gls.left[1] = {
    RainbowRed = {
        provider = function() return '▊ ' end,
        highlight = { colors.blue, colors.bg_statusline }
    }
}
gls.left[2] = {
    ViMode = {
        provider = function()
            -- auto change color according the vim mode
            local mode_color = {
                n = colors.red,
                i = colors.green,
                v = colors.blue,
                [''] = colors.blue,
                V = colors.blue,
                c = colors.magenta,
                no = colors.red,
                s = colors.orange,
                S = colors.orange,
                [''] = colors.orange,
                ic = colors.yellow,
                R = colors.purple,
                Rv = colors.purple,
                cv = colors.red,
                ce = colors.red,
                r = colors.cyan,
                rm = colors.cyan,
                ['r?'] = colors.cyan,
                ['!'] = colors.red,
                t = colors.red
            }
            vim.api.nvim_command('hi GalaxyViMode guifg=' ..
                mode_color[vim.fn.mode()])
            return '  '
        end,
        highlight = { colors.red, colors.bg_statusline, 'bold' }
    }
}
gls.left[3] = {
    FileSize = {
        provider = 'FileSize',
        condition = condition.buffer_not_empty,
        highlight = { colors.fg, colors.bg_statusline }
    }
}
gls.left[4] = {
    FileIcon = {
        provider = 'FileIcon',
        condition = condition.buffer_not_empty,
        highlight = {
            require('galaxyline.providers.fileinfo').get_file_icon_color,
            colors.bg_statusline
        }
    }
}

gls.left[5] = {
    FileName = {
        -- provider = 'FileName',
        provider = fileinfo.get_current_file_path,
        condition = condition.buffer_not_empty,
        highlight = { colors.magenta, colors.bg_statusline, 'bold' }
    }
}

gls.left[6] = {
    LineInfo = {
        provider = 'LineColumn',
        separator = ' ',
        separator_highlight = { 'NONE', colors.bg_statusline },
        highlight = { colors.fg, colors.bg_statusline }
    }
}

gls.left[7] = {
    PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = { 'NONE', colors.bg_statusline },
        highlight = { colors.fg, colors.bg_statusline, 'bold' }
    }
}

gls.left[8] = {
    DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '  ',
        highlight = { colors.red, colors.bg_statusline }
    }
}
gls.left[9] = {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = '  ',
        highlight = { colors.yellow, colors.bg_statusline }
    }
}

gls.left[10] = {
    DiagnosticHint = {
        provider = 'DiagnosticHint',
        icon = '  ',
        highlight = { colors.cyan, colors.bg_statusline }
    }
}

gls.left[11] = {
    DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        icon = '  ',
        highlight = { colors.blue, colors.bg_statusline }
    }
}

gls.mid[1] = {
    ShowLspClient = {
        provider = 'GetLspClient',
        condition = function()
            local tbl = { ['dashboard'] = true, [''] = true }
            if tbl[vim.bo.filetype] then return false end
            return true
        end,
        icon = ' ',
        highlight = { colors.blue, colors.bg_statusline, 'bold' }
    }
}

gls.right[1] = {
    FileEncode = {
        provider = 'FileEncode',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = { 'NONE', colors.bg_statusline },
        highlight = { colors.green, colors.bg_statusline, 'bold' }
    }
}

gls.right[2] = {
    GitIcon = {
        provider = function() return '  ' end,
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = { 'NONE', colors.bg_statusline },
        highlight = { colors.purple, colors.bg_statusline, 'bold' }
    }
}

gls.right[3] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = condition.check_git_workspace,
        highlight = { colors.purple, colors.bg_statusline, 'bold' }
    }
}

gls.right[4] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = { colors.green, colors.bg_statusline }
    }
}
gls.right[5] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = condition.hide_in_width,
        icon = ' 柳',
        highlight = { colors.orange, colors.bg_statusline }
    }
}
gls.right[6] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = { colors.red, colors.bg_statusline }
    }
}

gls.right[7] = {
    RainbowBlue = {
        provider = function() return ' ▊' end,
        highlight = { colors.blue, colors.bg_statusline }
    }
}

gls.short_line_left[1] = {
    BufferType = {
        provider = 'FileTypeName',
        separator = ' ',
        separator_highlight = { 'NONE', colors.bg_statusline },
        highlight = { colors.blue, colors.bg_statusline, 'bold' }
    }
}

gls.short_line_left[2] = {
    SFileName = {
        provider = 'SFileName',
        condition = condition.buffer_not_empty,
        highlight = { colors.fg, colors.bg_statusline, 'bold' }
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = 'BufferIcon',
        highlight = { colors.fg, colors.bg_statusline }
    }
}
