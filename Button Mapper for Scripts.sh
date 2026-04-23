#!/bin/bash

# =======================================
# R36S Button Mapper for Scripts
# by djparent
# =======================================

# Copyright (c) 2026 djparent
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# =======================================================
# Root privileges check
# =======================================================
if [ "$(id -u)" -ne 0 ]; then
    exec sudo -- "$0" "$@"
fi

# =======================================================
# Initialization
# =======================================================
export TERM=linux

# =======================================================
# Variables
# =======================================================
GPTOKEYB_PID=""
CURR_TTY="/dev/tty1"
AB_FLAG="/var/cache/Switch_AB"
KEYS="/opt/inttools/keys.gptk"
BB_FLAG="/var/cache/B_for_Back"
BBAK="/opt/inttools/keys.gptk.bbak"
SWITCH_BAK="/opt/inttools/keys.gptk.switchbak"

if [ -f "$ES_CONF" ]; then
    ES_DETECTED=$(grep "name=\"Language\"" "$ES_CONF" | grep -o 'value="[^"]*"' | cut -d '"' -f 2)
    [ -n "$ES_DETECTED" ] && SYSTEM_LANG="$ES_DETECTED"
fi

# -------------------------------------------------------
# Default configuration : EN
# -------------------------------------------------------
T_BACKTITLE="R36S Button Mapper for Scripts"
T_MAIN_TITLE="Main Menu"
T_BUTTON_TITLE="Button Menu"
T_STORAGE_INFO="SD Card Info"
T_STARTING="Starting."
T_WAIT="Please wait..."
T_SW="Switch A/B"
T_SWITCH="$T_SW buttons"
T_BB="B for Back"
T_BBAK="$T_BB button"
T_RESTORE="Restore original config"
T_ORIG_FILE="Original configuration file restored."
T_ORIGINAL="Original configuration restored."
T_KEYS="keys.gptk backed up successfully:"
T_B_EN="B button for Back enabled."
T_AB_SWITCH="A and B buttons have been switched."
T_EXIT="Exit"

# --- FRANCAIS (FR) ---
if [[ "$SYSTEM_LANG" == *"fr"* ]]; then
T_BACKTITLE="Mappeur de boutons R36S pour scripts"
T_MAIN_TITLE="Menu principal"
T_BUTTON_TITLE="Menu des boutons"
T_STORAGE_INFO="Informations carte SD"
T_STARTING="Demarrage."
T_WAIT="Veuillez patienter..."
T_SW="Changer A/B"
T_SWITCH="$T_SW boutons"
T_BB="B pour retour"
T_BBAK="$T_BB bouton"
T_RESTORE="Restaurer la configuration originale"
T_ORIG_FILE="Fichier de configuration original restaure."
T_ORIGINAL="Configuration originale restauree."
T_KEYS="keys.gptk sauvegarde avec succes :"
T_B_EN="Bouton B pour retour active."
T_AB_SWITCH="Les boutons A et B ont ete inverses."
T_EXIT="Quitter"

# --- ESPANOL (ES) ---
elif [[ "$SYSTEM_LANG" == *"es"* ]]; then
T_BACKTITLE="Mapeador de botones R36S para scripts"
T_MAIN_TITLE="Menu principal"
T_BUTTON_TITLE="Menu de botones"
T_STORAGE_INFO="Informacion de tarjeta SD"
T_STARTING="Iniciando."
T_WAIT="Por favor espere..."
T_SW="Cambiar A/B"
T_SWITCH="$T_SW botones"
T_BB="B para volver"
T_BBAK="$T_BB boton"
T_RESTORE="Restaurar configuracion original"
T_ORIG_FILE="Archivo de configuracion original restaurado."
T_ORIGINAL="Configuracion original restaurada."
T_KEYS="keys.gptk respaldado con exito:"
T_B_EN="Boton B para volver activado."
T_AB_SWITCH="Los botones A y B han sido intercambiados."
T_EXIT="Salir"

