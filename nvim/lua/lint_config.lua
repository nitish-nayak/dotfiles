local lint = require 'lint'

lint.linters_by_ft = {
  python = {'pylint'},
  sh = {'shellcheck'}
}

local pylint = lint.linters.pylint
pylint.args = {
  '-f', 'json',
  '--ignored-modules=ROOT'
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    vim.diagnostic.enable()
    lint.try_lint()
  end,
})
