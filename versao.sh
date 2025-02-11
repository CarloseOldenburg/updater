#!/bin/bash
# sudo wget --inet4-only -O- https://raw.githubusercontent.com/CarloseOldenburg/updater/refs/heads/main/versao.sh | bash


set -e  # Para o script em caso de erro
LOG_FILE="install_log.txt"

echo "Iniciando instalação..." | tee -a $LOG_FILE

# Baixar e instalar o vsd-launcher
echo "Baixando vsd-launcher..." | tee -a $LOG_FILE
wget https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/vsd-launcher.sh -O vsd-launcher 2>&1 | tee -a $LOG_FILE
sudo chmod 755 vsd-launcher
sudo mv vsd-launcher /usr/bin/

echo "Executando vsd-launcher..." | tee -a $LOG_FILE
vsd-launcher -s food 2>&1 | tee -a $LOG_FILE
vsd-launcher --clear-token 2>&1 | tee -a $LOG_FILE

# Desinstalar módulos antigos
echo "Removendo módulos antigos..." | tee -a $LOG_FILE
sudo apt purge -y vsd-payment 2>&1 | tee -a $LOG_FILE
sudo apt purge -y pinpad-server 2>&1 | tee -a $LOG_FILE

# Baixar os novos módulos
echo "Baixando novos módulos..." | tee -a $LOG_FILE
wget https://cdn.vsd.app/softwares/vs-os-interface/2.24.0/vs-os-interface_2.24.0_amd64.deb 2>&1 | tee -a $LOG_FILE
wget https://github.com/getzoop/zoop-package-public/releases/download/zoop-desktop-server_3.10.0-beta/pinpad-server-installer_linux_3.10.0-beta.deb 2>&1 | tee -a $LOG_FILE
wget https://cdn.vsd.app/softwares/vsd-payment/prod/vsd-payment_1.2.1_amd64.deb 2>&1 | tee -a $LOG_FILE

# Instalar os novos módulos
echo "Instalando novos módulos..." | tee -a $LOG_FILE
sudo dpkg -i vs-os-interface_2.24.0_amd64.deb 2>&1 | tee -a $LOG_FILE
sudo dpkg -i pinpad-server-installer_linux_3.10.0-beta.deb 2>&1 | tee -a $LOG_FILE
sudo dpkg -i vsd-payment_1.2.1_amd64.deb 2>&1 | tee -a $LOG_FILE

# Reboot do sistema
echo "Reiniciando sistema..." | tee -a $LOG_FILE
sudo reboot
