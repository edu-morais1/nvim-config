return {
  -- ToggleTerm: terminal integrado com múltiplos layouts
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = true,
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<C-t>",      "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal: Horizontal", mode = { "n", "t" } },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",      desc = "Terminal: Floating" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>",   desc = "Terminal: Vertical" },
      { "<leader>ta", "<cmd>ToggleTermToggleAll<cr>",             desc = "Terminal: Toggle All" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-t>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      float_opts = {
        border = "curved",
        winblend = 3,
      },
      winbar = {
        enabled = true,
        name_formatter = function(term)
          return term.name
        end,
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- Sair do modo terminal facilmente com ESC
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Terminal: Modo Normal" })
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Terminal: Mover Esquerda" })
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Terminal: Mover Abaixo" })
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Terminal: Mover Acima" })
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Terminal: Mover Direita" })
    end,
  },
}