# --- PORTUGUES (PT) ---
elif [[ "$SYSTEM_LANG" == *"pt"* ]]; then
T_BACKTITLE="Mapeador de botoes R36S para scripts"
T_MAIN_TITLE="Menu principal"
T_BUTTON_TITLE="Menu de botoes"
T_STORAGE_INFO="Informacoes do cartao SD"
T_STARTING="Iniciando."
T_WAIT="Por favor aguarde..."
T_SW="Alternar A/B"
T_SWITCH="$T_SW botoes"
T_BB="B para voltar"
T_BBAK="$T_BB botao"
T_RESTORE="Restaurar configuracao original"
T_ORIG_FILE="Ficheiro de configuracao original restaurado."
T_ORIGINAL="Configuracao original restaurada."
T_KEYS="keys.gptk guardado com sucesso:"
T_B_EN="Botao B para voltar ativado."
T_AB_SWITCH="Os botoes A e B foram trocados."
T_EXIT="Sair"

# --- ITALIANO (IT) ---
elif [[ "$SYSTEM_LANG" == *"it"* ]]; then
T_BACKTITLE="Mappatore pulsanti R36S per script"
T_MAIN_TITLE="Menu principale"
T_BUTTON_TITLE="Menu pulsanti"
T_STORAGE_INFO="Informazioni scheda SD"
T_STARTING="Avvio."
T_WAIT="Attendere prego..."
T_SW="Scambia A/B"
T_SWITCH="$T_SW pulsanti"
T_BB="B per tornare indietro"
T_BBAK="$T_BB pulsante"
T_RESTORE="Ripristina configurazione originale"
T_ORIG_FILE="File di configurazione originale ripristinato."
T_ORIGINAL="Configurazione originale ripristinata."
T_KEYS="keys.gptk salvato con successo:"
T_B_EN="Pulsante B per tornare indietro attivato."
T_AB_SWITCH="I pulsanti A e B sono stati scambiati."
T_EXIT="Esci"

# --- DEUTSCH (DE) ---
elif [[ "$SYSTEM_LANG" == *"de"* ]]; then
T_BACKTITLE="R36S Tastenmapper fur Skripte"
T_MAIN_TITLE="Hauptmenu"
T_BUTTON_TITLE="Tastenmenu"
T_STORAGE_INFO="SD Karten Info"
T_STARTING="Startet."
T_WAIT="Bitte warten..."
T_SW="A/B tauschen"
T_SWITCH="$T_SW Tasten"
T_BB="B fur Zuruck"
T_BBAK="$T_BB Taste"
T_RESTORE="Originalkonfiguration wiederherstellen"
T_ORIG_FILE="Originale Konfigurationsdatei wiederhergestellt."
T_ORIGINAL="Originalkonfiguration wiederhergestellt."
T_KEYS="keys.gptk erfolgreich gesichert:"
T_B_EN="B Taste fur Zuruck aktiviert."
T_AB_SWITCH="Die Tasten A und B wurden getauscht."
T_EXIT="Beenden"

# --- POLSKI (PL) ---
elif [[ "$SYSTEM_LANG" == *"pl"* ]]; then
T_BACKTITLE="Mapowanie przyciskow R36S dla skryptow"
T_MAIN_TITLE="Menu glowne"
T_BUTTON_TITLE="Menu przyciskow"
T_STORAGE_INFO="Informacje o karcie SD"
T_STARTING="Uruchamianie."
T_WAIT="Prosze czekac..."
T_SW="Zamien A/B"
T_SWITCH="$T_SW przyciski"
T_BB="B powrot"
T_BBAK="$T_BB przycisk"
T_RESTORE="Przywroc oryginalna konfiguracje"
T_ORIG_FILE="Oryginalny plik konfiguracji przywrocony."
T_ORIGINAL="Oryginalna konfiguracja przywrocona."
T_KEYS="keys.gptk zapisany pomyslnie:"
T_B_EN="Przycisk B powrot wlaczony."
T_AB_SWITCH="Przyciski A i B zostaly zamienione."
T_EXIT="Wyjscie"
fi

