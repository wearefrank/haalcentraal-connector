# Accepted edge cases

*Small document to note accepted edge cases*

## Edge cases

### Valid 200 characters in the `voornamen` field failure

In src/main/configurations/brp-personen-bevragen-soap/xsl/mappingStufToJson.xslt, 
the `voornamen` field is mapped to a JSON field with a maximum length of 200 characters. 
However, the XSLT function `hc:zoekwaarde` is used to append an asterisk (`*`) to the value if it is not exact and meets certain conditions. 
This can lead to a situation where the resulting value exceeds 200 characters, causing validation failures.
