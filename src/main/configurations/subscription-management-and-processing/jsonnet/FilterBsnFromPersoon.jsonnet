
if bsn == "-1" then
  local persoon = std.prune(
    payload.personen[0] {
      burgerservicenummer: null
    }
  );

  {
    personen: [persoon]
  }
else 
  payload