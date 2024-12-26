return {
    "echasnovski/mini.starter",
     config = function()
      require('mini.starter').setup({
        -- Your custom configuration here
        header = [[

        ▄▄▄       ██▓     ██▓
       ▒████▄    ▓██▒    ▓██▒
       ▒██  ▀█▄  ▒██░    ▒██▒          Z
       ░██▄▄▄▄██ ▒██░    ░██░       Z
        ▓█   ▓██▒░██████▒░██░    z
        ▒▒   ▓▒█░░ ▒░▓  ░░▓    z
         ▒   ▒▒ ░░ ░ ▒  ░ ▒ ░
         ░   ▒     ░ ░    ▒ ░
             ░  ░    ░  ░ ░


        ]],
        items = {
          { name = 'New File', action = ':ene' },
          { name = 'Open File', action = ':e ' },
          { name = 'Settings', action = ':e ~/.config/nvim/init.lua' },
        },
      })
    end
 }
