# Architecture

## Couches
src/
  engine/        moteur pur TS
    roles/       un fichier par role (donnees + hooks)
    events.ts    types d'evenements (journal)
    state.ts     etat derive
    reducer.ts   (state, event) -> state
    night.ts     sequence d'appel, resolution des morts
    day.ts       deroulement du jour, cascades
    victory.ts   conditions de victoire
    undo.ts      annulation par troncature du journal
  storage/       idb (parties, carnet), prefs
  ui/            composants Svelte, ecrans
  i18n/          fr.json (+ futurs fichiers)
  cards/         chargement et cache des images

## Principes
- Event sourcing : le journal est la verite. L'etat = fold(journal).
- Undo = retrait du dernier evenement, recalcul.
- Reprise = rechargement du journal depuis IndexedDB.
- Un "step" du moteur produit une instruction pour l'UI
  (ex : { type: "CALL_ROLE", role, targets, prompt }).
- L'UI ne contient aucune regle ; elle affiche l'instruction et renvoie
  la reponse du narrateur sous forme d'evenement.

## Cartes
- public/cards/<role-id>.<ext>
- Script de build genere public/cards/manifest.json avec hash par fichier.
- Au lancement : fetch manifest, compare au cache (Cache API), telecharge
  seulement les images nouvelles ou modifiees.

## PWA
- Service worker : precache app shell, cache runtime des cartes.
- Necessite HTTPS (Tailscale serve).

## Docker
- Stage 1 : node:20-alpine, npm ci, npm run build
- Stage 2 : nginx:alpine, copie dist/, nginx.conf (SPA fallback, cache
  long pour assets hashes, no-cache pour index.html et manifest cartes)
- Volume bind : /mnt/user/appdata/narrateur-lg/cards -> /usr/share/nginx/html/cards
- Port : 8088:80