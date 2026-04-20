dados <- data.frame(
  produto = c('A', 'B', 'C', 'A', 'B'),
  vendas = c(10, 20, 5, 15, 12),
  preco = c(50, 100, 125, 65, 15),
  cidade = c('PM', 'PM', 'PM', 'BH', 'BH'),
  categoria = c('X', 'Y', 'Y', 'X', 'Y')
)

# Descobrindo o valor médio
mean(dados$vendas)
mean(dados[, 2])

# Descobrindo a mediana (valor do meio)
median(dados$vendas)
median(dados[, 2])

# Descobrindo o desvio padrão
sd(dados$vendas)
sd(dados[, 2])

# Descobrindo a variança 
var(dados$vendas)
var(dados[, 2])

# Descobrindo os valores mínimo e máximo
min(dados$vendas)
min(dados[, 2])
max(dados$vendas)
max(dados[, 2])

# Usando com o dplyr
dados |> 
  summarise(
    media = mean(vendas),
    mediana = median(vendas),
    desvio_padrao = sd(vendas),
    minimo = min(vendas),
    maximo = max(vendas)
  )

# Separando por produto
dados |> 
  group_by(produto) |> 
  summarise(
    media_vendas = mean(vendas),
    desvio_vendas = sd(vendas)
  )


# Visualizando distribuição através de histograma
ggplot(
  dados,
  aes(x = vendas)
  ) +
  geom_histogram()

# Exibindo boxplot
ggplot(
  dados,
  aes(
    x = produto,
    y = vendas
  )
) +
  geom_boxplot()
# Como interpetar um boxplot:
# O alcance total representa todos os valores (excluindo os valores muito discrepantes - outliers)
# A linha mais grossa representa a mediana
# O tamanho da 'caixa' é a diferença entre o 3º e o 1º quartil (1 quartil corresponde a 1/4 dos valores)
  
