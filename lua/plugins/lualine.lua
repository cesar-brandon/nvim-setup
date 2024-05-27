return {
  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local Util = require("lazyvim.util")
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = require("lazyvim.config").icons

      vim.o.laststatus = vim.g.lualine_laststatus

      -- --tokyonight
      local colors = {
        bg = "#222436",
        fg = "#c0caf5",
        yellow = "#ECBE7B",
        cyan = "#7dcfff",
        darkblue = "#4266b3",
        green = "#9ece6a",
        orange = "#ff9e64",
        violet = "#bb9af7",
        magenta = "#bb9af7",
        blue = "#7aa2f7",
        red = "#f7768e",
      }

      --gruvbox dark
      -- local colors = {
      --   bg = "#282828",
      --   fg = "#ebdbb2",
      --   yellow = "#fabd2f",
      --   cyan = "#83a598",
      --   darkblue = "#458588",
      --   green = "#b8bb26",
      --   orange = "#fe8019",
      --   violet = "#b16286",
      --   magenta = "#d3869b",
      --   blue = "#83a598",
      --   red = "#fb4934",
      -- }

      --gruvbox light
      -- local colors = {
      --   bg = "#fbf1c7",
      --   fg = "#3c3836",
      --   yellow = "#fabd2f",
      --   cyan = "#83a598",
      --   darkblue = "#458588",
      --   green = "#b8bb26",
      --   orange = "#fe8019",
      --   violet = "#b16286",
      --   magenta = "#d3869b",
      --   blue = "#83a598",
      --   red = "#fb4934",
      -- }

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand("%:p:h")
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      return {
        options = {
          theme = {
            -- We are going to use lualine_c an lualine_x as left and
            -- right section. Both are highlighted by c theme .  So we
            -- are just setting default looks o statusline
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
          },
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
          component_separators = "",
          section_separators = "",
        },
        sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          -- These will be filled later
          lualine_c = {
            {
              function()
                return ""
              end,
              color = { fg = colors.darkblue }, -- Sets highlighting of component
              padding = { left = 0, right = 1 }, -- We don't need space before this
            },
            {
              -- mode component
              function()
                return "󰅶"
              end,
              color = function()
                -- auto change color according to neovims mode
                local mode_color = {
                  n = colors.red,
                  i = colors.green,
                  v = colors.blue,
                  [" "] = colors.blue,
                  V = colors.blue,
                  c = colors.magenta,
                  no = colors.red,
                  s = colors.orange,
                  S = colors.orange,
                  ["_"] = colors.orange,
                  ic = colors.yellow,
                  R = colors.violet,
                  Rv = colors.violet,
                  cv = colors.red,
                  ce = colors.red,
                  r = colors.cyan,
                  rm = colors.cyan,
                  ["r?"] = colors.cyan,
                  ["!"] = colors.red,
                  t = colors.red,
                }
                return { fg = mode_color[vim.fn.mode()] }
              end,
              padding = { right = 1 },
            },
            {
              -- filesize component
              "filesize",
              cond = conditions.buffer_not_empty,
            },
            {
              Util.lualine.pretty_path(),
              cond = conditions.buffer_not_empty,
              color = { fg = colors.magenta, gui = "bold" },
            },

            { "location" },
            { "progress", color = { fg = colors.fg, gui = "bold" } },
            {
              "diagnostics",
              souces = { "nvim_lsp" },
              symbols = { error = " ", warn = " ", info = " " },
              diagnostics_color = {
                color_error = { fg = colors.red },
                color_warn = { fg = colors.yellow },
                color_info = { fg = colors.cyan },
              },
            },
            {
              function()
                return "%="
              end,
            },
          },
          lualine_x = {
            {
              "branch",
              icon = "",
              color = { fg = colors.violet, gui = "bold" },
            },
            {
              "diff",
              symbols = { added = " ", modified = " ", removed = " " },
              diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.orange },
                removed = { fg = colors.red },
              },
              cond = conditions.hide_in_width,
            },
            {
              function()
                return " " .. os.date("%R")
              end,
            },
          },
        },
        inactive_sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
}
