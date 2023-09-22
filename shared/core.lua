rwt = {
    fungsi = {},
    players = {},
    pd = {},
    md = {},
    query = {},
    data = {},
    simpen = {
        duit = {},
        groups = {},
        cache = {},
    },
}

rwt.config = {
    debug = true,
    identifier = 'steam',
    duit = {tunai = 500, bank = 500},
    grupawal = {
        'nganggur'
    }
}

rwt.print = function(...)
    if rwt.config.debug then
        print(...)
    end
end