-- duit
local function getDuit(src, tipe)
    if not tipe then
        return rwt.pd[src].duit
    end
    return rwt.pd[src].duit[tipe]
end

local function cekDuit(src, tipe, jumlah)
    if rwt.pd[src].duit[tipe] >= jumlah then
        return true, rwt.pd[src].duit[tipe]
    end
    return false
end

local function addDuit(src, tipe, jumlah)
    local identifier = GetPlayerIdentifierByType(src, rwt.config.identifier)
    rwt.pd[src].duit[tipe] = rwt.pd[src].duit[tipe] + jumlah
    TriggerClientEvent('rwt:client:updatemeta', src, rwt.pd[src])
    rwt.simpen.duit[identifier] = rwt.pd[src].duit
end

local function removeDuit(src, tipe, jumlah)
    local identifier = GetPlayerIdentifierByType(src, rwt.config.identifier)
    local bisa, duit = cekDuit(src, tipe, jumlah)
    if bisa then
        rwt.pd[src].duit[tipe] = rwt.pd[src].duit[tipe] - jumlah
        TriggerClientEvent('rwt:client:updatemeta', src, rwt.pd[src])
        rwt.simpen.duit[identifier] = rwt.pd[src].duit
    end
end

-- metadata
local function setMeta(src, key, value)
    rwt.md[src][key] = value
end

local function getMeta(src, key)
    return rwt.md[src][key]
end

local function deleteMeta(src, key)
    rwt.md[src][key] = nil
end

local function setMetaInside(src, key1, key2, value)
    if not rwt.md[src][key1][key2] then rwt.md[src][key1][key2] = {} end
    rwt.md[src][key1][key2] = value
end

local function getMetaInside(src, key1, key2)
    return rwt.md[src][key1][key2]
end

local function deleteMetaInside(src, key1, key2)
    rwt.md[src][key1][key2] = nil
end

-- playerdata
local function setPlayerdata(src, key, value)
    rwt.pd[src][key] = value
end

local function getPlayerdata(src, key)
    return rwt.pd[src][key]
end

local function deletePlayerdata(src, key)
    rwt.pd[src][key] = nil
end

local function setPlayerdataInside(src, key1, key2, value)
    if not rwt.pd[src][key1][key2] then rwt.pd[src][key1][key2] = {} end
    rwt.pd[src][key1][key2] = value
end

local function getPlayerdataInside(src, key1, key2)
    return rwt.pd[src][key1][key2]
end

local function deletePlayerdataInside(src, key1, key2)
    rwt.pd[src][key1][key2] = nil
end

local function simpenSemuaPlayer()
    if #rwt.simpen.duit >= 1 then -- cek cache server yang mau di save playerdata duitnnya
        for identifier, data in pairs(rwt.simpen.duit) do
            exports.oxmysql:executeSync(rwt.query.updateDuitPlayer, {json.encode(data), identifier})
        end
    end
    if #rwt.simpen.groups >= 1 then
        for identifier, data in pairs(rwt.simpen.groups) do
            exports.oxmysql:executeSync(rwt.query.apdetPlayer, {'groups', json.encode(data), identifier})
        end
    end
    rwt.print('Saved ', #rwt.simpen.duit + #rwt.simpen.groups..' data from server cache!')
    rwt.simpen.duit = {}
    rwt.simpen.group = {}
end

local fungsiPlayer = {
    duit = {
        getDuit = getDuit,
        cekDuit = cekDuit,
        addDuit = addDuit,
        removeDuit = removeDuit,
    },
    meta = {
        setMeta = setMeta,
        getMeta = getMeta,
        deleteMeta = deleteMeta,
        setMetaInside = setMetaInside,
        getMetaInside = getMetaInside,
        deleteMetaInside = deleteMetaInside,
    },
    player = {
        setPlayerdata = setPlayerdata,
        getPlayerdata = getPlayerdata,
        deletePlayerdata = deletePlayerdata,
        setPlayerdataInside = setPlayerdataInside,
        getPlayerdataInside = getPlayerdataInside,
        deletePlayerdataInside = deletePlayerdataInside,
    },
}

rwt.fungsi.warga = function(src)
    local retval = {
        data = rwt.pd[src],
        fungsi = fungsiPlayer
    }
    return retval
end

rwt.fungsi.save = function(src)
    if not src then
        for id, data in pairs(rwt.pd) do
            if data then
                exports.oxmysql:executeSync(rwt.query.updatePlayerData, {json.encode(data), rwt.pd[id].identifier})
            end
        end
        rwt.print('Berhasil Tersimpan semua data player')
        return true
    else
        exports.oxmysql:executeSync(rwt.query.updatePlayerData, {json.encode(rwt.pd[src]), rwt.pd[src].identifier})
        rwt.print('Tersimpan Data Player: '..rwt.pd[src].identifier)
        return true
    end
end

rwt.fungsi.cekPlate = function(pl)
    local count = exports.oxmysql:executeSync('SELECT COUNT(*) FROM kendaraan WHERE plate = ?', {pl})
    return count[1]['COUNT(*)'] > 0
end

function GeneratePlate()
    local plate
    repeat
        plate = GenerateRandomPlate('11AAA111')
    until not rwt.fungsi.cekPlate(plate)
    return plate:upper()
end

rwt.fungsi.addKendaraan = function(src, spawn, plate)
    if not rwt.data.kendaraan[spawn] then return end
    if not plate then
        plate = GeneratePlate()
    end

    local pd = rwt.fungsi.warga(src)
    local identifier = pd.data.identifier
    exports.oxmysql:executeSync(rwt.query.insertKendaraan, {spawn, identifier, plate})
    return true
end

SetInterval(rwt.fungsi.save, 1000 * 60 * 5)
SetInterval(simpenSemuaPlayer, 1000 * 60 * 10)