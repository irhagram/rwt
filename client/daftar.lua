rwt.fungsi.daftar = function()
    local input = lib.inputDialog('Pendaftaran Karakter', {
        {type = 'input', label = 'Nama Depan', description = 'Nama Depan kamu', required = true, min = 2, max = 30},
        {type = 'input', label = 'Nama Belakang', description = 'Nama Belakang kamu', required = true, min = 2, max = 30},
        {type = 'number', label = 'Tinggi Badan', description = 'Tinggi Badan kamu', icon = 'hashtag', required = true},
        {type = 'date', label = 'Tanggal Lahir', icon = {'far', 'calendar'}, default = true, format = "DD/MM/YYYY", required = true},
        {type = 'select', label = 'Kelamin',required = true, options = {
            {label = 'Pria', value = 'cowok'},
            {label = 'Wanita', value = 'cewek'}
        }}
    }, {
        allowCancel = false
    })
    -- print(json.encode(input))

    return input
end