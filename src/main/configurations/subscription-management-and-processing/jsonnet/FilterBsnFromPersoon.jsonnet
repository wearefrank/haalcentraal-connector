
if bsn == "-1" then
  local persoon = { [k]: payload.personen[0][k] for k in std.objectFields(payload.personen[0]) if k != "burgerservicenummer" };

  {
    personen: [persoon]
  }
else 
  payload