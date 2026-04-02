dados <- data.frame(
  nome = c('Ana', 'Bruno', 'Carlos', 'Daniela', 'Eduardo'),
  idade = c(23, 35, 29, 41, 30),
  nota = c(6.5, 8.0, 7.5, 9.0, 5.5)
)

dados[, c('nome', 'idade')]

dados[c(1, 3, 5), ]

dados[, -3]

dados[c(-2, -4), ]

dados[dados$nota > 7, c('nome', 'nota')]

dados2 <- dados
dados2$nota[dados2$nota < 6] <- 0

dados[order(dados$idade), ]

dados[order(-dados$nota), ]

cursos <- c('ADS', 'ADS', 'Engenharia', 'ADS', 'Direito', 'Engenharia')

unique(cursos)

table(cursos)

dados[dados$idade >= 30 | dados$nota < 6, ]
