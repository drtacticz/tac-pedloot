local Translations = {
    system = {
        ['enable'] = "Looting Now Enabled!",
        ['disable'] = "Looting Now Disabled!",
        ['start'] = "Started",
        ['stop'] = "Stopped",
    },
    target = {
        ['label'] = "Search Body",
    },
    command = {
        ["start_stop"] = "%{state} Searching Pockets",
        ["on_or_off"] = "On/Off",
    }
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})