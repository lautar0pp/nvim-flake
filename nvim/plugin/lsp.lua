require("fidget").setup({})
local lspconfig = require('lspconfig')

local language_servers = {
    tsserver = {},
    cssls = {},
    bashls = {},
    gopls = {
        settings = {
            gopls = {
                gofumpt = true,
            },
        },
    },
    html = {},
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim'}
                },
                runtime = {
                    version = 'LuaJIT',
                },
                telemetry = {
                    enable = false,
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
            },
        },
    },
    nil_ls = {
        settings = {
            ['nil'] = {
                formatting = { command = { "alejandra"} },
            },
        },
    },
    pyright = {
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    useLibraryCodeForTypes = true,
                },
            },
        },
    },
}

for server, server_config in pairs(language_servers) do
        local config = { on_attach = on_attach }

        if server_config then
            for k, v in pairs(server_config) do
                config[k] = v
            end
        end

        lspconfig[server].setup(config)
    end

local cmp = require('cmp')

       local cmp_select = { behavior = cmp.SelectBehavior.Select }

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
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })
