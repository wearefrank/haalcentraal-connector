# Accepted edge cases

*Small document to note accepted edge cases*

## Edge cases

### Valid 200 characters in the `voornamen` field failure

In src/main/configurations/brp-personen-bevragen-soap/xsl/mappingStufToJson.xslt, 
the `voornamen` field is mapped to a JSON field with a maximum length of 200 characters. 
However, the XSLT function `hc:zoekwaarde` is used to append an asterisk (`*`) to the value if it is not exact and meets certain conditions. 
This can lead to a situation where the resulting value exceeds 200 characters, causing validation failures.

### More than 20 dissolved partners: `redenOntbinding` is `waardeOnbekend`

`RaadpleegMetBurgerservicenummer` accepts at most 20 BSNs per request. To determine `redenOntbinding` (and `inp.burgerlijkeStaat`)
the connector looks up all dissolved partners in one call (`GetPartnerIfNeededAndAllowed.xslt`, SOAP adapter and callback sender).
If a person has more than 20 distinct dissolved partners, the latest dissolved partner is always included (needed for `burgerlijkeStaat`)
and the remaining slots are filled in order of appearance. The other relations are not looked up and get `redenOntbinding` `waardeOnbekend`.
This is accepted because it is extremely rare.
