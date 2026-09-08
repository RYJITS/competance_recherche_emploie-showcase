# Deploiement NAS - Recherche Emploi IA

## Verdict

L'application est adaptable au NAS.

Le projet fonctionne deja comme un service Node separe de ses donnees:

- code serveur: `[dossier-local]`
- donnees projet: `[dossier-local]`
- variable requise: `RECHERCHE_EMPLOI_PROJECT`
- port local actuel: `4780`
- verification: `/api/health`

Le NAS documente dans `[dossier-local]` est compatible avec ce modele: Linux, Docker Compose, Caddy, Tailscale, n8n et Nextcloud.

## Verification SSH du NAS

Controle effectue le 2026-06-21 via SSH:

- hote: `n8n`
- utilisateur: `yann`
- Docker: disponible
- Docker Compose: disponible
- Caddy: disponible
- Tailscale: disponible, Funnel actif sur le nom Tailscale existant
- services Docker actifs observes: `n8n_app`, `n8n_postgres`, `nextcloud`, `nextcloud_db`, `code-server`, `webtop`, `jellyfin`, `immich_server`, `immich_ml`, `immich_redis`, `immich_postgres`
- dossier existant: `/home/[utilisateur]/n8n`
- dossier absent: `/home/[utilisateur]/recherche-emploi`
- port `4780`: non utilise au moment du controle

Controle navigateur NAS effectue le 2026-06-25:

- hote: `n8n`, Ubuntu 24.04.3 sur Macmini6,2
- CPU: Intel i7-3615QM, 4 coeurs / 8 threads
- RAM: 16 Go
- disque root: 914 Go, environ 609 Go libres au controle
- Webtop candidature: `lscr.io/linuxserver/webtop:ubuntu-xfce`
- acces Webtop HTTP: `http://[adresse-ip]:8444`
- acces Webtop HTTPS direct: `https://[adresse-ip]:8445`
- acces Caddy/Tailscale recommande: `https://[hote-tailscale]/chrome-candidatures/`
- profil Chrome candidature: `/home/[utilisateur]/n8n/webtop_recherche_emploi_config/recherche-emploi-cdp`
- pont CDP pour l'application: `http://webtop:9223`
- profil Webtop leger: Selkies limite a `1280x900`, `20 FPS`, audio/micro/gamepad desactives, `DISABLE_DRI3=true`

Les fichiers de secrets du NAS ne doivent pas etre lus ni recopies dans la documentation.

## Regle de securite

Ce projet doit rester prive. Il contient ou manipule des donnees personnelles: CV, profil, candidatures, suivi d'emails, entreprises, sources et automatisations.

Recommandation:

- acces LAN ou Tailscale uniquement;
- pas de publication GitHub/Hostinger publique;
- pas d'exposition Internet directe sans authentification forte;
- aucun secret dans les fichiers du depot;
- sauvegarde chiffree ou au minimum protegee cote NAS.

## Architecture en place sur le NAS

Chemins utilises:

```text
/home/[utilisateur]/recherche-emploi/
  app/       # copie de [dossier-local]
  brain/     # donnees Cerveau IA montees dans le conteneur
  compose.yml
```

Un modele pret a copier est fourni dans le projet:

```text
[dossier-local]
[dossier-local]
```

Sur le NAS, copier `.[domaine-infrastructure]` vers `.env`, puis verifier que `NAS_SHARED_NETWORK` correspond au reseau Docker utilise par Caddy/n8n. Sur le NAS actuel, le reseau observe est `n8n_default`; c'est donc la valeur par defaut du modele.

Service Docker:

```yaml
services:
  recherche-emploi:
    build: ./app
    container_name: recherche_emploi_app
    restart: unless-stopped
    env_file:
      - .env
    environment:
      NODE_ENV: production
      PORT: "4780"
      BASE_PATH: /emploi
      CERVEAU_ROOT: /data
      RECHERCHE_EMPLOI_PROJECT: /data/Projet/Competance_Recherche_emploie
      CHROME_PATH: /usr/bin/chromium
      RECHERCHE_EMPLOI_AUTO_SCHEDULER: "1"
      RECHERCHE_EMPLOI_FORM_BROWSER_MODE: local_headless
      RECHERCHE_EMPLOI_FORM_HEADLESS: "1"
    ports:
      - "127.0.0.1:4780:4780"
    volumes:
      - ./brain:/data
    networks:
      - nas_shared
networks:
  nas_shared:
    external: true
    name: ${NAS_SHARED_NETWORK:-n8n_default}
```

