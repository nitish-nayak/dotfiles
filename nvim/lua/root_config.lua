local rootcern = os.getenv("ROOTSYS")
local clangd_macro=os.getenv("PWD") .. "/compile_flags.txt"

function file_exists(name)
   local f = io.open(name, "r")
   return f ~= nil and io.close(f)
end

function write_clangdmacro()
    os.execute('echo "--language=c++" > '..clangd_macro)
    os.execute("echo $(root-config --auxcflags) | sed 's/ /\\n/g' >> "..clangd_macro)
    os.execute('echo "-I"'..rootcern..'"/include" >> '..clangd_macro)
end


-- detect C files as cpp
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = "*.C",
    command = "set filetype=cpp",
})

-- on buffer write, write out a compile_flags.txt based on root
-- restart lsp
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = "*.C",
    callback = function()
      if not (rootcern == nil) and not file_exists(clangd_macro) then
        write_clangdmacro()
        vim.cmd('LspRestart')
      end
    end,
})
