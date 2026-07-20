return {
  -- LazyGit: TUI completo pra Git dentro do Neovim
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- GitBlame: mostra quem escreveu cada linha
  {
    "f-person/git-blame.nvim",
    event = "BufReadPre",
    opts = {
      enabled = true,
      message_template = "  <author> • <date> • <summary>",
      date_format = "%d/%m/%Y",
      virtual_text_column = 80,
      highlight_group = "Comment",
    },
    keys = {
      { "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Toggle Git Blame" },
    },
  },

  -- Diffview: visualização de diffs e histórico de arquivos
  {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff View" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    },
  },
}
