return {
  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        -- separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "folke/tokyonight.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("tokyonight.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            -- tokyonight
            InclineNormal = { guibg = colors.blue, guifg = colors.bg_dark },
            InclineNormalNC = { guifg = colors.purple, guibg = colors.bg_dark },
            -- Gruvbox
            --   InclineNormal = { guibg = "#d65d0e", guifg = "#3c3836" },
            --   InclineNormalNC = { guifg = "#3c3836", guibg = "#98971a" },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },
  {
    "folke/snacks.nvim",
    config = function()
      require("snacks").setup({
        dashboard = {
          enabled = true,
          preset = {
            header = [[
██████╗  ██████╗ ███╗   ██╗    ██████╗ ██╗ █████╗ ██╗
██╔══██╗██╔═══██╗████╗  ██║    ██╔══██╗██║██╔══██╗██║
██████╔╝██║   ██║██╔██╗ ██║    ██║  ██║██║███████║██║
██╔══██╗██║   ██║██║╚██╗██║    ██║  ██║██║██╔══██║╚═╝
██████╔╝╚██████╔╝██║ ╚████║    ██████╔╝██║██║  ██║██╗
╚═════╝  ╚═════╝ ╚═╝  ╚═══╝    ╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝
]],
          },
          sections = {
            {
              pane = 2,
              { section = "header" },
              { section = "keys", gap = 1, padding = 1 },
              { section = "startup" },
            },
            {
              section = "terminal",
              cmd = "cat | C:/Users/Montenegro/AppData/Local/nvim/ansi/gopher.sh",
              width = 46,
              height = 25,
            },
          },
        },
      })
    end,
  },
}
