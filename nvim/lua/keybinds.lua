
vim.keymap.set('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', '<leader>aa', ':lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<leader>gd', ':lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', '<leader>gr', ':lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', '<leader>gi', ':lua vim.lsp.buf.implementation()<CR>')

vim.keymap.set('n', '<leader>tt', ':NERDTreeToggle<CR>')
vim.keymap.set('n', '<leader>tr', ':NERDTreeRefreshRoot<CR>')

vim.keymap.set('n', '<leader>tp', ':TypstPreview<CR>')

-- telescope config
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<leader>coc', ':CopilotChat<CR>', { desc = 'Open Copilot Chat' })
vim.keymap.set('n', '<leader>ccc', ':CopilotChatClose<CR>', { desc = 'Copilot Chat close' })
vim.keymap.set('n', '<leader>cca', ':CopilotChatActAs<CR>', { desc = 'Copilot Chat Act As' })
vim.keymap.set('n', '<leader>ccp', ':CopilotChatPrompt<CR>', { desc = 'Copilot Chat Prompt' })
vim.keymap.set('n', '<leader>ccr', ':CopilotChatReset<CR>', { desc = 'Copilot Chat Reset' })
vim.keymap.set('n', '<leader>coe', ':Copilot enable<CR>', { desc = 'Enable Copilot' })
vim.keymap.set('n', '<leader>cod', ':Copilot disable<CR>', { desc = 'Disable Copilot' })
