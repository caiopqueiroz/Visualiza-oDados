# Conceito de hipóteses: sempre existem duas
# 1º Não há diferença x não afeta y
# 2º Há diferença: x afeta y

# P-value é a chance de o resultado existir sem que haja relação, logo, quanto menor ele for, menor a chance de ser coincidência
# P-value < 0.05: rejeita a hipótese nula, ou seja, x afeta y

# Comparando médias
grupo_A <- c(10, 12, 11, 13, 12)
grupo_B <- c(8, 7, 9, 6, 8)
t.test(grupo_A, grupo_B)

# Exemplo real
dados <- data.frame(
  produto = c('Notebook', 'Celular', 'Tablet', 'Notebook', 'Celular', 'Tablet', 'Fone', 'Teclado', 'Fone', 'Tablet'),
  categoria = c('Eletrônico', 'Eletrônico', 'Eletrônico', 'Eletrônico', 'Eletrônico', 'Eletrônico', 'Acessório', 'Acessório', 'Acessório', 'Eletrônico'),
  cidade = c('SP', 'SP', 'RJ', 'RJ', 'SP', 'RJ', 'SP', 'RJ', 'RJ', 'SP'),
  preco = c(3000, 2000, 1500, 3200, 2100, 1400, 200, 300, 180, 1600),
  vendas = c(3, 10, 5, 2, 8, 6, 20, 15, 25, 7)
)
t.test(vendas ~ cidade, data = dados)
# t.test() está comparando a média de vendas em cada cidade
# interpretação:
# a média de vendas é maior no RJ, porém não há evidência estatística que explique essa diferença (p-value = 0.8), ou seja, é provável que seja a hipótese nula, uma coincidência

# Usando correlação com teste
cor.test(dados$preco, dados$vendas)
# cor = -0.86: indício promissor de correlação negativa
# p-value = 0.001: hipótese não nula, é improvável que seja coincidência