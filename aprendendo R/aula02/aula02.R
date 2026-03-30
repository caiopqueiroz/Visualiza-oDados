# Criando um 'data.frame' e guardando na variável 'dados'
# 'nome', 'idade' e 'nota' são as colunas da tabela
dados <- data.frame(
  nome = c('Ana', 'João', 'Maria', 'Caio'),
  idade = c(20, 22, 21, 18),
  nota = c(8.5, 7.0, 9.2, 5.9)
)

# Acessando a coluna 'nome'
dados$nome

# Acessando a linha 1
dados[1, ]

# Acessando o elemento da linha 1 e coluna 3
dados[1, 3]

# Acessando, na tabela 'dados', apenas as linhas que tem na coluna 'idade' um valor maior que 20
# O número antes da vírgula especifica as linhas que queremos
# O número após a vírgula se refere às colunas
dados[dados$idade > 20, ]

# Acessando apenas o nome dos alunos que obtiveram nota >= 6
dados[dados$nota >= 6, 1]

# Criando uma nova coluna
# Nesse caso, a coluna está recebendo valores lógicos (TRUE ou FALSE) de acordo com a condição estabelecida
dados$aprovado <- dados$nota >= 7

dados$cidade <- c('PM', 'BH', 'BH', 'PM')

# Conceito mais importante da aula: Cada coluna é um vetor