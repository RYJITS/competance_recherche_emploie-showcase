# Compétence Recherche Emploi

## Presentation

Compétence Recherche Emploi est presente ici sous une forme publique limitee, sans secrets ni donnees privees.

## Demarrage rapide

### Pre-requis

- Git installe localement.

### Installer et lancer

```powershell
git clone https://github.com/RYJITS/competance_recherche_emploie-showcase.git
cd competance_recherche_emploie-showcase
```

## Installation locale

Pour installer le projet localement :
1. Cloner le dépôt Git : `git clone <url_du_depot>`.
2. Installer les dépendances locales si nécessaire (ex: services comme SearXNG pour la recherche).
3. Configurer les fichiers de configuration dans le dossier `config/` selon les besoins (critères de recherche, scoring, sources).
4. Initialiser les dossiers vides selon la structure définie (ex: `00_inbox/`, `01_sources_offres/`).

Prérequis : Git, Python (si des scripts Python sont utilisés), et les outils nécessaires pour les services locaux (ex: Docker pour SearXNG).

### Pre-requis
- Creer un fichier `.env` local a partir de `.env.example` si des variables sont necessaires.

### Commandes
```powershell
git clone https://github.com/RYJITS/competance_recherche_emploie-showcase.git
cd competance_recherche_emploie-showcase
```

## Lancement

Aucune commande de lancement n'est fournie dans les fichiers publies.

## Utilisation

Après installation, l'utilisation du projet suit ces étapes :
1. **Collecte** : Ajouter des offres brutes dans `00_inbox/` ou configurer des sources automatiques.
2. **Exécution** : Lancer les recherches automatisées (ex: via des scripts ou services configurés) pour peupler `02_runs/`.
3. **Validation** : Utiliser l'interface Telegram pour valider les offres dans `03_validations_telegram/`.
4. **Dossiers** : Les offres validées sont automatiquement déplacées dans `04_dossiers_valides/` pour constitution des dossiers de candidature.
5. **Postulation** : Envoyer les candidatures via les scripts ou outils configurés, et suivre les relances dans `05_postulations/`.
6. **Archivage** : Archiver les offres non retenues ou obsolètes dans `06_archives/`.

Les commandes utiles incluent : `git status`, `git add`, `git commit`, et `git tag` pour versionner les changements.

## Concept

Pipeline structuré pour automatiser la recherche et la candidature à des offres d'emploi ciblant un profil hybride (industrie, supply chain, IA et automatisation).

Automatiser et organiser la recherche d'emploi en identifiant des postes alignés sur un profil professionnel hybride combinant expérience industrielle, supply chain, planification, ERP/SAP, KPI, et une transition vers l'IA appliquée, l'automatisation et le développement d'outils métiers. Le projet vise à réduire le temps de traitement manuel tout en garantissant une traçabilité des candidatures.

Public vise: Utilisateurs internes ou équipes RH/recrutement souhaitant structurer leur processus de recherche d'emploi ou de recrutement pour des profils techniques hybrides. Principalement destiné aux équipes techniques ou aux individus en reconversion vers l'IA et l'automatisation.


## Fonctionnement de l'application

Le projet fonctionne comme un pipeline en 7 étapes :
1. **Inbox** : Collecte manuelle ou automatisée d'offres brutes (liens, notes).
2. **Sources Offres** : Vérification et catalogage des sources d'offres.
3. **Runs** : Exécution de recherches automatisées horodatées selon des critères configurés.
4. **Validations Telegram** : Interface de validation manuelle des offres via un bot Telegram.
5. **Dossiers Valides** : Constitution de dossiers de candidature pour les offres retenues.
6. **Postulations** : Envoi des candidatures et suivi des relances.
7. **Archives** : Archivage des offres non retenues ou obsolètes.

Les données sensibles (offres brutes, validations, postulations) sont ignorées par Git et stockées localement.

## Fonctions de l'application

- Collecte automatisée d'offres d'emploi depuis des sources configurables
- Filtrage et scoring des offres selon des critères métiers prédéfinis
- Validation manuelle des offres via une interface dédiée (ex: Telegram)
- Génération de dossiers de candidature structurés
- Suivi des candidatures envoyées et relances automatiques
- Archivage des offres non retenues ou obsolètes
- Versioning de la structure du projet et des configurations

## Actualisations et evolution

- Initialisation du projet avec une structure de pipeline en 7 étapes (inbox → archives)
- Ajout d'un système de versioning pour la structure et les configurations
- Documentation des conventions de commit et de versioning (MAJOR/MINOR/PATCH)
- Intégration d'un système de mémoire projet pour tracer les décisions clés
- Initialisation du projet avec une structure de pipeline en 7 étapes
- Configuration des services locaux (ex: SearXNG) pour la collecte automatisée d'offres

## Comment le projet a ete reflechi et construit

Le projet a été conçu comme un pipeline modulaire et versionné pour garantir une traçabilité des évolutions. La structure en dossiers est pensée pour séparer clairement les données brutes, les processus automatisés, les validations manuelles et les archives. Les choix de conception incluent :
- **Versioning** : Utilisation de Git pour versionner la structure, les configurations et la documentation, avec des règles strictes pour les commits et les tags.
- **Modularité** : Séparation des étapes du pipeline en dossiers distincts pour faciliter la maintenance et les mises à jour.
- **Automatisation** : Intégration de services locaux (ex: SearXNG pour la recherche) et d'interfaces de validation (ex: Telegram) pour réduire l'intervention manuelle.
- **Traçabilité** : Système de mémoire projet pour enregistrer les décisions clés et les apprentissages.

### Outils, IA et moteurs utilises

- Git (versioning et traçabilité)
- SearXNG (moteur de recherche local pour la collecte d'offres)
- Telegram (interface de validation manuelle des offres)
- Python (scripts d'automatisation et de traitement)
- Docker (si des services locaux comme SearXNG sont utilisés)
- Pipeline modulaire en 7 étapes
- Versioning Git avec conventions de commit et de tagging
- Automatisation via scripts Python
- Validation manuelle via interface Telegram
- Stockage local des données sensibles (hors Git)
- Système de mémoire projet pour tracer les décisions

### Options techniques detectees

- Options techniques a documenter.

### Stack et dependances principales

- HTML statique
- Pipeline modulaire en 7 étapes
- Versioning Git avec conventions de commit et de tagging
- Automatisation via scripts Python
- Validation manuelle via interface Telegram
- Stockage local des données sensibles (hors Git)
- Système de mémoire projet pour tracer les décisions

### Scripts disponibles

- Aucun script detecte.

### Dependances applicatives

- Aucune dependance applicative detectee.

### Dependances de developpement

- Aucune dependance de developpement detectee.

## Automatisations et comportements internes

- Collecte automatisée d'offres depuis des sources configurées
- Exécution de recherches horodatées pour peupler le pipeline
- Déplacement automatique des offres validées vers les dossiers de candidature
- Relances automatiques pour le suivi des candidatures

## Captures d'ecran

![Capture desktop](docs/github-captures/competance-recherche-emploie-2026-08-30_02-37-02-desktop.png)

![Capture mobile](docs/github-captures/competance-recherche-emploie-2026-08-30_02-37-02-mobile.png)

## Variables d'environnement

Copier `.env.example` vers `.env` en local puis remplir les valeurs privees.

## Securite

Ne jamais publier `.env`, tokens, sessions, logs sensibles, cles privees ou donnees personnelles.
