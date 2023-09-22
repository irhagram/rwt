local function InOutGarage(plate, bool)
    local state = 0
    if type(bool) == 'boolean' then state = bool and 1 or 0 end
    if type(bool) == 'number' then state = bool end
    exports.oxmysql:executeSync(rwt.query.InOutGarage, {state, plate})
end

lib.callback.register('rwt:garasi', function(source)
    local src = source
    local pd = rwt.fungsi.warga(src)
    local kendaraan = exports.oxmysql:executeSync(rwt.query.getAllKendaraanByIdentifier, {pd.data.identifier})
    if kendaraan[1] then
        return kendaraan
    end
    return false
end)

lib.callback.register('rwt:spawnkendaraan', function(source, model, coords, plate, warp)
    SpawnVehicle(source, model, coords, warp)
    InOutGarage(plate, false)
    return true
end)

lib.callback.register('rwt:masukkendaraan', function(source, meta)
    local src = source
    local ped = GetPlayerPed(src)
    local veh = GetVehiclePedIsIn(ped, false)
    local plate = GetVehicleNumberPlateText(veh)
    md = json.encode(meta)
    exports.oxmysql:executeSync(rwt.query.updateMetaKendaraan, {md, plate})
    InOutGarage(plate, true)
    return true
end)