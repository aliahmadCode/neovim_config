return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },

  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("diffview").setup()
      -- Mappings for viewing diffs
      vim.api.nvim_set_keymap("n", "<leader>gd", ":DiffviewOpen<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>gq", ":DiffviewClose<CR>", { noremap = true, silent = true })
    end,
  },
}
