return {
  "zbirenbaum/copilot.lua",
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<M-l>",       -- Alt+L: aceita sugestão inteira
        accept_word = "<M-w>",  -- Alt+W: aceita uma palavra
        accept_line = "<M-j>",  -- Alt+J: aceita uma linha
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
    panel = { enabled = false },
  },
  keys = {
    {
      "<leader>at",
      function()
        if require("copilot.client").is_disabled() then
          require("copilot.command").enable()
        else
          require("copilot.command").disable()
        end
      end,
      desc = "Toggle Copilot",
    },
  },
}
