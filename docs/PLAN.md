Plan de réalisation
Phase 1 : Infrastructure (avant tout code)

Sur Unraid : créer /mnt/user/appdata/narrateur-lg/cards/.
Tailscale : vérifier que le plugin Tailscale Unraid est actif et que HTTPS est activé dans la console admin Tailscale (MagicDNS + HTTPS Certificates).
Dépôt Git sur ton PC, dossier narrateur-loup-garous/ avec CLAUDE.md et docs/.
Dockerfile + nginx.conf + docker-compose.yml (jalon 0 ci-dessous).
Déploiement : docker compose up -d sur Unraid, puis exposer en HTTPS :tailscale serve --bg --https=443 http://localhost:8088
(adapter si Tailscale tourne en conteneur ; sinon utiliser tailscale serve de l'hôte).
Test : ouvrir https://<machine>.<tailnet>.ts.net depuis le téléphone, vérifier l'installation PWA.

Phase 2 : Jalons de code (docs/PLAN.md)

Jalon 0 : squelette. Vite + Svelte + TS, PWA minimale, i18n, thème auto, Dockerfile, compose, nginx, page "Hello". Déploiement validé sur Unraid via Tailscale.
Jalon 1 : données et cartes. Définition de tous les rôles (id, nom, camp, description). Script de manifest des images, cache client, affichage d'une fiche rôle.
Jalon 2 : joueurs. Carnet de joueurs (IndexedDB), liste ordonnée, cercle visuel avec glisser-déposer, 8 à 28.
Jalon 3 : composition et attribution. Compteurs de rôles, validation, tirage aléatoire, attribution manuelle, option Voleur.
Jalon 4 : moteur (cœur). Journal d'événements, reducer, undo, persistance et reprise. Tests unitaires exhaustifs. Aucune UI métier encore.
Jalon 5 : nuit 1. Séquence d'appel dynamique, rôles de préparation (Voleur, Cupidon, Comédien, Enfant Sauvage, Chien-Loup, Deux Sœurs, Trois Frères, Juge Bègue), UI d'appel.
Jalon 6 : nuits courantes. Voyante, Renard, Corbeau, Salvateur, Loups, Grand-Méchant-Loup, Loup-Garou Blanc, Infect Père, Sorcière, Joueur de Flûte. Résolution des conflits, état des pouvoirs.
Jalon 7 : réveil et jour. Annonces (Montreur d'Ours), ordre configurable, morts, cascades (Chasseur, amoureux, Maire, Chevalier), vote, égalité, Bouc Émissaire, Idiot, Servante, Ange, Juge Bègue, élection du Maire.
Jalon 8 : victoire et historique. Détection de victoire, journal lisible, effacement à la nouvelle partie.
Jalon 9 : mode "montrer le rôle" et fiches règles. Contrôle d'accès par le moteur, bouton "+".
Jalon 10 : menu burger et options. Appel des morts par ruse, ordre du réveil.
Jalon 11 : finitions. Adaptatif tablette (paysage), accessibilité, tests sur appareils réels, doc de déploiement.

Règle de passage de jalon
Chaque jalon : tests verts, docs/ à jour, déploiement Unraid validé, commit.