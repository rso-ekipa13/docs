# ADR-0005: NATS JetStream kot posrednik dogodkov

Status: predlagano (2026-10-26)

## Kontekst
Dejstva (sporočilo shranjeno, član odstranjen, naprava preklicana) zanimajo več storitev. Potrebujemo trajnost, ponovno branje in dostavo vsaj enkrat. Gruča ima zaradi kvote Azure for Students le nekaj vCPU.

## Odločitev
NATS JetStream z enim tokom na omejeni kontekst (IDENTITY, KEYS, CONVERSATIONS, MESSAGES, MEDIA), trajnimi porabniki na storitev in idempotentnimi obdelovalci. Dogodki so CloudEvents 1.0, kanali opisani v AsyncAPI 3.0. NATS KV hrani prisotnost s časom poteka. conversation-service objavlja integracijske dogodke iz svoje shrambe dogodkov (shramba je transakcijski predal), message-service po zapisu v ScyllaDB (dogodek je le namig; vir resnice je dnevnik, naprave sinhronizirajo s kazalcem).

## Posledice
+ majhna poraba virov, en sistem za dogodke, zahteva–odgovor in KV
+ KEDA lahko skalira porabnike po zaostanku (skaler NATS JetStream)
− manj razširjen kot Kafka; brez registra shem → združljivost zagotavljamo z verzijo v tipu dogodka in strpnim bralcem
