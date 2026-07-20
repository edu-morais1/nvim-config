-- lua/plugins/tools/cmp.lua
return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- Load custom Lua snippets from lua/snippets/
    require("luasnip.loaders.from_lua").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
    })

    -- Disable cmp in Copilot suggestion context so Tab is never stolen
    local function is_copilot_visible()
      local ok, suggestion = pcall(require, "copilot.suggestion")
      return ok and suggestion.is_visible()
    end

    opts.window = {
      completion = cmp.config.window.bordered({
        border = "rounded",
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      }),
      documentation = cmp.config.window.bordered({
        border = "rounded",
      }),
    }

    opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
      ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
      ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        -- Copilot tem prioridade zero aqui: Tab nunca chama o Copilot
        if is_copilot_visible() then
          -- ignora a sugestão do Copilot e continua o fluxo normal
        end
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    })

    opts.sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip", priority = 750 },
      { name = "path", priority = 500 },
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

    opts.experimental = { ghost_text = false } -- desativa ghost_text do cmp para não conflitar com Copilot inline

    return opts
  end,
}
