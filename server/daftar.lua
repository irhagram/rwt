RegisterNetEvent('rwt:server:daftar', function(data)
    local src = source
    rwt.pd[src].namadepan = data[1]
    rwt.pd[src].namabelakang = data[2]
    rwt.pd[src].tinggi = data[3]
    local timestamp = math.floor(data[4] / 1000)
    local date = os.date('%Y-%m-%d %H:%M:%S', timestamp)
    rwt.pd[src].lahir = date
    rwt.pd[src].kelamin = data[5]
    rwt.pd[src].model = (data[5] == 'cowok') and 'mp_m_freemode_01' or 'mp_f_freemode_01'

    exports.oxmysql:executeSync(rwt.query.updatePlayerData, {json.encode(rwt.pd[src]), rwt.pd[src].identifier})
end)