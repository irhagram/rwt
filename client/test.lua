rwt.fungsi.event.buat('rwt', function(data)
    print('testing rwt', data.test)
end)

RegisterCommand('rwt', function()
    TriggerEvent('rwt', {test = 1}) -- trigger ini masuk
    rwt.fungsi.event.disable('rwt')
    TriggerEvent('rwt', {test = 2}) -- trigger ini gaakan masuk
    rwt.fungsi.event.enable('rwt')
    TriggerEvent('rwt', {test = 3}) -- trigger ini bakal masuk lg
end)