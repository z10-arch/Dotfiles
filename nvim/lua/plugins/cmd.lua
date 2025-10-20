-- ~/.config/nvim/lua/custom/plugins/cmp.lua
return {
  -- override nvim-cmp options used by LazyVim
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip_ok, luasnip = pcall(require, "luasnip")

      opts.mappings = cmp.mapping.preset.insert({
        -- Tab accepts first item (like VSCode)
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          elseif luasnip_ok and luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Shift-Tab to go back
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip_ok and luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Enter also confirms (optional: keep select = true to accept top item)
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        -- manual completion trigger
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
      })

      -- ensure we have lsp source (for go)
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer" },
      })

      return opts
    end,
  },
}
