# antes:
# dados[dados$nota >  7, c('nome', 'nota')]
# agora:
# dados |> filter(nota > 7) |> select(nome, nota) 

library(dplyr)
# Uso do operador pipe. Exemplo: x |> y, que significa 'pega x e com ele faz y 

dados <- data.frame(
  nome = c('Ana', 'Bruno', 'Carlos', 'Daniela'),
  idade = c(23, 35, 29, 41),
  nota = c(6.5, 8.0, 7.5, 9.0)
)

# Filtrar linhas
dados |> 
  filter(nota > 7)

# Com múltiplas condições
dados |> 
  filter(nota >  7, idade > 30)

# Escolher colunas
dados |> 
  select(nome, nota)

# Remover colunas
dados |> 
  select(-idade)

# Filtrar linhas e escolher colunas
dados |> 
  filter(nota > 7) |> 
  select(nome, nota)
