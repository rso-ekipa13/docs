# ADR-0001: Razrez na sedem mikrostoritev

Status: predlagano (2026-10-26)

## Kontekst
Ekipa treh mora zgraditi vsaj šest mikrostoritev (dve na člana) in uporabniški vmesnik. Domena ima jasno ločene jezike: identiteta (računi, organizacije, naprave), ključi (javni ključi, paketi ključev), pogovori (članstvo, vloge), sporočila (šifrirane ovojnice, vrstni red), dostava v živo (povezave, prisotnost), priponke (bloki, kvote) in obveščanje (žetoni, ponudnik potisnih obvestil).

## Odločitev
Sedem storitev po omejenih kontekstih: identity, keys, conversation, message, realtime, media, notification; brezstrežniške funkcije za priponke kot ločen repozitorij. Razdružitelji: različna obremenitev (realtime po povezavah, message po pisanjih), varnost (keys ločeno od identity), odpornost (zunanji ponudnik FCM izoliran v notification), nestanovitnost (pravila priponk). Združevalcev, ki bi zahtevali skupne transakcije, ni: odvisnosti so prek gRPC (potrebujem odgovor) ali dogodkov (dejstvo).

## Posledice
+ vsaka storitev ima svojo bazo, svojega lastnika in neodvisno namestitev
+ izpad notification ali media ne ustavi besedilnih sporočil
− več infrastrukture (7 chartov, 7 cevovodov) → skupna predloga storitve in ponovno uporabni poteki
− končna konsistentnost lokalnih kopij članstva → kratkotrajen predpomnilnik in gRPC kot vir resnice pri pošiljanju
