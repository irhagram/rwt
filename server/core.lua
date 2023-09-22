rwt.config.awal = {}
for i=1, #rwt.config.grupawal do
    rwt.config.awal[#rwt.config.awal+1] = rwt.data.groups[rwt.config.grupawal[i]]
end

rwt.fungsi.buat = function(src)
    local identifier = GetPlayerIdentifierByType(src, rwt.config.identifier)
    local gp = exports.oxmysql:executeSync(rwt.query.dapetPlayer, {identifier})
    if not gp[1] then
        rwt.pd[src] = {
            identifier = identifier,
            namadepan = 'Ruwet',
            namabelakang = 'FW',
            groups = rwt.config.awal,
            duit = rwt.config.duit,
            model = 'mp_m_freemode_01',
            lokasi = vec4(-414.31, 1162.50, 325.84, 339.32)
        }
        exports.oxmysql:executeSync(rwt.query.buatPlayer, {GetPlayerName(src), identifier, json.encode(rwt.config.awal), json.encode(rwt.pd[src])})
        TriggerClientEvent('rwt:client:spawn', src, rwt.pd[src])
        return rwt.pd[src]
    else
        rwt.pd[src] = json.decode(gp[1].playerdata)
        TriggerClientEvent('rwt:client:spawn', src, rwt.pd[src])
        return rwt.pd[src]
    end
end

AddEventHandler('playerJoining', function()
    local src = source
    local identifier = GetPlayerIdentifierByType(src, rwt.config.identifier)
    rwt.print('warga masuk kota', src, identifier)

    rwt.fungsi.buat(src)
end)

---@param reason string
AddEventHandler('playerDropped', function(reason)
    local src = source --[[@as string]]
    local ped = GetPlayerPed(src)
    local x,y,z = table.unpack(GetEntityCoords(ped))
    local w = GetEntityHeading(ped)
    rwt.pd[src].lokasi = vec4(x,y,z,w)
    rwt.fungsi.save(src)
    TriggerClientEvent('rwt:keluar', src, rwt.pd[src])
    TriggerEvent('rwt:keluar', rwt.pd[src])
    rwt.print('warga keluar kota', src, rwt.pd[src].identifier)
    rwt.pd[src] = nil
end)

if rwt.config.debug then
    RegisterNetEvent('rwt:joined', function()
        local src = source
        local identifier = GetPlayerIdentifierByType(src, rwt.config.identifier)
        -- print('disini')
    
        rwt.fungsi.buat(src)
    end)
end
