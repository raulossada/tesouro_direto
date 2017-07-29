setwd("C:/Users/raul/Documents/GitHub/tesouro_direto");

library("Rgitbook");

# Instala a versão anterior do gitbook onde tudo funcionava bem offline
# Só precisa executar 1 vez
# system2(command="gitbook", "fetch 2.6.4");
# Verifica se a instalação deu certo
# Só precisa executar 1 vez
# system2(command="gitbook", "ls");

# Constrói o GitBook usando a versão que funciona offline
buildGitbook(gitbook.params="--gitbook=2.6.4");

openGitbook();
