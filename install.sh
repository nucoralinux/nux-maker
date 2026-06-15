#!/bin/bash
# ══════════════════════════════════════════════════════════════
# nux-maker installer v4.5.0
# Nucora Linux Repo Management Tool
# ══════════════════════════════════════════════════════════════

set -e

R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'
C='\033[1;36m'
W='\033[1;37m'
RE='\033[0m'

# Dil algılama
SYS_LANG="${LANG:-en_US}"
if [[ "$SYS_LANG" == tr* ]]; then
    INSTALLER_LANG="tr"
else
    INSTALLER_LANG="en"
fi

# Çeviriler
declare -A TR EN

TR[title]="nux-maker kurulum scripti v4.5.0"
TR[subtitle]="Nucora Linux Repo Yönetim Aracı"
TR[root_err]="Root yetkisi gerekli. sudo ile çalıştırın."
TR[checking]="Bağımlılıklar kontrol ediliyor..."
TR[installing_deps]="Eksik bağımlılıklar kuruluyor..."
TR[deps_ok]="Tüm bağımlılıklar mevcut"
TR[deps_installed]="Bağımlılıklar kuruldu"
TR[installing]="nux-maker kuruluyor..."
TR[installed]="nux-maker kuruldu"
TR[next]="Başlamak için:"
TR[run_setup]="sudo nux-maker setup"
TR[done]="Kurulum tamamlandı!"

EN[title]="nux-maker installer v4.5.0"
EN[subtitle]="Nucora Linux Repo Management Tool"
EN[root_err]="Root privileges required. Run with sudo."
EN[checking]="Checking dependencies..."
EN[installing_deps]="Installing missing dependencies..."
EN[deps_ok]="All dependencies present"
EN[deps_installed]="Dependencies installed"
EN[installing]="Installing nux-maker..."
EN[installed]="nux-maker installed"
EN[next]="To get started:"
EN[run_setup]="sudo nux-maker setup"
EN[done]="Installation complete!"

t() {
    local key="$1"
    if [ "$INSTALLER_LANG" = "tr" ]; then
        echo "${TR[$key]}"
    else
        echo "${EN[$key]}"
    fi
}

echo -e "${C}"
echo "╔════════════════════════════════════════════════╗"
echo "║  $(t title)   ║"
echo "║  $(t subtitle)  ║"
echo "╚════════════════════════════════════════════════╝"
echo -e "${RE}"

# Root kontrolü
if [ "$EUID" -ne 0 ]; then
    echo -e "${R}$(t root_err)${RE}"
    exit 1
fi

# Bağımlılık kontrolü
echo -e "${W}$(t checking)${RE}"
echo ""

DEPS_MISSING=0
REQUIRED_CMDS=(python3 dpkg-deb tar nginx certbot)
REQUIRED_PKGS=(python3 dpkg-dev tar nginx certbot python3-certbot-nginx)

for cmd in "${REQUIRED_CMDS[@]}"; do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo -e "  ${G}✓${RE} $cmd"
    else
        echo -e "  ${R}✗${RE} $cmd"
        DEPS_MISSING=1
    fi
done

echo ""

if [ "$DEPS_MISSING" -eq 1 ]; then
    echo -e "${Y}$(t installing_deps)${RE}"
    echo ""
    apt-get update -qq >/dev/null 2>&1
    apt-get install -y -qq "${REQUIRED_PKGS[@]}" >/dev/null 2>&1
    echo -e "${G}✓ $(t deps_installed)${RE}"
else
    echo -e "${G}✓ $(t deps_ok)${RE}"
fi

echo ""

# nux-maker'ı kur
echo -e "${W}$(t installing)${RE}"

install -Dm755 nux-maker /usr/bin/nux-maker
mkdir -p /etc/nux-maker

echo -e "${G}✓ $(t installed): /usr/bin/nux-maker${RE}"
echo ""
echo -e "${C}$(t next)${RE}"
echo -e "  ${W}$(t run_setup)${RE}"
echo ""
echo -e "${G}$(t done)${RE}"
echo ""
echo -e "${C}──────────────────────────────────────────────${RE}"
echo -e "${W}Nux and Nucora are fully developed and"
echo -e "maintained by one person."
echo -e "By: Efe Enes${RE}"
echo -e "${C}──────────────────────────────────────────────${RE}"
echo ""
