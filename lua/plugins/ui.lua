return {
  -- Indent Blankline: linhas de indentação visuais
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPre",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
        highlight = { "Function", "Label" },
      },
      exclude = {
        filetypes = {
          "help", "dashboard", "neo-tree", "Trouble",
          "lazy", "mason", "notify", "toggleterm",
        },
      },
    },
  },

  -- Colorizer: mostra as cores dos hex codes no editor
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        css = true,
        mode = "background", -- "background" | "foreground" | "virtualtext"
        virtualtext = "■",
      },
    },
  },

  -- Twilight: escurece o código fora do bloco atual (foco)
  {
    "folke/twilight.nvim",
    lazy = true,
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    keys = {
      { "<leader>ut", "<cmd>Twilight<cr>", desc = "Toggle Twilight (foco)" },
    },
    opts = {
      dimming = {
        alpha = 0.25,
        color = { "Normal", "#ffffff" },
      },
      context = 15,
      treesitter = true,
    },
  },

  -- Zen Mode: modo de foco total, esconde tudo ao redor
  {
    "folke/zen-mode.nvim",
    lazy = true,
    cmd = "ZenMode",
    keys = {
      { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
    },
    opts = {
      window = {
        backdrop = 0.93,
        width = 120,
        height = 1,
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
        },
      },
      plugins = {
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = false },
      },
    },
  },

  -- Smooth scroll: rolagem suave
  {
    "karb94/neoscroll.nvim",
    event = "BufReadPre",
    opts = {
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
      hide_cursor = true,
      stop_eof = true,
      duration_multiplier = 0.8,
      easing = "sine",
    },
  },
}
