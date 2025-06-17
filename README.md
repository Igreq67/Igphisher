![IGPHISHER Banner](igreq.png)

# IGPHISHER

> **Créé par IGREQ HENDRIX**

IGPHISHER est un outil éducatif de démonstration de phishing **personnalisé**, basé sur Termux, destiné à des usages **éthiques**, de **sécurité offensive** ou de sensibilisation à la cybersécurité.

---

## 🚀 Fonctionnalités

- Interface personnalisée avec le nom du créateur
- Pages de phishing simples (index.html + login.txt)
- Capture automatique des identifiants saisis
- Sauvegarde locale dans `sites-saved/`
- Compatible Termux Android (sans root)
- Exécutable avec la commande `hendrix`

---

## 📦 Installation rapide

```bash
pkg update && pkg upgrade
pkg install git php curl openssh -y
git clone https://github.com/ton-utilisateur/igphisher.git
cd igphisher
bash install.sh
