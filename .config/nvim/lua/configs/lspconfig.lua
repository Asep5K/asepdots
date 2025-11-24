require("nvchad.configs.lspconfig").defaults()

vim.lsp.config('lua_ls', {
    root_dir = function(bufnr, on_dir)
    on_dir(vim.fn.getcwd())
  end,
--  
  settings = {
    Lua = {
--      diagnostics = {
--        globals = { "hl" },
--      },
      workspace = {
        library = {
          "/usr/share/hypr/stubs",
          vim.fn.expand("$VIMRUNTIME/lua"),
        },
      },
    },
  },
})

local servers = {
    "html",
    "cssls",
    "gopls",
    "pyright",
    "ruff",
    "clangd",
    "bashls",
    "lua_ls",
    "jsonls",
    "hyprls",
}
vim.lsp.enable(servers)

-- vim: ft=lua:nowrap
-- read :h vim.lsp.config for changing options of lsp servers 