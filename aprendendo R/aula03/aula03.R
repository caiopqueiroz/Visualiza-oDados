dados <- data.frame(
  nome = c('Caio', 'Júlia', 'Lucas', 'Luiza'),
  idade = c(18, 20, 16, 18),
  nota = c(8, 10, 4, 7.5)
)

# Acessando múltiplas colunas
dados[, c('nome', 'nota')]

# Acessando múltiplas linhas
dados[c(1, 3), ]

# Remover linhas e colunas
dados[-1, ]
dados[, -2]

# Seleção com múltiplas condições
dados[dados$nota > 7 & dados$idade < 22, ]

# Acessando colunas + filtro
dados[dados$nota > 7, c('nome', 'nota')]
dados[dados$idade <= 16, c('nome', 'idade')]

# Modificando partes específicas
# Como o valor que queremos modificar está na coluna 'nota', devemos aplicar o filtro somente nela 
dados$nota[dados$nota < 7] <- 0

# Ordenando dados (crescente e decrescente)
dados[order(dados$nota), ]
dados[order(-dados$nota), ]

# Valores únicos (não mostra valores repetidos)
unique(dados$nome)

# Contagem de frequência
table(dados$idade)
