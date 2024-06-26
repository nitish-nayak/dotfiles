local flash = require("flash")

flash.setup({
  modes = {
    char = {
      jump_labels = false
    },
  },
  label = {
    rainbow = {
      enabled = true
    },
  }
})
-- -- Mappings.
local opts = { noremap=true }

vim.keymap.set({'n', 'x', 'o'}, 's', function() flash.jump() end, opts)
vim.keymap.set({'n', 'x', 'o'}, '<leader>s', function() flash.treesitter() end, opts)
vim.keymap.set({'o'}, 'r', function() flash.remote() end, opts)
vim.keymap.set({'x', 'o'}, 'R', function() flash.treesitter_search() end, opts)
vim.keymap.set({'c'}, '<c-s>', function() flash.toggle() end, opts)
