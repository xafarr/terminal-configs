local illuminate = require("illuminate")

illuminate.configure({
    delay = 2000,
    filetypes_denylist = {
        "TelescopePrompt",
        "dirvish",
        "fugitive",
    },
})
