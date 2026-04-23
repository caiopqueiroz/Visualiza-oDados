# 1 
numeros <- c(19, 68, 8, 56, 98, 34, 3, 34, 12, 87)
media <- mean(numeros)
numeros[numeros > media]

# 2
dados <- data.frame(
  nome = c('Caio', 'Júlia', 'Lucas', 'Luiza'),
  idade = c(18, 20, 16, 17),
  nota = c(10, 12, 8, 4.5)
)
dados |> 
  select(nome, nota) |> 
  filter(nota > 7)

# 3
categoria <- c('X', 'Y', 'Z', 'X')
categoria <- factor(categoria)
categoria

# 4
dados |> 
  mutate(aprovado = ifelse(nota > 7, 'Sim', 'Não'))

# 5
dados |> 
  arrange(desc(nota))

# 6
dados2 <- data.frame(
  produto = c('A', 'B', 'C', 'D', 'A', 'B', 'C', 'D'),
  preco = c(10, 15, 7, 20, 20, 20, 10, 15),
  vendas = c(100, 90, 150, 80, 80, 150, 200, 70),
  cidade = c('PM', 'PM', 'PM', 'PM', 'BH', 'BH', 'BH', 'BH'),
  categoria = c('X', 'Y', 'X', 'Y', 'X', 'Y', 'X', 'Y')
)
dados2 <- dados2 |>
  mutate(faturamento = preco * vendas)

# 7
dados2 |> 
  group_by(produto) |> 
  summarise(faturamento_total = sum(faturamento)) |> 
  arrange(desc(faturamento_total))

# 8
dados2 |> 
  group_by(produto) |> 
  summarise(
    total_vendas = sum(vendas),
    media_preco = mean(preco)
  )

# 9 
dados2 |> 
  group_by(produto) |> 
  summarise(total_vendas = sum(vendas)) |> 
  filter(total_vendas > 10)

# 10
dados2 |> 
  group_by(produto) |> 
  summarise(faturamento_total = sum(faturamento)) |> 
  arrange(desc(faturamento_total))

# 11
dados2 |> 
  group_by(produto) |> 
  summarise(total_vendas = sum(vendas)) |> 
  ggplot(
    aes(
      x = reorder(produto, total_vendas),
      y = total_vendas,
      fill = produto,
      label = total_vendas
    )
  ) + 
  geom_text(vjust = -0.5) +
  geom_col() +
  theme_minimal() +
  theme(
    legend.position = 'none',
    plot.title = element_text(size = 16, face = 'bold')
  ) +
  labs(
    title = 'Produto C vende mais',
    subtitle = 'Produto C lidera por mais de 100 unidades'
  )

# 12
ggplot(
  dados2,
  aes(
    x = preco,
    y = vendas
  ) 
) +
  geom_point() +
  scale_x_log10() +
  geom_smooth(method = 'lm', se = FALSE) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = 'bold')
  ) +
  labs(
    title = 'Tendência observada nos produtos',
    subtitle = 'Se o preço aumenta, as vendas caem'
  )

# 13, 14, 15
dados2 |> 
  group_by(produto) |> 
  summarise(faturamento_total = sum(faturamento)) |> 
  ggplot(
    aes(
      x = reorder(produto, -faturamento_total),
      y = faturamento_total,
      fill = produto,
      label = faturamento_total
    )
  ) +
  geom_text(vjust = -0.5) +
  geom_col() +
  theme_classic() +
  theme(
    plot.title = element_text(face = 'bold', size = 14),
    legend.position = 'none'
  ) +
  labs(
    title = 'Produto B apresenta o maior faturamento',
    subtitle = 'Diferença esmagadora do 1º para 2º colocado',
    x = 'Produto',
    y = 'Faturamento em reais'
  )

# 16
dados2 |> 
  group_by(produto, cidade) |> 
  summarise(faturamento_total = sum(faturamento)) |>
  arrange(faturamento_total) |> 
  ggplot(
    aes(
      x = produto,
      y = faturamento_total,
      fill = produto,
      label = faturamento_total
    )
  ) + 
  geom_text(vjust = -0.5) +
  geom_col() +
  facet_wrap(~ cidade) +
  theme(
    plot.title = element_text(size = 14, face = 'bold'),
    legend.position = 'none'
  ) +
  labs(
    title = 'Diferença notável entre cidades',
    subtitle = 'Em BH, o produto B vende mais. Em PM, é o produto D'
  )

# 17 
dados2 |> 
  group_by(produto, cidade, categoria) |> 
  summarise(faturamento_total = sum(faturamento)) |> 
  ggplot(
    aes(
      x = produto,
      y = faturamento_total,
      fill = produto,
      label = faturamento_total 
    )
  ) +
  geom_text(vjust = -0.5) +
  expand_limits(y = max(faturamento_total) * 1.1) +
  geom_col(width = 0.5) +
  facet_grid(categoria ~ cidade) +
  theme_classic() +
  theme(
    legend.position = 'none',
    plot.title = element_text(face = 'bold', size = 14)
  ) +
  labs(
    title = 'Faturamento por cidade e categoria',
    subtitle = 'Maior valor pertence ao produto B em BH'
  )

# 18 
# o gráfico com facetas é melhor porque permite mostrar mais informações sem que seja necessário aglomerar de forma confusa 

# 19
dados2_analise <- dados2 |> 
  group_by(produto) |> 
  summarise(
    media = mean(vendas),
    mediana = median(vendas),
    desvio = sd(vendas),
    coeficiente_variacao = desvio / media
  )

# 20
dados2_analise |> 
  ggplot(
    aes(
      x = reorder(produto, -coeficiente_variacao),
      y = coeficiente_variacao,
      fill = produto,
      label = round(coeficiente_variacao,2)
    )
  ) +
  geom_text(vjust = -0.5) +
  geom_col() +
  theme_classic() +
  theme(
    plot.title = element_text(face = 'bold', size = 14),
    legend.position = 'none'
  ) +
  labs(
    title = 'Produto D apresenta a menor variação',
    subtitle = 'O produto D é o mais consistente. B é o mais instável'
  )



  
