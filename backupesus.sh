#!/bin/bash

#######################################
# Criado por Ruan Costa Campos        #
# Email: ruancosta9797@gmail.com      #
# Tel: (77)991882211                  #
# CPD - Secretaria Municipal de Saúde #
#          Poções - Ba                #
#######################################

echo "BACKUP e-ESUS AB PEC"
echo "Criando backup..."
#variaveis utilizadas no backup
USER="sms"
ARQ_ORIGEM="/opt/e-SUS/database/postgresql-9.6.13-1-linux-x64/bin/pg_dump"
ARQ_DESTINO_DATA=`date +%Y%m%d%H%M%S`
ARQ_DESTINO="${ARQ_DESTINO_DATA}-${USER}-UBUNTU.backup"
DIR_ARQ_DESTINO="/home/${USER}/backup/${ARQ_DESTINO}"
# comando de execução do backup do esus
export PGPASSWORD=esus
"${ARQ_ORIGEM}" --host localhost --port 5433 -U "postgres" --format custom --blobs --encoding UTF8 --no-privileges --no-tablespaces --no-unlogged-table-data --file "${DIR_ARQ_DESTINO}" "esus"
echo "Backup Local concluído. "
source ./sendtocloud.sh "${DIR_ARQ_DESTINO}" 30 30
exit 0;

