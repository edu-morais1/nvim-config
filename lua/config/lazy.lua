local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
vim.opt.termguicolors = true
vim.env.ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY")
require("lazy").setup({
  spec = {
    -- LazyVim e seus plugins base
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- Extras de linguagem (LSP, Treesitter, formatters automáticos)
    { import = "lazyvim.plugins.extras.lang.python" }, -- Python: pyright + ruff
    { import = "lazyvim.plugins.extras.lang.java" }, -- Java: jdtls

    -- Extras de ferramentas
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" }, -- Highlight de cores no código

    -- Seus plugins customizados
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  checker = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
