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
