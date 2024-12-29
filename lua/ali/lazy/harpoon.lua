return {
    "ThePrimeagen/harpoon",
    config = function ()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")
        local term = require("harpoon.term")
        local keymap = vim.keymap.set

        keymap("n", "<S-w>", ui.toggle_quick_menu);
        keymap("n", "<S-n>", mark.add_file);
        keymap("n", "<Tab>", ui.nav_next);
        keymap("n", "<S-Tab>", ui.nav_prev);
    end
}
