return {
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPre",
    opts = {
        render = "virtual",

        virtual_symbol = "",
        virtual_symbol_position = "inline",
        virtual_symbol_prefix = "",
        virtual_symbol_suffix = " ",

        enable_hex = true,
        enable_short_hex = true,
        enable_rgb = true,
        enable_hsl = true,
        enable_var_usage = true,
        enable_named_colors = true,
        enable_tailwind = false,

        custom_colors = {},
    },
}
