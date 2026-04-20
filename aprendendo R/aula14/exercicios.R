dados <- data.frame(
  produto = c('A', 'B', 'C', 'D', 'E', 'F', 'A', 'B', 'C', 'D', 'E', 'F', 'A', 'C', 'E'),
  vendas = c(23, 43, 56, 51, 62, 92, 9, 95, 2, 88, 39, 41, 96, 59, 3)
)

# ex01
media <- mean(dados$vendas)
mediana <- median(dados$vendas)
desvio <- sd(dados$vendas)
coeficiente_variacao <- desvio / media
# Se o coeficente de variação for maior que 0.3, significa que o desvio padrão é considerado alto

# ex02
dados |> 
  group_by(produto) |> 
  summarise(
    media = mean(vendas),
    mediana = median(vendas),
    desvio = sd(vendas),
    coeficiente_variacao = desvio / media
  ) 
  
# ex03
dados |>  
  group_by(produto) |> 
  summarise(
    media = mean(vendas),
    mediana = median(vendas),
    desvio = sd(vendas),
    comparacao = abs(mediana - media)
  )
# O produto A tem a maior diferença entre a média e a mediana, não atoa é o que apresenta maior desvio também

# ex04
ggplot(
  dados,
  aes(
    x = produto,
    y = vendas,
    fill = produto
  )
) +
  geom_boxplot() +
  theme_minimal() +
  theme(
    legend.position = 'none',
    plot.title = element_text(size = 14, face = 'bold')
  ) +
  labs(
    title = 'Grande variação em alguns produtos',
    subtitle = 'Produto A apresenta grande discrepância nos valores'
  )
# O boxplot de A tem o maior alcance, portanto ele tem a maior variação e, consequentemente, o maior desvio 
# Já no produto C, a mediana é muito próxima do valor máximo
# Nos produtos B, D e F, o boxplot é muito simétrico, mas isso só acontece porque neles só existem 2 valores de vendas

# ex05
ggplot(
  dados,
  aes(
    x = vendas
  )
) +
  geom_histogram(
    bins = 10,
    fill = 'blue'
  ) +
  scale_x_log10()
# Não consegui interpretar muito bem, mas acredito que nesse caso os dados não são muito equilibrados

# ex06
dados |> 
  group_by(produto) |> 
  summarise(
    desvio = sd(vendas),
    media = mean(vendas),
    coeficiente_variacao = desvio / media
  ) |> 
  ggplot(
    aes(
      x = reorder(produto, coeficiente_variacao),
      y = coeficiente_variacao,
      fill = produto,
      label = round(coeficiente_variacao,2)
    ) 
  ) +
  geom_text(vjust = -0.5) +
  expand_limits(y = max(coeficiente_variacao) * 1.1) +
  theme_classic() +
  theme(
    plot.title = element_text(size = 14, face = 'bold'),
    legend.position = 'none'
  ) +
  geom_col() +
  labs(
    title = 'Altíssima variação nos produtos',
    subtitle = 'Produto A se destaca com coficiente superior a 100%'
  )
# O produto que mais se aproxima de ser consistente é o produto D, mas ainda sim tem um coeficiente maior que 0.3, os demais todos tem taxas altíssimas de variação, superiores a 50%


