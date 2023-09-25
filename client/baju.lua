-- Contoh Penggunaan
rwt.fungsi.event.mass({
    {
        nama = 'event1',
        func = function(_, rw)
            print(rw.test)
        end
    },
    {
        nama = 'event2',
        func = function(_, rw)
            print(rw.test)
        end
    }
})

rwt.fungsi.event.buat('event3', function(_, rw)
    print(rw.test)
end)

RegisterCommand('event1', function()
    TriggerEvent('event1', {test = '11'})
end)

RegisterCommand('event2', function()
    TriggerEvent('event2', {test = '22'})
end)

RegisterCommand('event3', function()
    -- TriggerEvent('event3', {test = '33'})
    TriggerServerEvent('rwt:savemodif')
end)