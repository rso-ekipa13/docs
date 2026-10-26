# ADR-0003: Lasten ponudnik identitet v .NET (identity-service)

Status: sprejeto (2026-10-26)

## Kontekst
Aplikacija potrebuje prijavo uporabnikov, žetone za API-je (OAuth 2.0), OpenID Connect za odjemalca, organizacije (najemnike), vloge in registracijo naprav. Bonus zahteva 24 priporoča Azure AD (sprejemljiva sta AWS IAM in Keycloak). Predavanje 02-C uvršča identiteto med generične poddomene: »Lastna storitev za avtentikacijo je skoraj vedno napaka.« Pri šifriranju MLS pa potrebujemo storitev za avtentikacijo (RFC 9750), ki veže uporabnika na podpisne ključe njegovih naprav, in ne želimo, da tretji ponudnik identitet izve, kdo uporablja aplikacijo.

## Odločitev
identity-service je lasten ponudnik identitet v .NET 10 s PostgreSQL: OpenIddict za protokol (Authorization Code + PKCE, client credentials, osveževalni žetoni z rotacijo, discovery, JWKS, userinfo), ASP.NET Core Identity za račune in prijavo s ključi passkey (WebAuthn, vgrajeno v .NET 10) namesto gesel, zaklepanje po neuspelih prijavah. Hkrati upravlja organizacije, vloge in naprave ter podpisuje poverilnice naprav za MLS. Prehod API in vse storitve preverjajo žetone prek JWKS. Lastne kriptografije in lastnega protokola ne pišemo.

## Posledice
+ identiteta je del jedra: ista storitev overja uporabnike in jamči za njihove ključe naprav (storitev za avtentikacijo v MLS)
+ trditev `tenant_id` je neposredno v žetonu, kar poenostavi prehod in večnajemniškost
+ brez tretjega ponudnika identitet in brez dodatnega vsebnika (Keycloak, ~0,5–1 GB RAM)
− več varnostno kritične kode v naši odgovornosti → samo preverjeni knjižnici, integracijski testi tokov OIDC, varnostni pregled
− tveganje pri bonus zahtevi 24 (+4): rešitev ni na seznamu priporočenih → na prvih konzultacijah vprašamo asistenta; v poročilu utemeljimo, da gre za sistem IAM (uporabniki, vloge, OAuth 2.0, OIDC, dodeljevanje pravic)
− odstop od nasveta s predavanja moramo v poročilu in na zagovoru utemeljiti (zgoraj)