# =======================================================
# Start gamepad input
# =======================================================
Start_GPTKeyb() {
    pkill -9 -f gptokeyb 2>/dev/null || true
    if [ -n "$GPTOKEYB_PID" ]; then
        kill "$GPTOKEYB_PID" 2>/dev/null
    fi
    sleep 0.1
    /opt/inttools/gptokeyb -1 "$0" -c "/opt/inttools/keys.gptk" > /dev/null 2>&1 &
    GPTOKEYB_PID=$!
}

# =======================================================
# Stop gamepad input
# =======================================================
Stop_GPTKeyb() {
    if [ -n "$GPTOKEYB_PID" ]; then
        kill "$GPTOKEYB_PID" 2>/dev/null
        GPTOKEYB_PID=""
    fi
}

# =======================================================
# Font Selection
# =======================================================
ORIGINAL_FONT=$(setfont -v 2>&1 | grep -o '/.*\.psf.*')
setfont /usr/share/consolefonts/Lat7-TerminusBold22x11.psf.gz

# =======================================================
# Display Management
# =======================================================
printf "\e[?25l" > "$CURR_TTY"
dialog --clear
Stop_GPTKeyb
pgrep -f osk.py | xargs kill -9
printf "\033[H\033[2J" > "$CURR_TTY"
printf "$T_BACKTITLE by djparent\n"
printf "$T_STARTING $T_WAIT" > "$CURR_TTY"
sleep 0.5

# =======================================================
# Exit the script
# =======================================================
Exit_Menu() {
	trap - EXIT
    printf "\033[H\033[2J" > "$CURR_TTY"
    printf "\e[?25h" > "$CURR_TTY"
	Stop_GPTKeyb
    if [[ ! -e "/dev/input/by-path/platform-odroidgo2-joypad-event-joystick" ]]; then
        [ -n "$ORIGINAL_FONT" ] && setfont "$ORIGINAL_FONT"
    fi

    exit 0
}

Cleanup() {
    rm -f "$TMP_KEYS"
}

# =======================================================
# Restore original configuration
# =======================================================
Restore() {
	cp "$KEYS.bak" "$KEYS" || exit 1
	rm -f "$BB_FLAG"
	rm -f "$AB_FLAG"
	dialog --backtitle "$T_BACKTITLE" --msgbox "$T_ORIG_FILE" 6 50
}

# =======================================================
# B as Back button
# =======================================================
B_for_Back() {
if [[ ! -f "$KEYS.bak" ]]; then
	cp "$KEYS" "$KEYS.bak" || exit 1
	dialog --backtitle "$T_BACKTITLE" --infobox "$T_KEYS\n$KEYS.bak" 8 50
	sleep 2
fi
if [[ -f "$BB_FLAG" ]]; then
	if [[ -f "$AB_FLAG" ]]; then	
		sed -i 's/^a = .*/a = backspace/' "$KEYS"
		rm -f "$BBAK"
		rm -f "$BB_FLAG"
		dialog --backtitle "$T_BACKTITLE" --msgbox "$T_ORIGINAL" 6 50
	else
		cp -f "$BBAK" "$KEYS" || exit 1
		rm -f "$BBAK"
		rm -f "$BB_FLAG"
		dialog --backtitle "$T_BACKTITLE" --msgbox "$T_ORIGINAL" 6 50
	fi
else
	if [[ -f "$AB_FLAG" ]]; then	
		cp "$KEYS" "$BBAK" || exit 1
		sed -i 's/^b = .*/b = enter/' "$KEYS"
		sed -i 's/^a = .*/a = esc/' "$KEYS"
		touch "$BB_FLAG"
		dialog --backtitle "$T_BACKTITLE" --msgbox "$T_B_EN" 6 50
	else
		cp "$KEYS" "$BBAK" || exit 1
		sed -i 's/^b = .*/b = esc/' "$KEYS"
		sed -i 's/^a = .*/a = enter/' "$KEYS"
		touch "$BB_FLAG"
		dialog --backtitle "$T_BACKTITLE" --msgbox "$T_B_EN" 6 50
	fi	
fi
}

