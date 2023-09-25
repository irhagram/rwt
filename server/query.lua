rwt.query = {
    buatPlayer = 'insert into warga(nama, identifier, groups, playerdata) values(?,?,?,?)',
    dapetPlayer = 'select * from warga where identifier = ? limit 1',
    apdetPlayer = 'update warga set ? = ? where identifier = ?',
    updateDuitPlayer = 'update warga set playerdata = json_set(playerdata, "$.duit", ?) where identifier = ?',
    updatePlayerData = 'update warga set playerdata = ? where identifier = ?',
    getAllKendaraanByIdentifier = 'select * from kendaraan where owner = ?',
    insertKendaraan = 'insert into kendaraan(spawn, owner, plate) values(?,?,?)',
    updateMetaKendaraan = 'update kendaraan set meta = ? where plate = ?',
    InOutGarage = 'update kendaraan set state = ? where plate = ?',
    GetVehProps = 'select modifan from kendaraan where plate = ?',
    SetVehProps = 'update kendaraan set modifan = ? where plate = ?',
}