-- VimTeX configuration
vim.cmd [[
  let g:vimtex_view_general_viewer = 'zathura'
  let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
  let maplocalleader = ","
]]

-- Copilot configuration
vim.cmd [[
  let g:copilot_enabled = v:false
]]
require("CopilotChat").setup()

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})
-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})
require("cmp_git").setup() ]]-- 

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- Replace thie require'lspconfig' with the modern lsp.config setup
require('lspconfig')['clangd'].setup {
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  }
}

require('lspconfig')['texlab'].setup {
  capabilities = capabilities
}

require('lspconfig')['tinymist'].setup {
  capabilities = capabilities
}

require('lspconfig')['pylsp'].setup {
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        flake8 = {enabled = true},
        pycodestyle = {enabled = false},
        pyflakes = {enabled = false},
        pylint = {enabled = false},
        mccabe = {enabled = false},
      },
    },
  }
}

require('lspconfig')['julials'].setup {
  capabilities = capabilities,
  cmd = {
    "julia",
    "--startup-file=no",
    "--history-file=no",
    "-e",
    [[
      using LanguageServer; using Pkg;
      import StaticLint, SymbolServer;
      env_path = dirname(Pkg.Types.Context().env.project_file);
      server = LanguageServer.LanguageServerInstance(stdin, stdout, env_path, "");
      server.runlinter = true;
      run(server);
    ]]
  }
}

-- typst-preview config
require('typst-preview').setup({
  -- Setting this true will enable logging debug information to
  -- `vim.fn.stdpath 'data' .. '/typst-preview/log.txt'`
  debug = false,

  -- Custom format string to open the output link provided with %s
  -- Example: open_cmd = 'firefox %s -P typst-preview --class typst-preview'
  open_cmd = nil,

  -- Setting this to 'always' will invert black and white in the preview
  -- Setting this to 'auto' will invert depending if the browser has enable
  -- dark mode
  -- Setting this to '{"rest": "<option>","image": "<option>"}' will apply
  -- your choice of color inversion to images and everything else
  -- separately.
  invert_colors = 'never',

  -- Whether the preview will follow the cursor in the source file
  follow_cursor = true,

  -- Provide the path to binaries for dependencies.
  -- Setting this will skip the download of the binary by the plugin.
  -- Warning: Be aware that your version might be older than the one
  -- required.
  dependencies_bin = {
    ['tinymist'] = nil,
    ['websocat'] = nil
  },

  -- A list of extra arguments (or nil) to be passed to previewer.
  -- For example, extra_args = { "--input=ver=draft", "--ignore-system-fonts" }
  extra_args = nil,

  -- This function will be called to determine the root of the typst project
  get_root = function(path_of_main_file)
    local root = os.getenv 'TYPST_ROOT'
    if root then
      return root
    end
    return vim.fn.fnamemodify(path_of_main_file, ':p:h')
  end,

  -- This function will be called to determine the main file of the typst
  -- project.
  get_main_file = function(path_of_buffer)
    return path_of_buffer
  end,
})

