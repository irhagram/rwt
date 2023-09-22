local function setPlayerModel(model)

    if type(model) == "string" then model = joaat(model) end

    if IsModelInCdimage(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do Wait(0) end

        SetPlayerModel(cache.playerId, model)
        Wait(150)
        SetModelAsNoLongerNeeded(model)

        SetPedDefaultComponentVariation(cache.ped)
        SetPedHeadBlendData(cache.ped, 0, 0, 0, 0, 0, 0, 0, 0, 0, false)
        return cache.ped
    end

    return cache.playerId
end

RegisterNetEvent('rwt:client:spawn', function(data)
    rwt.pd = data

    TriggerEvent('rwt:masuk', data)
    TriggerServerEvent('rwt:masuk', data)
    
    if data.namadepan == 'Ruwet' and data.namabelakang == 'FW' then
        local daftar = rwt.fungsi.daftar()
        if daftar then
            TriggerServerEvent('rwt:server:daftar', daftar)
            setPlayerModel((daftar[5] == 'cowok') and 'mp_m_freemode_01' or 'mp_f_freemode_01')
        end
    else
        setPlayerModel(data.model)
    end

    SetEntityCoords(cache.ped, data.lokasi.x, data.lokasi.y, data.lokasi.z-1)
    SetEntityHeading(cache.ped, data.lokasi.w)
end)

if rwt.config.debug then
    TriggerServerEvent('rwt:joined')
end