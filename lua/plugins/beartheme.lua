return {
  -- BearTheme inspirado no VSCode
  {
    "folke/tokyonight.nvim",
    enabled = false, -- Desabilitar se não quiser conflito
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = false,
      term_colors = true,

      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.20,
      },

      styles = {
        comments = { "italic" },
        conditionals = { "bold" },
        loops = { "bold" },
        functions = { "bold" },
        keywords = { "italic" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = { "bold" },
        properties = {},
        types = { "bold" },
        operators = {},
      },

      -- Cores customizadas baseadas no BearTheme
      color_overrides = {
        mocha = {
          -- Backgrounds (preto profundo como BearTheme)
          base = "#010002", -- editor.background
          mantle = "#090011", -- sideBar.background
          crust = "#050007", -- activityBar.background

          -- Foregrounds
          text = "#eeffff", -- editor.foreground
          subtext1 = "#c0b2d6",
          subtext0 = "#b4befe",

          -- Accent colors (roxos e rosas vibrantes)
          mauve = "#cc00ff", -- Border color
          pink = "#f5004a", -- Operators/punctuation
          flamingo = "#f07178", -- Tags

          -- Core colors
          red = "#FF5370", -- Invalid/errors
          maroon = "#fc0f36",
          peach = "#F78C6C",
          yellow = "#ffe449", -- Classes
          green = "#00ff37", -- Keywords
          teal = "#00c5b5", -- Strings
          sky = "#00b7ff", -- Entity types
          sapphire = "#82AAFF",
          blue = "#094bff",
          lavender = "#C792EA", -- Attributes

          -- Surface colors
          surface0 = "#0a001b", -- Tab background
          surface1 = "#0f0027", -- Title bar
          surface2 = "#3b0032", -- Hover
          overlay0 = "#546E7A", -- Comments
          overlay1 = "#65737E",
          overlay2 = "#7802ff", -- Variables
        },
      },

      custom_highlights = function(colors)
        return {
          -- Editor principal
          Normal = { fg = colors.text, bg = colors.base },
          NormalFloat = { fg = colors.text, bg = colors.mantle },

          -- Comentários
          Comment = { fg = colors.overlay0, style = { "italic" } },

          -- Keywords (verde neon)
          Keyword = { fg = colors.green, style = { "bold" } },
          Conditional = { fg = colors.green, style = { "bold" } },
          Repeat = { fg = colors.green, style = { "bold" } },

          -- Funções (roxo)
          Function = { fg = "#8400ff", style = { "bold" } },

          -- Variáveis (roxo claro)
          Variable = { fg = colors.overlay2 },

          -- Strings (ciano)
          String = { fg = colors.teal },

          -- Números (verde claro)
          Number = { fg = "#71f76c" },
          Constant = { fg = "#71f76c" },

          -- Classes (amarelo)
          Type = { fg = colors.yellow },

          -- Operators (rosa)
          Operator = { fg = colors.pink },

          -- Busca com contraste alto
          Search = { bg = colors.yellow, fg = colors.base, style = { "bold" } },
          IncSearch = { bg = colors.red, fg = colors.base, style = { "bold" } },

          -- Linha atual
          CursorLine = { bg = "#1a001f" },
          CursorLineNr = { fg = colors.mauve, style = { "bold" } },

          -- Visual selection (roxo)
          Visual = { bg = "#3c005f", style = { "bold" } },

          -- Status line
          StatusLine = { fg = colors.text, bg = colors.surface1 },

          -- Tabs
          TabLine = { bg = colors.surface0 },
          TabLineSel = { fg = colors.text, bg = colors.mauve },

          -- Sidebar
          NvimTreeNormal = { fg = colors.text, bg = colors.mantle },

          -- Git signs
          GitSignsAdd = { fg = colors.green },
          GitSignsChange = { fg = colors.yellow },
          GitSignsDelete = { fg = colors.red },

          -- Diagnostics
          DiagnosticError = { fg = colors.red },
          DiagnosticWarn = { fg = colors.yellow },
          DiagnosticInfo = { fg = colors.sky },
          DiagnosticHint = { fg = colors.teal },

          -- LSP
          ["@variable"] = { fg = colors.overlay2 },
          ["@function"] = { fg = "#8400ff", style = { "bold" } },
          ["@keyword"] = { fg = colors.green, style = { "bold" } },
          ["@string"] = { fg = colors.teal },
          ["@number"] = { fg = "#71f76c" },
          ["@operator"] = { fg = colors.pink },
          ["@type"] = { fg = colors.yellow },
          ["@punctuation"] = { fg = colors.pink },
        }
      end,

      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        mini = { enabled = true },
        noice = true,
        telescope = { enabled = true },
        which_key = true,
      },
    },
  },

  -- Configurar LazyVim para usar o BearTheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
