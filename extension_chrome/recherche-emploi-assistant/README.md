# Recherche Emploi Assistant - Extension Chrome locale

Extension locale V1 pour tester une approche plus rapide que Webtop/CDP sur JobWatch.

## Installation

1. Ouvrir Chrome ou Edge.
2. Aller sur `chrome://extensions`.
3. Activer `Mode developpeur`.
4. Cliquer `Charger l extension non empaquetee`.
5. Selectionner ce dossier:

```text
[dossier-local]
```

6. Epingler l extension dans la barre du navigateur.

## Utilisation V1

1. Ouvrir une annonce JobWatch dans le navigateur normal.
2. Cliquer l extension `Recherche Emploi Assistant`.
3. Cliquer `Analyser`.
4. Si un bouton est trouve, cliquer `Postuler`.
5. Si JobWatch demande une connexion, se connecter dans cette page puis relancer `Postuler`.

Si l extension vient juste d etre installee et que l onglet JobWatch etait deja ouvert, l injection automatique devrait suffire. Sinon, recharge simplement la page JobWatch.

## Limites V1

- JobWatch uniquement.
- Pas de mot de passe stocke.
- Pas de contournement CAPTCHA.
- Pas encore de remplissage automatique des champs du formulaire.
- Les boutons detectes sont surlignes en bleu pour controle visuel.

## Objectif V2

- Lire le dossier candidature depuis l application NAS.
- Remplir les champs texte du formulaire apres connexion.
- Garder l envoi final manuel.
