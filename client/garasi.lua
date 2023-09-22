local function ambilKendaraan(data)
    local meta = json.decode(data.meta)
    local spawnkendaraan = lib.callback.await('rwt:spawnkendaraan', false, data.model, GetEntityCoords(cache.ped), data.plate, true)
    if spawnkendaraan then
        SetTimeout(500, function()
            SetVehicleNumberPlateText(cache.vehicle, data.plate)
            if meta.engine then
                SetVehicleEngineHealth(cache.vehicle, meta.engine)
                SetVehicleBodyHealth(cache.vehicle, meta.body)
                SetVehicleFuelLevel(cache.vehicle, meta.fuel)
            end
        end)
    end
end

local function simpanKendaraan(data)
    local engine = GetVehicleEngineHealth(cache.vehicle)
    local body = GetVehicleBodyHealth(cache.vehicle)
    local fuel = GetVehicleFuelLevel(cache.vehicle)
    local meta = {
        engine = engine,
        body = body,
        fuel = fuel,
    }
    local masuk = lib.callback.await('rwt:masukkendaraan', false, meta)
    if masuk then
        local veh = cache.vehicle
        TaskLeaveVehicle(cache.ped, veh, 1)
        SetTimeout(1600, function()
            DeleteEntity(veh)
        end)
    end
end

local function aksesGarasi()
    local opsi = {}
    local getKendaraan = lib.callback.await('rwt:garasi', false)
    if not getKendaraan then
        lib.notify({
            title = rwt.data.garasi[rwt.simpen.cache.garasi].label,
            description = 'Tidak ada kendaraan di garasi ini!',
            type = 'error'
        })
    else
        for i=1, #getKendaraan do
            opsi[#opsi+1] = {
                title = rwt.data.kendaraan[getKendaraan[i].spawn].label,
                description = getKendaraan[i].plate,
                onSelect = ambilKendaraan,
                args = {
                    model = getKendaraan[i].spawn,
                    meta = getKendaraan[i].meta,
                    plate = getKendaraan[i].plate,
                },
                disabled = getKendaraan[i].state ~= 1
            }
        end
        local ctx = {
            id = 'garasi',
            title = rwt.data.garasi[rwt.simpen.cache.garasi].label,
            options = opsi
        }
    
        lib.registerContext(ctx)
        lib.showContext(ctx.id)
    end
end

for k,v in pairs(rwt.data.garasi) do
    exports.rwt:CreatePolyZone(k, v.poly, {
        minZ = v.z - 10.0,
        maxZ = v.z + 10.0
    })
    RegisterNetEvent('rwt:poly:masuk', function(nama)
        if nama == k then
            -- print('masuk garasi')
            lib.addRadialItem({
                id = 'garasi',
                label = 'Akses Garasi',
                onSelect = function()
                    if cache.vehicle then
                        simpanKendaraan()
                    else
                        aksesGarasi()
                    end
                end,
                icon = 'warehouse'
            })
            rwt.simpen.cache.garasi = k
        end
    end)
    RegisterNetEvent('rwt:poly:keluar', function(nama)
        if nama == k then
            print('keluar garasi')
            lib.removeRadialItem('garasi')
            rwt.simpen.cache.garasi = nil
        end
    end)
end