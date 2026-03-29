# aircrack-ng
Explicação Técnica dos Comandos:

    sudo apt install: Baixa os binários necessários. No Kali Linux isso já vem instalado, mas no Ubuntu/Debian é obrigatório.
    airmon-ng check kill: É o comando que faz sua "internet sumir" do menu, pois ele desativa o serviço que conecta você automaticamente.
    airodump-ng: É o "scanner". Sem os filtros (--bssid e -c), ele é pouco eficiente porque fica mudando de canal e perdendo informações cruciais.
    .cap: O arquivo gerado no passo 4 é o que contém o tráfego da rede. Ele pode ser aberto depois no Wireshark para análise detalhada de protocolos.

Dica para iniciante: O segredo do Aircrack não é apenas rodar o comando, mas focar no canal certo. Se sua rede está no canal 100 (5G), use sempre -c 100.
