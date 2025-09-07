#!/bin/bash

################### Colors ###################
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
MAGENTA='\e[35m'
CYAN='\e[36m'
RESET='\e[0m'

################### Banner ###################
banner() {
    echo -e "${MAGENTA}===============================================${RESET}"
    echo -e "         ${CYAN}🚀 WELCOME TO ${YELLOW}WEB RECON TOOL 🚀 ${RESET}"
    echo -e "${MAGENTA}===============================================${RESET}"
    echo ""
    echo -e "${BLUE}       ____  __.__        .__                   ${RESET}"
    echo -e "${BLUE}      |    |/ _|__| ____  |  |   ____  ____     ${RESET}"
    echo -e "${BLUE}      |      < |  |/ __ \ |  | _/ __ \/  _ \    ${RESET}"
    echo -e "${BLUE}      |    |  \|  \  ___/ |  |_\  ___(  <_> )   ${RESET}"
    echo -e "${BLUE}      |____|__ \__|\___  >|____/\___  >____/    ${RESET}"
    echo -e "${BLUE}              \/       \/           \/          ${RESET}"
    echo -e "${RED}                       Created by - Prashant Swami ${RESET}"
    echo -e "${GREEN}        Initializing project environment...     ${RESET}"
}

divider() {
    echo
    echo -e "${BLUE}========================================================${RESET}"
    echo
}

help() {
    clear
    banner
    echo
    echo -e "USAGE: $0 <DOMAIN> <FLAGS>"
    echo -e "Example: $0 example.com --httpx --whois --urls"
    echo
    echo -e "Available Options:"
    echo -e "-h,  --help            Show help menu"
    echo -e "-hx, --httpx           Get live domains"
    echo -e "-u,  --urls            Get all URLs"
    echo -e "-p,  --parameter       Get parameters"
    echo -e "-w,  --wayback         Get Wayback Machine data"
    echo -e "--whois                Get WHOIS information"
    echo -e "-ps, --portscan        Run port scan"
    echo
}

################### Input Validation ###################

if [ $# -lt 1 ]; then
    echo -e "${RED}[!] Error: No domain provided.${RESET}"
    help
    exit 1
fi

DOMAIN=$1
shift  # Remove the domain from args

if [ $# -eq 0 ]; then
    echo -e "${RED}[!] Error: No flags provided.${RESET}"
    help
    exit 1
fi

if [ ! -d "$DOMAIN" ]; then
    mkdir "$DOMAIN"
    cd "$DOMAIN" || exit
else
    echo -e "${YELLOW}[i] Using existing directory: $DOMAIN${RESET}"
    cd "$DOMAIN" || exit
fi

################### Run Banner ###################

banner
divider

################### Flag Processing ###################

NEED_SUBDOMAINS=false

for arg in "$@"; do
    case "$arg" in
        -hx|--httpx)
            NEED_SUBDOMAINS=true
            ;;
        -u|--urls)
            : # nothing special needed here
            ;;
        -p|--parameter)
            : # nothing special needed here
            ;;
        -w|--wayback)
            : # nothing special needed here
            ;;
        --whois)
            : # nothing special needed here
            ;;
        -ps|--portscan)
            : # nothing special needed here
            ;;
        -h|--help)
            help
            exit 0
            ;;
        *)
            echo -e "${RED}[!] Unknown flag: $arg${RESET}"
            exit 1
            ;;
    esac
done

################### Subdomain Gathering (only if needed) ###################

if $NEED_SUBDOMAINS; then
    echo -e "${BLUE}[-] Gathering subdomains using subfinder and assetfinder...${RESET}"
    subfinder -silent -d "$DOMAIN" >> sub_domains.txt
    assetfinder "$DOMAIN" >> sub_domains.txt
    sort -u sub_domains.txt > sub-domains.txt && rm sub_domains.txt

    echo -e "${GREEN}[+] Subdomains saved to sub-domains.txt${RESET}"
    divider
fi

################### Execute Each Flag ###################

for arg in "$@"; do
    case "$arg" in
        -hx|--httpx)
            echo -e "${BLUE}[-] Running httpx...${RESET}"
            cat sub-domains.txt | httpx-toolkit | tee live_domains.txt
            echo -e "${GREEN}[+] Live domains saved to live_domains.txt${RESET}"
            divider
            ;;

        -u|--urls)
            echo -e "${BLUE}[-] Running gau to collect URLs...${RESET}"
            gau "$DOMAIN" | tee urls.txt
            echo -e "${GREEN}[+] URLs saved to urls.txt${RESET}"
            divider
            ;;

        -p|--parameter)
            echo -e "${BLUE}[-] Running ParamSpider...${RESET}"
            python3 /home/kalki343/project/ParamSpider/paramspider.py -d "$DOMAIN" | tee parameter.txt
            echo -e "${GREEN}[+] Parameters saved to parameter.txt${RESET}"
            divider
            ;;

        -w|--wayback)
            echo -e "${BLUE}[-] Running Wayback URLs collection...${RESET}"
            waybackurls "$DOMAIN" | tee waybackurls.txt
            echo -e "${GREEN}[+] Wayback URLs saved to waybackurls.txt${RESET}"
            divider
            ;;

        --whois)
            echo -e "${BLUE}[-] Gathering WHOIS info...${RESET}"
            curl -s "https://www.whois.com/whois/$DOMAIN" | tee whois.txt
            echo -e "${GREEN}[+] WHOIS info saved to whois.txt${RESET}"
            divider
            ;;

        -ps|--portscan)
            echo -e "${BLUE}[-] Running port scan with naabu...${RESET}"
            naabu -silent -host "$DOMAIN" | tee openports.txt
            echo -e "${GREEN}[+] Open ports saved to openports.txt${RESET}"
            divider
            ;;
    esac
done

echo -e "${BLUE}RECON COMPLETED SUCCESSFULLY.${RESET}"
