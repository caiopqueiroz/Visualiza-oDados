dados <- data.frame(
  produto = c('A', 'B', 'C', 'D', 'B'),
  vendas = c(12, 30, 20, 0, 100)
)

# Adicionando informações
ggplot(
  dados,
  aes(x = produto, y = vendas, fill = produto)
) +
  geom_col() +
  labs(
    title = 'Título',
    subtitle = 'Subtítulo',
    x = 'Eixo x',
    y = 'Eixo y',
    caption = 'Fonte dos Dados'
  )

# Tipos diferentes de temas (minimal, classic, dark)
ggplot(
  dados,
  aes(x = produto, y = vendas, fill = produto)
) +
  geom_col() +
  theme_classic()

# Definindo as cores
ggplot(
  dados,
  aes(x = produto, y = vendas),
  scale_fill_manual(values = c('red', 'blue', 'green', 'red'))
) +
  geom_col() 

# Ajustes no texto
ggplot(
  dados,
  aes(x = produto, y = vendas)
) +
  geom_col() +
  labs(
    title = 'Título'
  ) +
  theme(
    plot.title = element_text(size = 16, face = 'bold'),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# Melhorando as barras
ggplot(
  dados,
  aes(x = produto, y = vendas)
) + 
  geom_col(width = 0.5)

# Removendo legenda
ggplot(
  dados,
  aes(x = produto, y = vendas, fill = produto)
) +
  geom_col() +
  theme(legend.position = 'none')

# Criando um gráfico colorido e minimalista
dados |> 
  group_by(produto) |> 
  summarise(total_vendas = sum(vendas)) |> 
  ggplot(
    aes(x = produto, y = total_vendas, fill = produto)
  ) +
  geom_col() +
  labs(
    title = 'Total de Vendas por Produto',
    x = 'Produto',
    y = 'Total de Vendas'
  ) +
  theme_minimal()

# Exemplo completo 
ggplot(
  dados,
  aes(x = reorder(produto, vendas), y = vendas, fill = produto)
) +
  scale_fill_manual(
    values = c('A' = 'red', 'B' = 'blue', 'C' = 'yellow', 'D' = 'green')) +
  geom_col(width = 0.6) +
  labs(
    title = 'Gráfico Total de Vendas x Produto',
    subtitle = 'Saiba qual produto vende mais',
    x = 'Produto',
    y = 'Total de Vendas',
    caption = 'Dados Fictícios'
    ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = 'bold'),
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = 'none'
    )
  

        