Le scheduler serveur est autorise par `RECHERCHE_EMPLOI_AUTO_SCHEDULER=1`, mais les envois planifies restent pilotes par le reglage persistant `[domaine-infrastructure]` dans l'application. L'interface contient maintenant un bouton principal ON/OFF dans `Mode automatique`.

Le fichier `.env` du NAS est prive et injecte dans le conteneur. Il peut contenir les champs formulaire reutilisables:

```env
UMANTIS_FORM_PASSWORD=
FORM_SALUTATION=
FORM_STREET=
FORM_ZIP=
FORM_CITY=
FORM_COUNTRY=Schweiz
FORM_LINKEDIN=
```

Pour les postulations avec formulaire, le mode recommande est maintenant `RECHERCHE_EMPLOI_FORM_BROWSER_MODE=local_headless`. Chromium tourne directement dans le conteneur `recherche-emploi`, sans WebTop et sans pont CDP. Le robot remplit, joint les PDF, capture `formulaire-before.png` et `formulaire-after.png`, puis bloque avant l'envoi si un champ requis, un login, un CAPTCHA ou un consentement explicite manque.

Le service `recherche-emploi` reste connecte au reseau Docker externe configurable par `NAS_SHARED_NETWORK` pour l'exposition Caddy/n8n, mais il ne depend plus du service `webtop` pour remplir les formulaires.

Les anciens scripts WebTop/CDP restent disponibles comme fallback visible, mais ils ne sont plus le chemin par defaut.

Pour rendre le navigateur visible recuperable apres redemarrage de Webtop, installer le script dans le Webtop propre:

```bash
mkdir -p /home/[utilisateur]/n8n/webtop_recherche_emploi_config/custom-cont-init.d
cp deploiement_nas/webtop-recherche-emploi-cdp-init.sh /home/[utilisateur]/n8n/webtop_recherche_emploi_config/custom-cont-init.d/99-recherche-emploi-cdp.sh
chmod +x /home/[utilisateur]/n8n/webtop_recherche_emploi_config/custom-cont-init.d/99-recherche-emploi-cdp.sh
```

Le compose principal du NAS monte aussi ce dossier dans `/custom-cont-init.d`, car les images LinuxServer recentes executent les scripts custom depuis ce chemin.

### Reglage Webtop leger

Sur le Mac mini NAS, Webtop peut etre tres lent si Selkies ouvre un bureau virtuel trop grand ou tente l'encodage GPU puis retombe en CPU. Le compose principal `/home/[utilisateur]/n8n/[domaine-infrastructure]` doit garder ces variables dans le service `webtop`:

```yaml
      - SELKIES_FRAMERATE=20
      - SELKIES_IS_MANUAL_RESOLUTION_MODE=true
      - SELKIES_MANUAL_WIDTH=1280
      - SELKIES_MANUAL_HEIGHT=900
      - SELKIES_USE_CSS_SCALING=true
      - SELKIES_AUDIO_ENABLED=false
      - SELKIES_MICROPHONE_ENABLED=false
      - SELKIES_GAMEPAD_ENABLED=false
      - SELKIES_H264_CRF=32
      - DISABLE_DRI3=true
      - DISABLE_ZINK=true
```

Verification rapide apres redemarrage:

```bash
docker stats --no-stream webtop
docker exec webtop sh -lc "ps aux | grep Xvfb | grep -v grep"
```

Le processus `Xvfb` doit afficher `1280x900x24`, pas `15360x8640x24`.

Smoke test headless sans WebTop:

```bash
docker cp /home/[utilisateur]/recherche-emploi/deploiement_nas/[domaine-infrastructure] recherche_emploi_app:/tmp/[domaine-infrastructure]
docker exec recherche_emploi_app node /tmp/[domaine-infrastructure]
```

La sortie attendue doit indiquer:

- `browserMode: "local_headless"`
- `submitted: true`
- `postReachedServer: true`
- `beforeScreenshot: true`
- `afterScreenshot: true`

Smoke test visible historique via WebTop/CDP:

```bash
docker cp /home/[utilisateur]/recherche-emploi/[domaine-infrastructure] recherche_emploi_app:/tmp/[domaine-infrastructure]
docker exec recherche_emploi_app node /tmp/[domaine-infrastructure]
```

## Reprendre sur le navigateur de l'appareil

Le robot automatique utilise maintenant Chromium headless dans le conteneur NAS pour remplir et verifier. Si le robot bloque, l'application renvoie aussi l'URL du formulaire a l'interface web et conserve les captures/formulaires dans le dossier de candidature.

