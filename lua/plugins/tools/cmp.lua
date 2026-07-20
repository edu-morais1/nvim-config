-- nvim-cmp configuration for Java/Spring Boot
-- Location: ~/.config/nvim/lua/config/cmp_config.lua

local ok, cmp = pcall(require, "cmp")
if not ok then
  vim.notify("nvim-cmp failed to load", vim.log.levels.ERROR)
  return
end

local ok_luasnip, luasnip = pcall(require, "luasnip")
if not ok_luasnip then
  vim.notify("luasnip failed to load", vim.log.levels.WARN)
  luasnip = nil
end

local ok_lspkind, lspkind = pcall(require, "lspkind")
if not ok_lspkind then
  vim.notify("lspkind failed to load", vim.log.levels.WARN)
  lspkind = nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      if luasnip then
        luasnip.lsp_expand(args.body)
      end
    end,
  },

  window = {
    completion = cmp.config.window.bordered({
      border = "rounded",
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
    }),
    documentation = cmp.config.window.bordered({
      border = "rounded",
    }),
  },

  mapping = {
    ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip and luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip and luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  sources = cmp.config.sources({
    {
      name = "nvim_lsp",
      priority = 1000,
      option = {
        markdown_oxide = {
          keyword_pattern = [[\(\k\| \|\/\|#\).*]],
        },
      },
    },
    {
      name = "luasnip",
      priority = 750,
    },
    {
      name = "path",
      priority = 500,
    },
  }, {
    {
      name = "buffer",
      priority = 250,
    },
  }),

  formatting = {
    format = lspkind and lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 50,
      symbol_map = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "󰒓",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰌗",
        Interface = "󰌗",
        Module = "󰏗",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "󰌦",
        Keyword = "󰌋",
        Snippet = "󰄴",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "󰌦",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "󰕘",
        Operator = "󰆕",
        TypeParameter = "󰊄",
        Copilot = "",
      },
    }) or function() end,
  },

  -- Experimental features for better completion
  experimental = {
    ghost_text = true,
  },
})

-- Use buffer source for / and ? (if you enabled `native_menu`, this won't work anymore)
if cmp then
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore)
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end
