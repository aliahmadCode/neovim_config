return
{
  "codota/tabnine-nvim",
  build = "./dl_binaries.sh",
  event = "InsertEnter",
  config = function()
    require('tabnine').setup({
      accept_keymap = "<Tab>",
      debounce_ms = 800,
    })
  end
}
