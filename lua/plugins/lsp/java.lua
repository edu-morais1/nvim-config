-- Java file template generator
-- Automatically creates class structure when opening a new Java file

return {
  {
    "nvim-lua/plenary.nvim", -- Helper plugin for path operations
    lazy = true,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    init = function()
      require("config.java_template")
    end,
  },
}
