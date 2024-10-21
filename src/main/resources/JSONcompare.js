function compareJsonObjects(storedJsonString, newJsonString) {
    let hasDifferences = false; 

    // If storedJsonString is null or undefined, return the new JSON
    if (!storedJsonString) {
        return formatJsonOutput({
            hasDifferences: true,
            updatedJson: newJsonString
        });
    }

    // Parse both JSON strings into objects
    const storedJson = JSON.parse(storedJsonString);
    const newJson = JSON.parse(newJsonString);

    // Perform deep comparison
    const comparedResult = deepCompareJsonObjects(storedJson, newJson, () => hasDifferences = true);

    return formatJsonOutput({
        hasDifferences: hasDifferences,
        updatedJson: hasDifferences ? comparedResult : null
    });
}

function deepCompareJsonObjects(storedJson, newJson, setDifferenceFlag) {
    // Create a new object to hold the merged results
    let comparisonResult = Array.isArray(storedJson) ? [] : {};

    // If both values are not objects, compare them directly
    if (typeof storedJson !== 'object' || typeof newJson !== 'object') {
        if (storedJson === newJson) {
            return storedJson;
        }
        setDifferenceFlag(); // Mark as different when values don't match
        return newJson;
    }

    // Compare keys in newJson and update comparisonResult
    for (let key in newJson) {
        // Skip comparing the "type" field (specific to your use case)
        if (key === 'type') {
            continue;
        }

        // If key doesn't exist in storedJson, add it
        if (!(key in storedJson)) {
            comparisonResult[key] = newJson[key];
            setDifferenceFlag(); // Mark as different since it's a new key
        } else {
            // If key exists in both, recursively compare values
            comparisonResult[key] = deepCompareJsonObjects(storedJson[key], newJson[key], setDifferenceFlag);
        }
    }

    // Retain keys from storedJson that are not present in newJson
    for (let key in storedJson) {
        if (!(key in newJson)) {
            comparisonResult[key] = storedJson[key];
        }
    }

    return comparisonResult;
}

// Helper function for formatting the JSON output with indentation
function formatJsonOutput(jsonObject) {
    return JSON.stringify(jsonObject, null, 2);
}
