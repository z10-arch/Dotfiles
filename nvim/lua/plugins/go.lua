-- Minimal Go customization
return {
  -- Just ensure these tools are installed
  {
    "mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "gopls",
        "goimports",
        "gofumpt",
        "golangci-lint",
        "delve",
      })
    end,
  },
}
