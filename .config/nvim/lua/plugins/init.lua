return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
{
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require('configs.chunk')
  end
},
{
  "mikavilpas/yazi.nvim",
  version = "*", -- use the latest stable version
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
    },
    init = function()
        vim.g.loaded_netrwPlugin = 1
        end,
    config = function()
        require("configs.yazi")
        end,
-- {
--    "nvim-tree/nvim-tree.lua",
--    opts = {
--      view = {
--        side = "right",
--      },
--    },
--  },
},
{
  'mrcjkb/rustaceanvim',
  version = '^9', -- Recommended
  lazy = false, -- Di-load otomatis saat buka file rust
},
  -- test new blink
{
    import = "nvchad.blink.lazyspec"
},


  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}