vim.opt.shell = "zsh"

require('toggleterm').setup{
  -- size can be a number or function which is passed the current terminal
  function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<C-t>]],
  hide_numbers = false, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = false, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  persist_mode = false, -- if set to true (default) the previous terminal mode will be remembered
  direction = 'horizontal', -- 'vertical' | 'horizontal' | 'tab' | 'float',
  close_on_exit = true, -- close the terminal window when the process exits
   -- Change the default shell. Can be a string or a function returning a string
  -- shell = zsh,
  auto_scroll = true, -- automatically scroll to the bottom on terminal output
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = 'single', -- | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    -- like `size`, width and height can be a number or function which is passed the current terminal
    winblend = 3,
    highlights = {
        border = "Normal",
        background = "Normal",
    }
  },
}

-- moving through terminals
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- my terminals
local Terminal  = require('toggleterm.terminal').Terminal

local htop = Terminal:new({
  cmd = "htop",
  hidden = true,
  direction = 'float',
  dir = '~',
  close_on_exit = true, -- close the terminal window when the process exits
})

function _htop_toggle()
  htop:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>1", "<cmd>lua _htop_toggle()<CR>", {noremap = true, silent = true})

local make = Terminal:new({
  cmd = "make install -j 4",
  hidden = true,
  direction = 'float',
  dir = "$MRB_BUILDDIR",
  close_on_exit = false, -- close the terminal window when the process exits
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd.normal("bd")  -- delete the buffer entirely
  end
})

function _make_toggle()
  make:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>2", "<cmd>lua _make_toggle()<CR>", {noremap = true, silent = true})

local mrb = Terminal:new({
  cmd = "if [[ -f CMakeCache.txt ]]; then rm CMakeCache.txt; fi; mrb i --generator ninja",
  hidden = true,
  direction = 'float',
  dir = "$MRB_BUILDDIR",
  close_on_exit = false, -- close the terminal window when the process exits
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd.normal("bd")  -- delete the buffer entirely
  end
})

function _mrb_toggle()
  mrb:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>3", "<cmd>lua _mrb_toggle()<CR>", {noremap = true, silent = true})
