require('gitsigns').setup({
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
    end

    -- hunk navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end, 'Next git hunk')

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end, 'Previous git hunk')

    -- staging / reset
    map('n', '<leader>hs', gitsigns.stage_hunk, 'Stage hunk')
    map('n', '<leader>hr', gitsigns.reset_hunk, 'Reset hunk')
    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, 'Stage hunk')
    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, 'Reset hunk')
    map('n', '<leader>hu', gitsigns.undo_stage_hunk, 'Undo stage hunk')
    map('n', '<leader>hp', gitsigns.preview_hunk, 'Preview hunk')

    -- blame / diff
    map('n', '<leader>hb', function() gitsigns.blame_line({ full = true }) end, 'Blame line')
    map('n', '<leader>hd', gitsigns.diffthis, 'Diff this')

    -- text object for a hunk
    map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, 'Select hunk')
  end,
})