# =======================================================
# Switch A/B buttons
# =======================================================
Switch_AB() {
if [[ ! -f "$KEYS.bak" ]]; then
	cp "$KEYS" "$KEYS.bak" || exit 1
	dialog --backtitle "$T_BACKTITLE" --infobox "$T_KEYS\n$KEYS.bak" 8 50
	sleep 2
fi
if [[ -f "$AB_FLAG" ]]; then
	if [[ -f "$BB_FLAG" ]]; then	
		sed -i 's/^b = .*/b = esc/' "$KEYS"
		sed -i 's/^a = .*/a = enter/' "$KEYS"
		rm -f "$SWITCH_BAK"
		rm -f "$AB_FLAG"
		dialog --backtitle "$T_BACKTITLE" --msgbox "$T_ORIGINAL" 6 50
	else
		cp -f "$SWITCH_BAK" "$KEYS" || exit 1
		rm -f "$SWITCH_BAK"
		rm -f "$AB_FLAG"
		dialog --backtitle "$T_BACKTITLE" --msgbox "$T_ORIGINAL" 6 50
	fi	
else
	if [[ -f "$BB_FLAG" ]]; then
		cp "$KEYS" "$SWITCH_BAK" || exit 1
		sed -i 's/^b = .*/b = enter/' "$KEYS"
		sed -i 's/^a = .*/a = esc/' "$KEYS"
		touch "$AB_FLAG"
		dialog --backtitle "$T_BACKTITLE" --msgbox "$T_AB_SWITCH" 6 50
	else
		cp "$KEYS" "$SWITCH_BAK" || exit 1
		sed -i 's/^b = .*/b = enter/' "$KEYS"
		sed -i 's/^a = .*/a = backspace/' "$KEYS"
		touch "$AB_FLAG"
		dialog --backtitle "$T_BACKTITLE" --msgbox "$T_AB_SWITCH" 6 50
	fi
fi
}

# =======================================================
# Main Menu
# =======================================================
Main_Menu() {
	while true; do
		local AB
		local BB
		local CHOICE
		
		if [[ -f "$AB_FLAG" ]]; then
			AB="\Z2on\Zn"
		else
			AB="off"
		fi
		if [[ -f "$BB_FLAG" ]]; then
			BB="\Z2on\Zn"
		else
			BB="off"
		fi
				
		CHOICE=$(dialog \
			--clear \
			--colors \
			--no-collapse \
			--cancel-label "$T_EXIT" \
			--backtitle "$T_BACKTITLE" \
			--title "$T_BUTTON_TITLE" \
			--menu "$T_BB = $BB\n$T_SW = $AB" \
			12 45 6 \
			"1" "$T_BBAK" \
            "2" "$T_SWITCH" \
			"3" "$T_RESTORE" \
            2>&1 > "$CURR_TTY")
			
			[[ $? -ne 0 ]] && Exit_Menu
			
			case "$CHOICE" in
				1) B_for_Back ;;
				2) Switch_AB ;;
				3) Restore ;;
			esac
	done
}

# =======================================================
# Gamepad Setup
# =======================================================
export SDL_GAMECONTROLLERCONFIG_FILE="/opt/inttools/gamecontrollerdb.txt"
sudo chmod 666 /dev/uinput
Start_GPTKeyb

# =======================================================
# Main Execution
# =======================================================
printf "\033[H\033[2J" > "$CURR_TTY"
dialog --clear
trap 'Stop_GPTKeyb; Cleanup' Exit_Menu EXIT

Main_Menu