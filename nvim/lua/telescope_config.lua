-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')


local searchdirs = {"."}
local host = os.getenv("HOSTNAME")

if string.match(host, "uboone") then
  table.insert(searchdirs, "/uboone/app/users/bnayak")
  table.insert(searchdirs, "/uboone/data/users/bnayak")
elseif string.match(host, "dune") then
  table.insert(searchdirs, "/dune/app/users/bnayak")
  table.insert(searchdirs, "/dune/data/users/bnayak")
end

-- allow folding for files opened through telescope
-- see : https://github.com/nvim-telescope/telescope.nvim/issues/559 for more details
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<CR>"] = function()
                    vim.cmd [[:stopinsert]]
                    vim.cmd [[call feedkeys("\<CR>")]]
                end
            }
        },
    },
    pickers = {
      find_files = {
        search_dirs = searchdirs,
        file_ignore_patterns = {'^.*localProducts_.*/.*', '^.*build_.*/.*', '^.*root$', '^.*dat$'},
      },
      live_grep = {
        search_dirs = searchdirs,
        file_ignore_patterns = {'^.*localProducts_.*/.*', '^.*build_.*/.*', '^.*root$', '^.*dat$'},
      },
    },
}

local fcldirs = {}
local fclenv = os.getenv("FHICL_FILE_PATH")
if not (fclenv == nil or fclenv == '') then
  for d in string.gmatch(fclenv, "[^:]+") do
    table.insert(fcldirs, d)
  end
end

function _G.fclsearch()
  require("telescope.builtin").find_files ({
    search_dirs = fcldirs
  })
end

function _G.fclgrep()
  require("telescope.builtin").live_grep ({
    search_dirs = fcldirs
  })
end

vim.keymap.set('n', '<leader>fc', ':call v:lua.fclsearch()<CR>',  {noremap = true, silent = true})
vim.keymap.set('n', '<leader>fs', ':call v:lua.fclgrep()<CR>',  {noremap = true, silent = true})
