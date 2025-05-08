local sortObjectRecursive(obj) =
  if std.type(obj) == "object" then
    // Recursively sort object fields without creating extra arrays
    {
      [key]: sortObjectRecursive(obj[key]) 
      for key in std.sort(std.objectFields(obj))  // Sort the keys
    }
  else if std.type(obj) == "array" then
    // Apply sorting recursively to arrays without using extra arrays
    [sortObjectRecursive(x) for x in obj]  // Iterate through array elements
  else
    obj;  // Return the value for primitive types

// Assuming payload.personen[0] is the object you want to process
local input = if std.type(payload) == "string" then
  std.parseJson(payload)
else
  payload;

// Apply the sorting recursively to the input
local result = sortObjectRecursive(input);

result
