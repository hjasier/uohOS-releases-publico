#!/bin/bash

# uohOS - Script de instalación rápida para Linux (.deb)
set -e

echo "==================================================="
echo "  Instalando la última versión de uohOS..."
echo "==================================================="

# 1. Obtener los datos del último release usando la API de GitHub
echo " -> Buscando la última release oficial..."
LATEST_JSON=$(curl -s https://api.github.com/repos/hjasier/uohOS-releases-publico/releases/latest)

# Extraer la URL de descarga que corresponda al archivo .deb
DEB_URL=$(echo "$LATEST_JSON" | grep -m 1 -oP '"browser_download_url": "\K(.*\.deb)(?=")')

if [ -z "$DEB_URL" ]; then
    echo "Error: No se ha podido encontrar un archivo .deb en la última release."
    exit 1
fi

echo " -> Descargando versión:"
echo "    $DEB_URL"

# 2. Descargar el archivo .deb a la carpeta temporal
TMP_DEB="/tmp/uohOS_latest.deb"
curl -L -# "$DEB_URL" -o "$TMP_DEB"

# 3. Instalar el paquete (requerirá sudo)
echo " -> Instalando el paquete..."
sudo apt-get update
sudo apt-get install -y "$TMP_DEB"

# 4. Limpiar el archivo descargado
echo " -> Limpiando archivos temporales..."
rm "$TMP_DEB"

echo "==================================================="
echo "  listoooo!! "
echo "==================================================="
