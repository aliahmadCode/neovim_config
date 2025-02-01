return {
  'jose-elias-alvarez/null-ls.nvim',
  config = function()
    require('null-ls').setup({
      sources = {
        require('null-ls').builtins.formatting.prettier.with({
          extra_args = { "--tab-width", "2" }
        })
      },
    })
  end,
}
