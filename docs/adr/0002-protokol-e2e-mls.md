# ADR-0002: Šifriranje od konca do konca s protokolom MLS

Status: predlagano (2026-10-26) — dokončno po preizkusu v tednu W1

## Kontekst
Vsebine ne sme videti nihče razen udeležencev, tudi strežnik ne. Podpreti moramo pogovore 1:1, skupine in več naprav. Odjemalec je Flutter (Android in splet). Kandidati: MLS (RFC 9420) prek OpenMLS, Signal Protocol prek `libsignal_protocol_dart`, Olm/Megolm prek `flutter_vodozemac`.

## Odločitev
MLS z OpenMLS (Dart paket `openmls`, MIT) za vmesnikom `CryptoEngine` v aplikaciji. Zaledje je od protokola neodvisno: keys-service hrani neprozorne pakete ključev, message-service neprozorne ovojnice z epoho. Rezerva je Signal Protocol, ki zahteva spremembe v aplikaciji in manjše prilagoditve keys- in message-service (brez urejanja epoh).

## Posledice
+ standard IETF za skupine (posodobitev v O(log n)), naprejšnja tajnost in varnost po kompromitaciji; 1:1 je skupina dveh, naprava je član
+ arhitektura MLS (RFC 9750) se preslika v naše storitve: storitev za avtentikacijo = identity-service (veže uporabnika na ključe naprav), dostavna storitev = message-service + keys-service (urejanje sporočil in imenik paketov ključev)
− paket `openmls` za Dart je mlad (en vzdrževalec); OpenMLS je imel v letu 2026 več varnostnih obvestil → pripnemo različico ≥ 0.9.2 ali gradimo iz izvorne kode
− message-service mora urejati spremembe skupine (ena sprememba na epoho, pogojni zapis v ScyllaDB)
− shranjevanje ključev v brskalniku je šibkejše kot Android Keystore (omejitev, ki jo opišemo v poročilu)
