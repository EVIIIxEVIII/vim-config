return {
    {
        "L3MON4D3/LuaSnip",

        version = "v2.*",
        build = "make install_jsregexp",

        dependencies = { "rafamadriz/friendly-snippets" },

        config = function()
            local ls = require("luasnip")
            require("luasnip.loaders.from_lua").load({
                paths = vim.fn.stdpath("config") .. "/lua/config/snippets"
            })

            vim.keymap.set({ "n", "i" }, "cf<Tab>", function()
                local ft = vim.bo.filetype
                for _, snip in ipairs(ls.get_snippets(ft) or {}) do
                    if snip.trigger == "cf" then
                        ls.snip_expand(snip)
                        return
                    end
                end
                vim.notify(("LuaSnip: no 'cf' snippet for filetype %s"):format(ft), vim.log.levels.WARN)
            end, { silent = true, desc = "Insert CF snippet" })
        end,
    }
}

