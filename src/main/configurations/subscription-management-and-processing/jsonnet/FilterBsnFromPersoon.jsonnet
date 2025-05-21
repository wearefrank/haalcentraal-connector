local persoon = std.parseJson(payload);

if bsn == "-1" then
  std.objectFilter(persoon, function(key, value) key != "burgerservicenummer")
else
  payload