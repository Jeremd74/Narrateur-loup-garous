# Narrateur Loup-Garous

PWA mobile pour le narrateur de Loups-Garous de Thiercelieux : Le Pacte.
Le narrateur ne joue pas. Les joueurs ne voient l'app que pour consulter
une carte (mode "montrer le rôle") ou lire les règles d'un rôle.

## Stack
- Svelte + Vite + TypeScript
- vite-plugin-pwa (service worker, hors ligne)
- IndexedDB via idb (parties, carnet de joueurs), localStorage (préférences)
- Vitest pour les tests du moteur
- Docker : build multi-étapes, nginx:alpine, port hôte 8088
- Accès via Tailscale (HTTPS par `tailscale serve`), pas de reverse proxy

## Conventions
- Pas d'emoji nulle part.
- Code, noms et commits en anglais ; textes UI en français via i18n.
- Réponses concises.
- src/engine : TS pur, aucune importation Svelte/DOM, 100% testable.
- Rôles décrits par données (src/engine/roles/*.ts) avec hooks, pas de
  `if (role === ...)` éparpillés.
- Toute action du narrateur est un événement immuable dans un journal
  (event sourcing) : permet undo, historique, reprise de partie.
- L'état de partie se reconstruit en rejouant le journal.

## Contraintes fonctionnelles clés
- 8 à 28 joueurs.
- Pas de comptes, pas d'export/import. Données locales à l'appareil.
- Carnet de joueurs en local uniquement.
- Photos des cartes servies par le conteneur (dossier public/cards),
  mises en cache côté client, rechargées seulement si le hash change.
- Portrait seul sur smartphone ; portrait et paysage sur tablette.
- Thème clair/sombre suivant l'appareil (prefers-color-scheme).
- Pas de son, pas de vibration.
- Historique de la partie en cours, effacé au démarrage d'une nouvelle.
- Menu burger : options de partie (appel des morts, ordre du réveil).

## Documents
- docs/RULES.md : règles officielles (source de vérité)
- docs/ROLES.md : rôles, ordre d'appel, points à vérifier
- docs/ARCHITECTURE.md : architecture technique
- docs/UX.md : écrans et parcours
- docs/PLAN.md : jalons