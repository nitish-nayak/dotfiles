  vim.g.aider_command = 'aider --no-auto-commits --watch-files --cache-prompts'
  vim.g.aider_buffer_open_type = 'floating'
  vim.g.aider_floatwin_width = 150
  vim.g.aider_floatwin_height = 50

  vim.api.nvim_create_autocmd('User',
    {
      pattern = 'AiderOpen',
      callback =
          function(args)
            vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { buffer = args.buf })
            vim.keymap.set('n', '<Esc>', '<cmd>AiderHide<CR>', { buffer = args.buf })
          end
    })
  vim.api.nvim_set_keymap('n', '<leader>ao', ':AiderRun<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>aa', ':AiderAddCurrentFile<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ar', ':AiderAddCurrentFileReadOnly<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>aw', ':AiderAddWeb<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>av', ':AiderAddPartialReadonlyContext<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', '<leader>aV', ':AiderVisualTextWithPrompt<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', '<leader>as', ':AiderAddFileVisualSelected<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ab', ':AiderAddBuffers<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ac', ':AiderToggleCodeMode<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ae', ':AiderToggleArchitectMode<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>a+', ':AiderSilentAddCurrentFile<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ap', ':AiderPaste<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ah', ':AiderHide<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ax', ':AiderExit<CR>', { noremap = true, silent = true })
