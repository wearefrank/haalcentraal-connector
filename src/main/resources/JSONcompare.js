// const fs = require('fs');
let isDifferent = false;

function compareJSONFiles(oldJSON, newJSON) {
    // Read remote JSON file
    const remoteJSON = JSON.parse(oldJSON);

    // Read local JSON file
    const localJSON = JSON.parse(newJSON);

    // Compare the JSON objects and return the result as a boolean
    const json = JSON.stringify(deepCompareJSONObjects(remoteJSON, localJSON),null,2)
    return isDifferent ?  json : true;
}

function deepCompareJSONObjects(oldJson, newJson) {
    // Check if both arguments are objects
    if (typeof oldJson !== 'object' || typeof newJson !== 'object') {
        if(oldJson === newJson) {
            return oldJson
        }
        isDifferent = true
        return newJson
    }

    // Iterate over all keys in the newJson
    for (let key in newJson) {
        // Skip comparing the "type" field
        if (key === 'type') {
            continue;
        }
        
        // If the key is not present in the oldJson, add it
        if (!(key in oldJson)) {
            oldJson[key] = newJson[key];
            isDifferent = true;
        } else {
            // If the key is present in both oldJson and newJson, recursively update the value if it's different
            oldJson[key] = deepCompareJSONObjects(oldJson[key], newJson[key]);
        }
    }

    return oldJson;
}

// function deepCompareJSONObjects(obj1, obj2) {
//     // Check if both arguments are objects
//     if (typeof obj1 !== 'object' || typeof obj2 !== 'object') {
//         return obj1 === obj2;
//     }

//     // Check if obj2 is a subset of obj1
//     for (let key in obj2) {
//         if (key === 'type') {
//             continue; // Skip comparing this key
//         }
//         if (!deepCompareJSONObjects(obj1[key], obj2[key])) {
//             return false; // Recursively compare nested objects
//         }
//     }

//     return true;
// }

// Usage
// const remoteFilePath = 'test.json';
// const localFilePath = 'testCompare.json';
// const result = compareJSONFiles(remoteFilePath, localFilePath);
// console.log(result);
