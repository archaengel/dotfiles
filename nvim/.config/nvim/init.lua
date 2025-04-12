pcall(require, 'impatient')

require('nixCatsUtils').setup {
  non_nix_value = true,
}

require('lze').register_handlers(require('nixCatsUtils.lzUtils').for_cat)
if not require('nixCatsUtils').isNixCats then
  require('archaengel.plugins')
end
require('archaengel.globals')
require('archaengel.augroups')

-- Setup treesitter and language server
require('archaengel.lsp')
