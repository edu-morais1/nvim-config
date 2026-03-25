return {
  -- Harpoon2: marcar arquivos frequentes e alternar rapidamente
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    },
    keys = function()
      local harpoon = require("harpoon")
      return {
        { "<leader>ha", function() harpoon:list():add() end,     desc = "Harpoon: Add File" },
        { "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon: Menu" },
        { "<leader>1",  function() harpoon:list():select(1) end, desc = "Harpoon: File 1" },
        { "<leader>2",  function() harpoon:list():select(2) end, desc = "Harpoon: File 2" },
        { "<leader>3",  function() harpoon:list():select(3) end, desc = "Harpoon: File 3" },
        { "<leader>4",  function() harpoon:list():select(4) end, desc = "Harpoon: File 4" },
        { "[h",         function() harpoon:list():prev() end,    desc = "Harpoon: Prev" },
        { "]h",         function() harpoon:list():next() end,    desc = "Harpoon: Next" },
      }
    end,
  },

  -- Oil.nvim: navegar em arquivos como se fosse um buffer de texto
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = false, -- Mantém o neo-tree do LazyVim
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true, -- Mostra arquivos ocultos (.env, .gitignore, etc)
      },
      float = {
        padding = 2,
        max_width = 90,
        max_height = 30,
      },
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },
    },
    keys = {
      { "-",          "<cmd>Oil<cr>",              desc = "Oil: Abrir pasta atual" },
      { "<leader>-",  "<cmd>Oil --float<cr>",      desc = "Oil: Floating" },
    },
  },

  -- FZF-Lua: busca ultra-rápida (melhor que telescope em projetos grandes)
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      winopts = {
        height = 0.85,
        width = 0.90,
        row = 0.35,
        col = 0.50,
        preview = {
          layout = "vertical",
          vertical = "down:45%",
        },
      },
      fzf_opts = {
        ["--layout"] = "reverse",
      },
    },
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<cr>",           desc = "FZF: Arquivos" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>",       desc = "FZF: Live Grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>",         desc = "FZF: Buffers" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>",        desc = "FZF: Recentes" },
      { "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "FZF: Symbols" },
      { "<leader>fw", "<cmd>FzfLua grep_cword<cr>",      desc = "FZF: Palavra atual" },
    },
  },
}
