#######################################
# Criado por Ruan Costa Campos        #
# Email: ruancosta9797@gmail.com      #
# Tel: (77)991882211                  #
# CPD - Secretaria Municipal de Saúde #
#          Poções - Ba                #
#######################################


function dateDiff(){
  first_date=$(date -d "$1" "+%s")
  second_date=$(date -d "$2" "+%s")


  case "$3" in
  "--seconds" | "-s") period=1;;
  "--minutes" | "-m") period=60;;
  "--hours" | "-h") period=$((60*60));;
  "--days" | "-d" | "") period=$((60*60*24));;
  esac

  datediff=$(( ($first_date - $second_date)/($period) ))
  echo $datediff;
}

echo "Verificando sessão [Mega.nz]...";

mega-whoami

echo "Enviando arquivo para Cloud [Mega.nz]...";
mega-put $1 BACKUP
echo "Arquivo enviado para [Mega.nz] Com sucesso.";

echo "Verificando quantidade de arquivos no Cloud [Mega.nz]...";

IFS=$'\n' MEGA_LISTA_ARQUIVOS=($(mega-ls BACKUP))


DATA_ATUAL=$(date "+%Y-%m-%d %H:%M");
DATA_ARQUIVO=$(date --utc --date '2021-03-10' "+%Y-%m-%d %H:%M");
QUANTIDADE_ARQUIVOS=${#MEGA_LISTA_ARQUIVOS[@]}
DIFERENCA_DIAS_INPUT=$2
QUANTIDADE_ARQUVOS_INPUT=$3

echo "QUANTIDADE_ARQUVOS=[${QUANTIDADE_ARQUIVOS}]";

if [ -z "$DIFERENCA_DIAS_INPUT" ]; then
  echo "[PARAM2 VAZIO]";
  DIFERENCA_DIAS_INPUT=30;
fi
  
if [ -z "$QUANTIDADE_ARQUVOS_INPUT" ]; then
  echo "[PARAM3 VAZIO]";
  QUANTIDADE_ARQUVOS_INPUT=30;
fi

for i in "${MEGA_LISTA_ARQUIVOS[@]}"
do
  DATA_ARQUIVO=$(date --utc --date "${i:0:4}-${i:4:2}-${i:6:2}" "+%Y-%m-%d %H:%M");
  
  DIFERENCA_DIAS=$( dateDiff ${DATA_ATUAL} ${DATA_ARQUIVO} -d ); # Compara as datas e do intervalo em dias

  
  if [ $DIFERENCA_DIAS -gt $DIFERENCA_DIAS_INPUT ] && [ $QUANTIDADE_ARQUIVOS -gt $QUANTIDADE_ARQUVOS_INPUT ]; then
    echo "O arquivo será DELETADO porque foi criado há ${DIFERENCA_DIAS} dias atrás";
    mega-rm "BACKUP/${i}";
  else
    echo "O arquivo será mantido porque foi criado há menos de ${DIFERENCA_DIAS} dias atrás.";
  fi
        
done
