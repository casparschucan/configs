local Plug = vim.fn['plug#']
-- Plugins
vim.call('plug#begin')
-- colour scheme
Plug('dracula/vim')

-- file icons for nerd TREE
Plug('ryanoasis/vim-devicons')
-- snippets 
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

-- file browsing
Plug('preservim/nerdtree')

-- easy commenting
Plug('preservim/nerdcommenter')

-- auto pairs
Plug('jiangmiao/auto-pairs')

--Latex
Plug('lervag/vimtex')

--lsp configuration
Plug('neovim/nvim-lspconfig')

-- autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

--copilot
Plug 'github/copilot.vim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'

-- start screen
Plug 'mhinz/vim-startify'

-- file finder
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter'

-- typst
Plug 'chomosuke/typst-preview.nvim'

vim.call('plug#end')
