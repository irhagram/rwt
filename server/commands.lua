lib.addCommand('saveply', {
    help = 'Save Player',
    restricted = 'group.admin'
}, function(source, args)
    local src = source
    local ped = GetPlayerPed(src)
    local x,y,z = table.unpack(GetEntityCoords(ped))
    local w = GetEntityHeading(ped)
    rwt.pd[src].lokasi = vec4(x,y,z,w)
    local save = rwt.fungsi.save(src)
    rwt.print(save and 'Tersimpan!')
end)

lib.addCommand('saveall', {
    help = 'Save All Players',
    restricted = 'group.admin'
}, function(source, args)
    local save = rwt.fungsi.save()
    rwt.print(save and 'Tersimpan!')
end)



lib.addCommand('givecar', {
    help = 'Give Kendaraan ke Garasi',
    params = {
        {name = 'id', type = 'playerId', help = 'buat siapa?'},
        {name = 'spawn', type = 'string', help = 'kode spawnnya, pastiin ada di shared/kendaraan.lua'},
    },  
    restricted = 'group.admin'
}, function(source,args )
    rwt.fungsi.addKendaraan(args.id, args.spawn)
end)