# Compétence Recherche Emploi

## Statut de diffusion
Projet explique sur Site Ma Methode: la fiche publique peut presenter son utilite, ses fonctions, son avancement et ses liens disponibles.

## Liens vers l'application
- Application: non detecte
- GitHub: [https://github.com/RYJITS/competance_recherche_emploie-showcase](https://github.com/RYJITS/competance_recherche_emploie-showcase)

## Avancement du projet
- Etat du projet: reserve a l'usage interne.
- Fonctionnement: non teste faute d'informations suffisantes.
- Securite: reserve au prive.
- Ma Methode: fiche explicative visible.
- Publication externe: interne.

## A quoi sert le projet
Ce projet est un pipeline automatisé et structuré pour la recherche d'emploi, conçu pour des profils hybrides combinant expérience industrielle (supply chain, planification, ERP/SAP, KPI) et une transition vers l'IA appliquée, l'automatisation et le développement d'outils métiers. Il permet de centraliser, filtrer, valider et suivre les candidatures de manière systématique, en réduisant les tâches manuelles répétitives.

## Fonctionnement de l'application ou du projet
Le projet fonctionne comme un pipeline en 7 étapes : 1. **Inbox** : Collecte manuelle ou automatisée d'offres brutes (liens, notes). 2. **Sources Offres** : Vérification et catalogage des sources d'offres. 3. **Runs** : Exécution de recherches automatisées horodatées selon des critères configurés. 4. **Validations Telegram** : Interface de validation manuelle des offres via un bot Telegram. 5. **Dossiers Valides** : Constitution de dossiers de candidature pour les offres retenues. 6. **Postulations** : Envoi des candidatures et suivi des relances. 7. **Archives** : Archivage des offres non retenues ou obsolètes. Les données sensibles (offres brutes, validations, postulations) sont ignorées par Git et stockées localement.

## Comment le projet a ete construit
Le projet a été conçu comme un pipeline modulaire et versionné pour garantir une traçabilité des évolutions. La structure en dossiers est pensée pour séparer clairement les données brutes, les processus automatisés, les validations manuelles et les archives. Les choix de conception incluent : - **Versioning** : Utilisation de Git pour versionner la structure, les configurations et la documentation, avec des règles strictes pour les commits et les tags. - **Modularité** : Séparation des étapes du pipeline en dossiers distincts pour faciliter la maintenance et les mises à jour. - **Automatisation** : Intégration de services locaux (ex: SearXNG pour la recherche) et d'interfaces de validation (ex: Telegram) pour réduire l'intervention manuelle. - **Traçabilité** : Système de mémoire projet pour enregistrer les décisions clés et les apprentissages.

## Installation et utilisation
### Installation
Cette vitrine contient la documentation generale partageable du projet. Pour la consulter localement:

```powershell
git clone https://github.com/RYJITS/competance_recherche_emploie-showcase.git
cd competance_recherche_emploie-showcase
Get-Content README.md
```

Les configurations serveur, adresses reseau et sauvegardes operationnelles restent privees.

### Utilisation
Consulter le README, la fiche projet, le guide d'installation general et le changelog. Le deploiement reel necessite les fichiers prives qui ne font pas partie de cette vitrine.

## Fonctions disponibles dans l'application
- Collecte automatisée d'offres depuis des sources configurables
- Filtrage et scoring des offres selon des critères métiers (ex: mots-clés, technologies, localisation)
- Validation manuelle des offres via une interface dédiée (ex: Telegram)
- Génération de dossiers de candidature structurés (CV, lettre de motivation, liens pertinents)
- Suivi des candidatures envoyées avec relances automatiques
- Archivage des offres non retenues ou obsolètes
- Versioning de la structure du projet et des configurations
- Traçabilité des décisions via un système de mémoire projet

## Outils, IA et moteurs en arriere-plan
- Git (versioning et traçabilité)
- SearXNG (moteur de recherche local pour la collecte d'offres)
- Telegram (interface de validation manuelle des offres)
- Python (scripts d'automatisation et de traitement)
- Docker (si des services locaux comme SearXNG sont utilisés)

## Automatisations integrees
- Collecte automatisée d'offres depuis des sources configurées
- Exécution de recherches horodatées pour peupler le pipeline
- Déplacement automatique des offres validées vers les dossiers de candidature
- Relances automatiques pour le suivi des candidatures

## Captures d'ecran
![Capture 1 - Competance Recherche emploie](docs/captures/competance-recherche-emploie-2026-08-30_02-37-02-desktop.png)

![Capture 2 - Competance Recherche emploie](docs/captures/competance-recherche-emploie-2026-08-30_02-37-02-mobile.png)

## Mises a jour
- Initialisation du projet avec une structure de pipeline en 7 étapes
- Ajout d'un système de versioning pour la structure et les configurations
- Documentation des conventions de commit et de versioning (MAJOR/MINOR/PATCH)
- Intégration d'un système de mémoire projet pour tracer les décisions clés
- Configuration des services locaux (ex: SearXNG) pour la collecte automatisée d'offres
- Initialisation du projet avec une structure de pipeline en 7 étapes (inbox → archives)
