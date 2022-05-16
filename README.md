# pecbackup
Script para fazer o backup do PEC local e enviá-lo para o mega.io
# Requisitos
1 - Ter o mega cmd logado na máquina (usuário e root)<br>
2 - Ter uma pasta chamada backup na raiz do MEGA<br>
3 - Os dois arquivos sh na pasta /home/seu-usuario/<br>
4 - Pasta com nome backup no diretório /home/seu-usuario/, <br>
ficando /home/seu-usuario/backup.<br>
# Instruções
Após cumprir os requisitos você deve editar o arquivo **backupesus.sh** <br>
com as informações referentes a sua configuração. (Linha 14 e 20) <br>
Ex: 
```
14 - USER="seu-usuario"
20 - export PGPASSWORD=senhadobd
```
Por padrão a senha do PEC vem como esus, você preencherá de acordo com <br>
a sua.

(Na linha 23 você pode configurar os parâmetros do **sendtocloud**, que <br>
são explanados aqui abaixo.

# backupesus.sh
Deve ser alterado as variáveis que referenciam o usuário do linux <br>
e a senha do banco de dados postgres. <br>

# sendtocloud.sh
O script recebe 3 argumentos: ./sendtocloud a b c <br>
a: "diretorio do caminho de destino" <br>
b: "limite em dias para manter o arquivo" <br>
(Se o arquivo for mais antigo do que os valor b informado ele é deletado.) <br>
c: "limite de arquivos para manter" <br>
(Se houver mais arquivos que o valor C, são deletados até chegar no valor c) <br>



