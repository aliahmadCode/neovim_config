return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
  config = function()
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_browser = "chromium"
  end,
  ft = { "markdown" },
}
