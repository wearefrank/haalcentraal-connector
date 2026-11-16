# Afwijkingen authorizedApplicationsMap.xml ten opzichte van de StUF-BG scope

Bestand: `src/main/configurations/brp-personen-bevragen-soap/xsl/authorizedApplicationsMap.xml`
Vergeleken met: `bg0310_ent_vraagAntwoord.xsd` (`NPS-vraagScope`, `NPSNPSHUW-vraagScope`, `NPSNPSKND-vraagScope`, `NPSNPSOUD-vraagScope`, `NPS-gerelateerdeVraagScope`)

**Waarom de structuur ertoe doet:** `mappingJsonToStuf.xslt` zoekt per element in het request de entry met dezelfde naam op dezelfde plek in de map (`$map/*[name()=local-name()]`). Een entry op de verkeerde plek wordt nooit gevonden. Een veld zonder entry is vrij en gaat naar elke applicatie.

## 1. Entries die onder `gerelateerde` horen maar direct onder de relatie staan
Dit zijn eigenschappen van de gerelateerde persoon (NPS). Ze worden nu nooit toegepast.

| Relatie | Verkeerd geplaatste entries | Correct op relatieniveau |
|---|---|---|
| `inp.heeftAlsEchtgenootPartner` | `geslachtsnaamPartner`, `adellijkeTitelPredikaat`, `geslachtsaanduiding`, `verblijfsadres/aoa.identificatie`, `sub.correspondentieAdres`, `inp.burgerlijkeStaat` | `soortVerbintenis`, `datumSluiting`, `datumOntbinding`, `redenOntbinding` (en `gerelateerde/inp.bsn` is al rechtgezet) |
| `inp.heeftAlsKinderen` | alle 13 entries (`inp.bsn` t/m `inp.indicatieGeheim`) | – |
| `inp.heeftAlsOuders` | alles behalve `datumIngangFamilierechtelijkeBetrekking` (13 entries, waaronder `inp.verblijftIn`) | `datumIngangFamilierechtelijkeBetrekking` |
| `inp.heeftAlsNationaliteit` | – (klopt) | `gerelateerde/code`, `gerelateerde/omschrijving` |

## 2. Verkeerde elementnaam
- `aanduidingBijzonderNederlanderschap` heet in de XSD **`inp.aanduidingBijzonderNederlanderschap`**. In `mappingJsonToStuf.xslt` (rond regel 491) staat dezelfde verkeerde naam. Het veld wordt daardoor nooit in de response gezet, ook niet voor geautoriseerde apps.

## 3. Waarschijnlijk verkeerd veld bedoeld
- Partner `geslachtsnaamPartner`: onder `gerelateerde` betekent dat de partnernaam van de partner, dus meestal de naam van de aanvrager zelf. Waarschijnlijk is `gerelateerde/geslachtsnaam` bedoeld. Dat moet iemand met de autorisatie-specificatie bevestigen.

## 4. Autorisatie op elementen met kinderen wordt genegeerd
Het template `BG:object//*[*]` in `mappingJsonToStuf.xslt` kijkt niet naar `authorizedApplications`. Een attribuut op een element met kinderen werkt dus alleen als het request dat element zonder kinderen stuurt. Dit geldt voor:
- `sub.correspondentieAdres` (GWS), op het hoogste niveau en bij partner, kinderen en ouders
- `inp.verblijftIn/gerelateerde` (GWS)
- `inp.heeftAlsOuders/inp.verblijftIn` (GWS)

Om dit alleen via de auth map op te lossen moet het attribuut naar de kindelementen die de mapping vult, bijvoorbeeld `sub.correspondentieAdres/aoa.identificatie` en bij `verblijftIn` de velden onder `adresAanduidingGrp`.

## Wat wel klopt
- Alle andere entries op het hoogste niveau bestaan in `NPS-vraagScope` op de juiste plek, inclusief `verblijfsadres/...`, `aoa.woonplaatsWaarinGelegen/...` en `inp.verblijftIn/gerelateerde/adresAanduidingGrp/...`.
- `GetPartnerIfNeededAndAllowed.xslt` gebruikt `inp.burgerlijkeStaat` en `inp.heeftAlsEchtgenootPartner/redenOntbinding`. Die staan allebei goed.

## Bijvangst (geen auth map)
- In de partner-mapping van `mappingJsonToStuf.xslt` staat `inp.indicatieGeheim` buiten `gerelateerde` (rond regel 796). In de XSD hoort het binnen `gerelateerde`, en de relatie `NPSNPSHUW` zelf heeft dat veld niet. Voor een partner wordt `inp.indicatieGeheim` daardoor nooit gevuld. Bij kinderen en ouders staat het wel goed.

