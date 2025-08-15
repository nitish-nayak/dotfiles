---@diagnostic disable: unused-local, trailing-space
-- Set up lspconfig.
local lspconfig = require 'lspconfig'

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local signs = { Error = "✗", Warn = "✄", Hint = "✙", Info = "⚡" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "cpp", "python", "lua", "bash", "yaml", "jsonnet", "vim"},
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            -- init_selection = "gnn",
            -- node_incremental = "grn",
            -- scope_incremental = "grc",
            -- node_decremental = "grm",
            init_selection = "<space>", -- maps in normal mode to init the node/scope selection with space
            node_incremental = "<space>", -- increment to the upper named parent
            node_decremental = "<bs>", -- decrement to the previous node
            scope_incremental = "<space><tab>", -- increment to the upper scope (as defined in locals.scm)
        },
    },
    indent = {
        enable = true
    }
}

vim.g.diagnostics_active = false
function _G.toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.diagnostic.enable(false)
  else
    vim.g.diagnostics_active = true
    vim.diagnostic.enable()
  end
end

-- See `:help vim.lsp.*` for documentation on any of the below functions
local opts = { noremap=true }
vim.keymap.set('n', '<leader>cd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', '<leader>ci', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<leader>ch', vim.lsp.buf.hover, opts)
vim.keymap.set('n', '<leader>cs', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.references, opts)
vim.keymap.set('n', '<leader>ce', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>[',  vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>]',  vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>cn', vim.lsp.buf.rename, opts)
vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, opts)
vim.keymap.set('n', '<leader>ct', ':call v:lua.toggle_diagnostics()<CR>',  {noremap = true, silent = true})


require("mason").setup()
require("mason-lspconfig").setup{
  ensure_installed = { "pyright", "clangd", "lua_ls", "bashls"},
}

lspconfig.pyright.setup {
   handlers = {
     ["textDocument/publishDiagnostics"] = function() end,
   },
   capabilities = capabilities
}

vim.diagnostic.enable(false)

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = false,
    severity_sort = true,
})
