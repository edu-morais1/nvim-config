-- lua/plugins/tools/cmp.lua
return {
  "hrsh7th/nvim-cmp",
  -- priority garante que este spec rode depois dos defaults do LazyVim
  priority = 100,
  opts = function(_, opts)
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- Load custom Lua snippets from lua/snippets/
    require("luasnip.loaders.from_lua").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
    })

    opts.window = {
      completion = cmp.config.window.bordered({
        border = "rounded",
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      }),
      documentation = cmp.config.window.bordered({
        border = "rounded",
      }),
    }

    -- Sobrescreve diretamente as keys que nos interessam no mapping já existente
    -- ao invés de tbl_extend, que não garante precedência sobre o LazyVim
    opts.mapping = opts.mapping or {}

    opts.mapping["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" })
    opts.mapping["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" })
    opts.mapping["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" })
    opts.mapping["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" })
    opts.mapping["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" })
    opts.mapping["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() })
    opts.mapping["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })

    opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
        if entry then
          -- Sempre confirma o item selecionado (snippets expandem automaticamente via luasnip source)
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
        else
          cmp.select_next_item()
        end
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" })

    opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" })

    opts.sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip",  priority = 750 },
      { name = "path",     priority = 500 },
    }, {
      { name = "buffer", priority = 250 },
    })

    opts.formatting = {
      format = lspkind.cmp_format({
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
      }),
    }

    opts.experimental = { ghost_text = false }

    return opts
  end,
}
