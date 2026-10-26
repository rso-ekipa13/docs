# ADR-0004: ScyllaDB za sporočila, PostgreSQL za ostale storitve

Status: sprejeto (2026-10-26)

## Kontekst
Sporočila so dnevnik, v katerega veliko pišemo, beremo pa ga po pogovoru in času; izginjajoča sporočila potrebujejo samodejni izbris. Ostali podatki (računi, ključi, članstvo, priponke) so relacijski in potrebujejo transakcije (npr. atomarni prevzem paketa ključev, optimistična sočasnost v shrambi dogodkov).

## Odločitev
message-service uporablja ScyllaDB (particija = najemnik, pogovor, časovno vedro; razvrščanje po timeuuid; TTL; pogojni zapis za epohe MLS). Vse ostale storitve s stanjem uporabljajo vsaka svojo bazo PostgreSQL (CloudNativePG); conversation-service v njej hrani dogodke in projekcije (Marten).

## Posledice
+ linearno skaliranje pisanja in vgrajen TTL za sporočila (Discord: prehod s 177 vozlišč Cassandra na 72 ScyllaDB, p99 branja 15 ms)
+ transakcije in RLS v PostgreSQL za večnajemniškost
− dve tehnologiji baz za upravljanje; ScyllaDB je od leta 2025 *source-available* (brezplačno do 50 vCPU in 10 TB), kar opišemo v poročilu
− pogojni zapisi (LWT) so dražji → uporabimo jih samo za spremembe skupine, ne za vsako sporočilo
