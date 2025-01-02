return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        require("conform").setup({
            formatters_by_ft = {
            }
        })
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "jdtls", -- Java language server
                "clangd", -- C/C++ language server
                "asm_lsp",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0

                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "LuaJIT" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each", "love" },
                                },
                                workspace = {
                                   checkThirdParty = false,
                                    telemetry = { enable = false },                            }
                            },
                        }
                    }
                end,
                -- java configuration
                jdtls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.jdtls.setup {
                        capabilities = capabilities,
                        settings = {
                            java = {
                                diagnostics = {
                                    enable = true,
                                    severity = "warning",  -- customize severity level as needed
                                },
                            },
                        },
                    }
                end,
                -- C/C++ configuration
                clangd = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.clangd.setup {
                        capabilities = capabilities,
                    }
                end,
                asm_lsp = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.asm_lsp.setup({
                        capabilities = capabilities,
                        filetypes = { "asm", "s", "S" },
                        root_dir = function(fname)
                            return lspconfig.util.find_git_ancestor(fname) or
                                lspconfig.util.path.dirname(fname)
                        end,
                        cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/asm-lsp") }
                    })
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local luasnip = require'luasnip'
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, {'i', 's'}), -- Tab to jump to next argument
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {'i', 's'}), -- Shift+Tab to jump to previous argument
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                    { name = 'buffer' },
                })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            virtual_text = {
                severity = { min = vim.diagnostic.severity.WARN }, -- Ignore spelling (INFO level)
            },
            underline = false,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
