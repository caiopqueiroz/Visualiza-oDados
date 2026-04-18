# ex 01

# usando o banco de dados 'msleep'
# principais variáveis: 
# nome - sleep_total - awake - brainwt - bodywt
# criar gráficos separados pela variável 'vore', o tipo de dieta do animal 

# ideias: 
# animais mais pesados passam mais tempo acordados?
# dispersão de pontos 
# x: bodywt 
# y: awake
# facet_wrap: vore
msleep |> 
  filter(vore == 'carni' | vore == 'herbi') |>
  ggplot(
  aes(
    x = bodywt,
    y = awake,
    color = vore
  )
) +
  geom_point() +
  facet_wrap(~ vore) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', se = FALSE) +
  theme_classic() +
  theme(
    legend.position = 'none',
    plot.title = element_text(size = 16, face = 'bold')
  ) +
  labs(
    title = 'O peso influencia no tempo acordado?',
    subtitle = 'Há um tendência observada: o peso pode influenciar',
    x = 'Peso em kg',
    y = 'Tempo acordado em horas por dia '
  )


# o peso do cérebro influencia no tempo total de sono? 
msleep |> 
  filter(vore == 'carni' | vore == 'omni') |> 
  ggplot(
    aes(
      x = brainwt,
      y = sleep_total,
      color = vore
    )
  ) +
  geom_point() + 
  scale_x_log10() +
  facet_wrap(~ vore) +
  geom_smooth(method = 'lm', se = FALSE) +
  theme_classic() +
  theme(
    legend.position = 'none',
    plot.title = element_text(size = 14, face = 'bold')
  ) +
  labs(
    title = 'Peso do cérebro influencia no tempo total de sono?',
    subtitle = 'Carnívoros apresentam linha de tendência mais abrupta',
    x = 'Peso do cérebro em kg',
    y = 'Tempo de sono em horas por dia'
  )

# ex02 
dados <- data.frame(
  produto = c('A', 'B', 'C', 'A', 'C'),
  vendas = c(1000, 1500, 750, 500, 2500),
  preco = c(10, 15, 7, 12, 10),
  cidade = c('Pará de Minas', 'Pará de Minas', 'Florestal', 'Florestal', 'Pará de Minas'),
  categoria = c('Fruta', 'Fruta', 'Verdura', 'Fruta', 'Verdura')
)

dados |> 
  group_by(produto, cidade) |> 
  summarise(total_vendas = sum(vendas)) |> 
  ggplot(
    aes(x = produto, 
        y = total_vendas,
        fill = produto,
        label = total_vendas
        )
  ) + 
  geom_text(vjust = -0.5) +
  geom_col() +
  facet_wrap(~ cidade) +
  theme_minimal() +
  theme(
    legend.position = 'none',
    plot.title = element_text(size = 14, face = 'bold')
  ) +
  labs(
    title = 'Pará de Minas tem vendas mais expressivas',
    subtitle = 'Florestal não acompanha no total de vendas e variedade de produtos'
  )
  
# ex03
dados |>
  mutate(faturamento = preco * vendas) |> 
  group_by(produto, categoria, cidade) |> 
  summarise(faturamento_total = sum(faturamento)) |> 
  ggplot(
    aes(
      x = produto,
      y = faturamento_total,
      fill = cidade,
      label = faturamento_total
    )
  ) +
  geom_text(vjust = -0.5) +
  geom_col() +
  facet_grid(categoria ~ cidade) +
  theme_minimal() +
  theme(
    legend.position = 'none',
    plot.title = element_text(face = 'bold', size = 16)
  ) +
  labs(
    title = 'Faturamento gerado por frutas e verduras',
    subtitle = 'Em comparação, Florestal tem números piores',
    x = 'Produto',
    y = 'Faturamento total em reais'
  )

# ex04
# tudo no mesmo gráfico: ruim
dados |> 
  group_by(produto, categoria, cidade) |> 
  summarise(preco_medio = mean(preco)) |> 
  ggplot(
    aes(
      x = produto,
      y = preco_medio,
      fill = cidade,
      label = categoria
    )
  ) + 
  geom_text(nudge_y = 3.5) +
  geom_col(position = 'dodge')

# usando facetas: melhor
dados |> 
  group_by(produto, categoria, cidade) |> 
  summarise(preco_medio = mean(preco)) |> 
  ggplot(
    aes(
      x = produto,
      y = preco_medio,
      fill = cidade,
      label = preco_medio
    )
  ) + 
  geom_label(nudge_y = 1.5) +
  geom_col() +
  facet_grid(categoria ~ cidade) +
  theme(
    legend.position = 'none',
    plot.title = element_text(size = 14, face = 'bold')
  ) +
  labs(
    title = 'Comparação de preço médio entre cidades',
    subtitle = 'Preços similares, porém, variedade maior em PM',
    x = 'Produto',
    y = 'Preço médio do kg'
  )

# ex05
# gráfico de dispersão: faturamento por vendas
dados |> 
  mutate(faturamento = preco * vendas) |> 
  ggplot(
    aes(
      x = faturamento,
      y = vendas,
      color = categoria
    )
  ) + 
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  facet_wrap(~ categoria) +
  scale_x_log10() +
  theme(
    legend.position = 'none',
    plot.title = element_text(face = 'bold', size = 14)
  ) +
  labs(
    title = 'Mais vendas significam maior faturamento',
    subtitle = 'Dados são consistentes para frutas e verduras',
    x = 'Faturamento em reais',
    y = 'Vendas'
  )
