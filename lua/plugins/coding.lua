return {
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = true,
      },
    },
  },
  -- {
  --   "piersolenski/telescope-import.nvim",
  --   dependencies = "nvim-telescope/telescope.nvim",
  --   config = function()
  --     require("telescope").load_extension("import")
  --   end,
  -- },
}
