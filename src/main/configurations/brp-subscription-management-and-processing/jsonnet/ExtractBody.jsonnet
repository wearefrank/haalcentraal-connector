{
  personen: 
    if std.isString(payload) then
      std.parseJson(payload).personen
    else
      payload.personen
}