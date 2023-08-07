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
    vim.diagnostic.disable()
  else
    vim.g.diagnostics_active = true
    vim.diagnostic.enable()
  end
end


local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- Mappings.
  local opts = { noremap=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<leader>cd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>ci', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>ch', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>cs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>cr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>ce', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<leader>[',  '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<leader>]',  '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

  vim.keymap.set('n', '<leader>cn', vim.lsp.buf.rename, opts)
  vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>ct', ':call v:lua.toggle_diagnostics()<CR>',  {noremap = true, silent = true})
end


require("mason").setup()
require("mason-lspconfig").setup{
  ensure_installed = { "pyright", "lua_ls", "bashls"},
}

-- new lsp servers get default on_attach and capabilities but can be configured differently
require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        lspconfig[server_name].setup {on_attach = on_attach, capabilities=capabilities}
    end,
    -- -- Next, you can provide a dedicated handler for specific servers.
    -- -- For example, a handler override for the `pyright`:
    -- -- disable all diagnostics
    ["pyright"] = function ()
         lspconfig.pyright.setup {
             handlers = {
               ["textDocument/publishDiagnostics"] = function() end,
             },
             on_attach = on_attach,
             capabilities = capabilities
         }
    end
}

vim.diagnostic.disable()

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = false,
    severity_sort = true,
})
