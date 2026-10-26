# ADR-0003: Keycloak za upravljanje identitet, identity-service za račune

Status: predlagano (2026-10-26)

## Kontekst
Ekipa želi avtentikacijo v .NET. Zahteva 24 pričakuje sistem IAM (priporočen Azure AD, sprejemljiv Keycloak), OAuth 2.0 in OIDC. Predavanje 02-C uvršča identiteto med generične poddomene: »Lastna storitev za avtentikacijo je skoraj vedno napaka.«

## Odločitev
Keycloak (realm `sepet`, organizacije kot najemniki, MFA) izdaja žetone in hrani poverilnice. Storitev identity-service v .NET je avtentikacijsko zaledje aplikacije: vključitev novega računa, organizacije, naprave in vloge; s Keycloakom govori prek Admin REST API z odjemalcem *client credentials*. Prehod API in vsaka storitev preverjata žetone JWT prek JWKS.

## Posledice
+ zahteva 24 izpolnjena s priznanim sistemom; brez lastne hrambe gesel
+ organizacije v Keycloaku so osnova večnajemniškosti (zahteva 10)
− dodaten vsebnik (Keycloak, ~0,5–1 GB RAM) in njegova baza
− trditev `organization` je seznam; za prehod potrebujemo skalarno trditev `tenant_id` (lasten preslikovalnik)
