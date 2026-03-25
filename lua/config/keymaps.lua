-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- -- Integração Neovim <-> Tmux com nvim-tmux-navigation
local ok, nvim_tmux_nav = pcall(require, "nvim-tmux-navigation")
if ok then
  vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, { silent = true })
  vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, { silent = true })
  vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, { silent = true })
  vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, { silent = true })
  vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive, { silent = true })
  vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext, { silent = true })
end
