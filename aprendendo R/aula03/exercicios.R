#ex01 ao ex05
dados <- data.frame(
  nome = c('Ana', 'Bruno', 'Carlos', 'Daniela'),
  idade = c(23, 35, 29, 41),
  nota = c(6.5, 8, 7.5, 9)
)

dados[, c('nome', 'nota')]

dados[c(2, 4), ]

dados[, -2]

dados[-1, ]

dados[dados$nota > 7, c('nome', 'nota')]

dados_mod <- dados
dados_mod$nota[dados_mod$nota < 7] <- 0

dados[order(dados$nota), ]

dados[order(-dados$nota), ]

#ex06

nomes <- c('Ana', 'Bruno', 'Ana', 'Carlos', 'Bruno', 'Ana')

unique(nomes)

table(nomes)
