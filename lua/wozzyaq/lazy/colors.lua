return {
    -- vscode.nvim configuration
    {
        "Mofiqul/vscode.nvim",
        config = function()
            require('vscode').setup({
                transparent = true,
                italic_comments = true,
                color_overrides = {
                    vscLineNumber = '#FFFFFF',
                }
            })
        end
    },

    -- nightfox.nvim configuration
    {
        "EdenEast/nightfox.nvim",
        config = function()
            -- No additional setup needed unless you have specific settings for nightfox
        end
    },

    {
        "projekt0n/github-nvim-theme",
        config = function()
            require('github-theme').setup({
            })
        end
    },

}

