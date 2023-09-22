rwt.fungsi.event = {
    buat = function(nama, ...)
        if rwt.simpen.cache[nama] then return end
        rwt.simpen.cache[nama] = {}
        rwt.simpen.cache[nama].disabled = false
        rwt.simpen.cache[nama].event = ('%s%s%s'):format(nama, 'TheIrham', math.random(111,999))
        RegisterNetEvent(nama, function(...)
            if rwt.simpen.cache[nama].disabled then
                CancelEvent()
                return
            end
            TriggerEvent(rwt.simpen.cache[nama].event, ...)
        end)
        RegisterNetEvent(rwt.simpen.cache[nama].event, ...)
    end,
    disable = function(nama)
        rwt.simpen.cache[nama].disabled = true
    end,
    enable = function(nama)
        rwt.simpen.cache[nama].disabled = false
    end
}