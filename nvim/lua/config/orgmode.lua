local orgmode = require("orgmode")

orgmode.setup_ts_grammar()

orgmode.setup({
    org_agenda_files = { "~/Documents/Orgmode/*" },
    org_default_notes_file = "~/Documents/Orgmode/refile.org",
})
