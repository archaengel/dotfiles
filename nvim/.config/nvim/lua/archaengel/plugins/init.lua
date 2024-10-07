vim.g.mapleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if vim.uv.fs_stat(lazypath) == nil then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
    'neovim/nvim-lspconfig',
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'Olical/conjure', version = 'v4.12.0' },
    { 'scalameta/nvim-metals', dependencies = { "nvim-lua/plenary.nvim" } },
    {
        -- Unison
        "unisonweb/unison",
        branch = "trunk",
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. "/editor-support/vim")
            require("lazy.core.loader").packadd(plugin.dir .. "/editor-support/vim")
        end,
        init = function(plugin)
             require("lazy.core.loader").ftdetect(plugin.dir .. "/editor-support/vim")
        end,
     },
    {
        "folke/zen-mode.nvim",
    },
    {
      "lervag/vimtex",
      lazy = false,     -- we don't want to lazy load VimTeX
      -- tag = "v2.15", -- uncomment to pin to a specific release
      init = function()
        -- VimTeX configuration goes here, e.g.
        vim.g.vimtex_view_method = "zathura"
      end
    },
    {
      'Julian/lean.nvim',
      event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

      dependencies = {
        'neovim/nvim-lspconfig',
        'nvim-lua/plenary.nvim',
        -- you also will likely want nvim-cmp or some completion engine
      },

      -- see details below for full configuration options
      opts = {
        lsp = {},
        mappings = true,
      }
    },

    -- terminal
    {
        "NvChad/nvterm",
        keys = {
            { "<leader>st", function() require('nvterm.terminal').toggle('horizontal') end,
                desc = "Open horizonal terminal" },
            { "<leader>rt", function() require('nvterm.terminal').toggle('vertical') end, desc = "Open vertical terminal" },
            { "<leader>it", function() require('nvterm.terminal').toggle('float') end, desc = "Open float terminal" },
        },
        config = function()
            require('nvterm').setup()
        end
    },

    -- file explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        version = "2.x",
        keys = {
            {
                "<leader>ft",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
                end,
                desc = "Explorer NeoTree (cwd)",
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        deactivate = function()
            vim.cmd([[Neotree close]])
        end,
        init = function()
            vim.g.neo_tree_remove_legacy_commands = 1
            if vim.fn.argc() == 1 then
                local stat = vim.uv.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        opts = {
            sources = { "filesystem", "buffers", "git_status", "document_symbols" },
            open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = true,
                use_libuv_file_watcher = true,
            },
            window = {
                mappings = {
                    ["<space>"] = "none",
                },
            },
            default_component_configs = {
                indent = {
                    with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
                icon = {
                    folder_empty = "󰜌",
                    folder_empty_open = "󰜌",
                },
                git_status = {
                    symbols = {
                        renamed = "󰁕",
                        unstaged = "󰄱",
                    },
                },
            },
        },
        config = function(_, opts)
            require("neo-tree").setup(opts)
            vim.api.nvim_create_autocmd("TermClose", {
                pattern = "*lazygit",
                callback = function()
                    if package.loaded["neo-tree.sources.git_status"] then
                        require("neo-tree.sources.git_status").refresh()
                    end
                end,
            })
        end,
    },

    -- debugger
    'mfussenegger/nvim-dap',
    { "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
    {
        "microsoft/vscode-js-debug",
        lazy = true,
        build = "npm install --legacy-peer-deps && npm run compile"
    },
    'lewis6991/gitsigns.nvim',

    'onsails/lspkind-nvim',
    {
        'j-hui/fidget.nvim',
        version = 'v1.4.5',
    },
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    "folke/which-key.nvim",

    {
        'chipsenkbeil/distant.nvim',
        branch = 'v0.3',
        config = function()
            require('distant'):setup {
                ['network.unix_socket'] = '/run/user/1000/distant/edwardnuno.distant.sock',
                servers = {
                    ['*'] = {
                        connect = {
                            default = {
                                options = 'ssh.identity_files=~/.ssh/google_compute_engine,ssh.user_known_hosts_file=~/.ssh/google_compute_known_hosts'
                            }
                        }
                    }
                }
            }
        end
    },
    -- Gh
    'github/copilot.vim',
    {
        'ldelossa/gh.nvim',
        dependencies = { { 'ldelossa/litee.nvim' } }
    },
    {
        'pwntester/octo.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require "octo".setup()
        end
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    {
        'ruifm/gitlinker.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
    },

    -- Db
    { 'tpope/vim-dadbod' },
    { 'kristijanhusak/vim-dadbod-ui' },

    -- Lean
    {
  'Julian/lean.nvim',
  event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

  dependencies = {
    'neovim/nvim-lspconfig',
    'nvim-lua/plenary.nvim',
    -- you also will likely want nvim-cmp or some completion engine
  },

  -- see details below for full configuration options
  opts = {
    mappings = true,
  }
},

    -- harpoon
    { "ThePrimeagen/harpoon", dependencies = { "nvim-lua/plenary.nvim" } },

    'folke/tokyonight.nvim',
    'preservim/nerdcommenter',
    'norcalli/nvim_utils',
    'windwp/nvim-autopairs',

    'kovisoft/paredit',
    'fladson/vim-kitty',
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
    },
    {
        'NTBBloodbath/rest.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        tag = "v1.2.1"
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },
    'nvim-telescope/telescope-symbols.nvim',
    'lewis6991/impatient.nvim',
    { "iamcco/markdown-preview.nvim",
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" }
    },
    {
        'NTBBloodbath/galaxyline.nvim',
        branch = 'main',
        -- your statusline
        config = function() end,
        -- some optional icons
        dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true }
    },
    {
        "SmiteshP/nvim-navic",
        dependencies = "neovim/nvim-lspconfig"
    },
    {
        "lbrayner/vim-rzip"
    }
}
