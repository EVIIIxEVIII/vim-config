return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({
            defaults = {
                vimgrep_arguments = {
                  "rg",
                  "--color=never",
                  "--no-heading",
                  "--with-filename",
                  "--line-number",
                  "--column",
                  "--smart-case",
                  "--ignore",
                  "--glob=**/**",
                  "--glob=vendor/**",  -- Also include vendor directory
                  "--glob=!**/node_modules/**",
                  "--glob=!dev/**",
                  "--glob=!var/**",
                  "--glob=!pub/**",
                  "--glob=!generated/**",
                }
            }
        })

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>pf', function()
            builtin.find_files({
                no_ignore = true,
                file_ignore_patterns = {
                    "dev/.*",
                    "**/node_modules/**",
                    "generated/.*",
                }
            })
        end, {})

        vim.keymap.set('n', '<C-p>', builtin.git_files, {})

        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)

        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ")})
        end)

        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}

