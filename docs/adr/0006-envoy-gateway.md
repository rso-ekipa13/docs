# ADR-0006: Envoy Gateway kot prehod API

Status: predlagano (2026-10-26)

## Kontekst
Bonus zahteva 23 pričakuje eno vstopno točko z usmerjanjem L7, zaključevanjem TLS, avtentikacijo in avtorizacijo ter vsaj eno dodatno funkcijo upravljanja API-jev. ingress-nginx je upokojen (arhiviran marca 2026). Kong OSS nima preverjanja JWT prek JWKS (OIDC je v plačljivi različici).

## Odločitev
Envoy Gateway (Kubernetes Gateway API): `Gateway` s HTTPS (cert-manager, Let's Encrypt), `HTTPRoute` za vsako storitev in WebSocket, `SecurityPolicy` s preverjanjem JWT prek JWKS Keycloaka, avtorizacijo po trditvah in prenosom trditev v glave (`X-User-Id`, `X-Tenant-Id`), `BackendTrafficPolicy` z lokalnim omejevanjem hitrosti. AKS ostane na Kubernetes 1.36, ki ga Envoy Gateway 1.9 podpira.

## Posledice
+ standardni API (Gateway API) namesto opomb, specifičnih za ponudnika
+ en javni naslov IP za vsa okolja (usmerjanje po imenu gostitelja)
− globalno omejevanje hitrosti bi zahtevalo Redis → uporabimo lokalno (na repliko) in to omejitev opišemo
