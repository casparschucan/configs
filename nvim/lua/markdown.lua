-- nvim-treesitter isn't configured elsewhere in this repo; render-markdown.nvim
-- needs the markdown/markdown_inline parsers installed and highlighting enabled.
require('nvim-treesitter').install({ 'markdown', 'markdown_inline' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' },
  callback = function() vim.treesitter.start() end,
})

require('render-markdown').setup({})