Depuis le bouton `Envoyer` ou `Finaliser`, l'interface reserve un onglet dans le navigateur de l'appareil avant l'appel API. Si le robot detecte un CAPTCHA, un login, un champ requis inconnu ou un doute serieux, cet onglet est redirige vers le formulaire pour que la reprise se fasse dans le navigateur que tu utilises.

Ce mode est la reprise recommandee.

Important: pour des raisons de securite navigateur, les champs remplis par Chromium headless ne sont pas automatiquement transferes dans l'onglet de l'appareil. L'onglet local sert a reprendre la validation humainement sur le vrai site. Les reponses pretes restent dans `formulaire.md`, `formulaire.json` et les captures du dossier candidature.

## Voir et reprendre dans Webtop

Pour le voir:

1. Ouvrir `https://[hote-tailscale]/chrome-candidatures/`.
2. Accepter le certificat local si Chrome affiche un avertissement.
3. Chercher la fenetre `Chromium`.
4. Quand le robot bloque, l'onglet doit s'appeler `ACTION REQUISE - ...`.
5. Completer le CAPTCHA, le login ou le champ manquant directement dans cet onglet.
6. Cliquer toi-meme sur le bouton final du site seulement si tout est correct.

Ancienne adresse encore exposee en HTTP:

```text
http://[adresse-ip]:8444
```

Elle peut afficher `This application requires a secure connection`. Dans ce cas utiliser l'adresse HTTPS `8445` ou l'adresse Tailscale/Caddy `https://[hote-tailscale]/chrome-candidatures/`.

Le robot n'envoie pas automatiquement si la page contient un CAPTCHA, un login, un champ requis inconnu ou un doute serieux. Dans ce cas, il laisse la page ouverte avec une banniere `ACTION REQUISE`.

## Caddy / Tailscale

Le Caddy actuel route plusieurs applications par chemin (`/n8n`, `/cloud`, `/jellyfin`, `/immich`, `/code`, `/chrome-candidatures`, `/cockpit`) et garde le portail comme route par defaut. L'ancien chemin `/antigravity/` redirige vers `/chrome-candidatures/`.

Recherche Emploi est maintenant servi sous:

```text
https://[hote-tailscale]/emploi/
```

L'application supporte `BASE_PATH=/emploi`: les assets frontend sont relatifs et les appels API sont prefixes automatiquement.

## Commandes de preparation

Sur le NAS:

```bash
mkdir -p /home/[utilisateur]/recherche-emploi/app
mkdir -p /home/[utilisateur]/recherche-emploi/project
cd /home/[utilisateur]/recherche-emploi
cp /chemin/copied/deploiement_nas/compose.yml ./compose.yml
cp /chemin/copied/deploiement_nas/.env.example ./.env
```

Depuis Windows, copier les dossiers avec `scp`, WinSCP ou VS Code Remote SSH:

```powershell
scp -r [dossier-local] yann@[adresse-ip]:/home/[utilisateur]/recherche-emploi/app/
scp -r [dossier-local] yann@[adresse-ip]:/home/[utilisateur]/recherche-emploi/project/
```

Puis sur le NAS:

```bash
cd /home/[utilisateur]/recherche-emploi
docker compose -f compose.yml config
docker compose -f compose.yml up -d
curl http://127.0.0.1:4780/emploi/api/health
docker cp deploiement_nas/[domaine-infrastructure] recherche_emploi_app:/tmp/[domaine-infrastructure]
docker exec recherche_emploi_app node /tmp/[domaine-infrastructure]
```

## Verification attendue

`/emploi/api/health` doit retourner:

- `ok: true`
- `projectRoot: /data/Projet/Competance_Recherche_emploie`
- `publicRoot: /data/Projet/Competance_Recherche_emploie/public`
- `settingsPath: /data/Projet/Competance_Recherche_emploie/config/settings.json`
- `basePath: /emploi`

`/emploi/api/auto-mode/status` doit indiquer:

- `schedulerRunning: true`
- `schedulerServiceEnabled: true`
- `effectiveEnabled: true` quand le bouton ON/OFF est actif

## Sauvegarde

Ajouter au script de sauvegarde NAS:

```bash
/home/[utilisateur]/recherche-emploi/brain
```

Le dossier `app` peut etre recopie depuis le PC, mais `brain` contient l'etat vivant de l'application et doit etre sauvegarde.

## Points de suivi

- Tester `docker compose config` avant chaque modification compose.
- Recharger Caddy seulement apres healthcheck OK.
- Verifier que les secrets API restent dans un fichier local non versionne si l'application en a besoin.
- Ajouter `recherche-emploi/brain` aux sauvegardes NAS.
- Idealement, separer les secrets actuels du NAS dans un fichier `.env` non versionne plutot que dans `[domaine-infrastructure]`.
