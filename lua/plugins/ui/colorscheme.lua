return {
  -- BearTheme inspirado no VSCode
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false, -- Carrega na inicialização, não lazy
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
      color_overrides = {
        mocha = {
          base = "#000000",
          mantle = "#0a0a0a",
          crust = "#050505",

          -- Foregrounds
          text = "#eeffff",

          -- Accent colors (neon)
          mauve = "#cc00ff", -- Border/Roxo
          pink = "#f5004a", -- Operators
          green = "#00ff37", -- Keywords (Verde Neon)
          yellow = "#ffe449", -- Classes
          teal = "#00c5b5", -- Strings
          overlay2 = "#7802ff", -- Variables
        },
      },

      custom_highlights = function(colors)
        return {
          -- Editor e UI
          Normal = { fg = colors.text, bg = colors.base },
          Comment = { fg = "#7f849c", style = { "italic" } },
          Search = { bg = colors.yellow, fg = colors.base, style = { "bold" } },
          IncSearch = { bg = colors.red, fg = colors.base, style = { "bold" } },
          CursorLine = { bg = "#1a1a1a" },
          CursorLineNr = { fg = colors.yellow, style = { "bold" } },
          Visual = { bg = "#2a2a3a", style = { "bold" } },

          -- Forçar o Verde Neon nas Keywords (Treesitter)
          ["@keyword"] = { fg = colors.green, style = { "bold" } },
          ["@keyword.function"] = { fg = colors.green, style = { "bold" } },
          ["@keyword.return"] = { fg = colors.green, style = { "bold" } },
          ["@conditional"] = { fg = colors.green, style = { "bold" } },
          ["@repeat"] = { fg = colors.green, style = { "bold" } },

          -- Forçar o Roxo nas Funções (Treesitter)
          ["@function"] = { fg = "#8400ff", style = { "bold" } },
          ["@function.builtin"] = { fg = "#8400ff", style = { "bold" } },
          ["@function.call"] = { fg = "#8400ff", style = { "bold" } },
          ["@method"] = { fg = "#8400ff", style = { "bold" } },

          -- Variáveis e Parâmetros
          ["@variable"] = { fg = colors.overlay2 },
          ["@parameter"] = { fg = colors.overlay2 },

          -- Outros elementos
          ["@string"] = { fg = colors.teal },
          ["@type"] = { fg = colors.yellow },
          ["@operator"] = { fg = colors.pink },
          ["@punctuation"] = { fg = colors.pink },
          ["@number"] = { fg = "#71f76c" },
          ["@constant"] = { fg = "#71f76c" },
        }
      end,

      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        telescope = { enabled = true },
        mini = true,
        noice = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin") -- Aplica explicitamente na inicialização
    end,
  },

  -- Configurar LazyVim para usar o BearTheme como padrão
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
