function compareJsonObjects(storedJsonString, newJsonString) {
    if (!storedJsonString) return true; // Any new data means a difference

    const newJson = JSON.parse(newJsonString || '{}');
    if (!newJson["personen"]) return false; // No relevant data, so no difference

    let hasDifferences = false;

    deepCompareJsonObjects(
        JSON.parse(storedJsonString),
        newJson,
        () => (hasDifferences = true)
    );

    return hasDifferences;
}

function deepCompareJsonObjects(storedJson, newJson, setDifferenceFlag) {
    if (typeof storedJson !== 'object' || typeof newJson !== 'object') {
        if (storedJson !== newJson) setDifferenceFlag();
        return;
    }

    for (const key of Object.keys(newJson)) {
        if (!(key in storedJson)) setDifferenceFlag();
        deepCompareJsonObjects(storedJson[key], newJson[key], setDifferenceFlag);
    }

    for (const key of Object.keys(storedJson)) {
        if (!(key in newJson)) setDifferenceFlag();
    }
}
