{
    personen: 
        if std.isString(payload) then
            std.parseJson(std.parseJson(payload).rowset[0].DATA).personen
        else
            std.parseJson(payload.rowset[0].DATA).personen
}