return {
    "folke/todo-comments.nvim",
    dependencies = {
        "plenary"
    },
    config = function()
        require("todo-comments").setup {}
    end
}
