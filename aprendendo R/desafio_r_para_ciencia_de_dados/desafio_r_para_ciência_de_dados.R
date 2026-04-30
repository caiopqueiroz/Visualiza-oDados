dados <- data.frame(
  produto = c('Notebook', 'Celular', 'Tablet', 'Notebook', 'Celular', 'Tablet', 'Fone', 'Teclado', 'Fone', 'Tablet'),
  categoria = c('Eletrônico', 'Eletrônico', 'Eletrônico', 'Eletrônico', 'Eletrônico', 'Eletrônico', 'Acessório', 'Acessório', 'Acessório', 'Eletrônico'),
  cidade = c('SP', 'SP', 'RJ', 'RJ', 'SP', 'RJ', 'SP', 'RJ', 'RJ', 'SP'),
  preco = c(3000, 2000, 1500, 3200, 2100, 1400, 200, 300, 180, 1600),
  vendas = c(3, 10, 5, 2, 8, 6, 20, 15, 25, 7)
)

# nível 1
# 1 
dados |> 
  filter(preco > 1000)

# 2 
dados |> 
  select(c(produto, preco, vendas))

# 3 
dados <- dados |> 
  mutate(faturamento = preco * vendas)
dados

# 4 
dados |> 
  arrange(desc(preco))

# nível 2
# 5 
dados |> 
  group_by(produto) |> 
  summarise(total_vendas = sum(vendas))

# 6
dados |> 
  group_by(categoria) |> 
  summarise(faturamento_total = sum(faturamento))

# 7
dados |> 
  group_by(produto) |> 
  summarise(
    media_vendas = mean(vendas),
    desvio = sd(vendas),
    coeficiente_variacao = desvio / media_vendas
  )

# 8
dados |> 
  group_by(cidade) |> 
  summarise(total_vendas = sum(vendas))
# RJ vende mais no total

# nível 3
# 9 
dados |> 
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
  geom_col() +
  geom_text(vjust = -0.5) +
  theme(
    legend.position = 'none'
  )


# 10
dados |> 
  group_by(categoria) |> 
  summarise(faturamento_total = sum(faturamento)) |> 
  ggplot(
    aes(
      x = reorder(categoria, faturamento_total),
      y = faturamento_total,
      label = faturamento_total,
      fill = categoria
    )
  ) +
  geom_col() +
  geom_text(vjust = -0.5) +
  scale_fill_manual(
    values = c('Eletrônico' = 'blue', 'Acessório' = 'goldenrod')
  ) +
  theme(
    legend.position = 'none'
  )
  
# 11
modelo <- lm(vendas ~ preco, data = dados)
summary(modelo)

cor(dados$preco, dados$vendas)

ggplot(
  dados,
  aes(
    x = preco,
    y = vendas
  )
) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  scale_x_log10()

# 12
ggplot(
  dados,
  aes(
    x = preco,
    y = vendas
  )
) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  scale_x_log10() +
  facet_wrap(~ cidade)

# nível 4
# 13
cor(dados$preco, dados$vendas)

ggplot(
  dados,
  aes(
    x = preco,
    y = vendas
  )
) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  scale_x_log10()

# sim, existe relação negativa forte entre preço e vendas

# 14
dados |> 
  group_by(produto) |> 
  summarise(
    preco_medio = mean(preco),
    total_vendas = sum(vendas)
  ) |> 
  select(preco_medio, total_vendas) |> 
  cor()

dados |> 
  group_by(produto) |>
  summarise(
    preco_medio = mean(preco),
    total_vendas = sum(vendas)
  ) |> 
  ggplot(
    aes(
      x = preco_medio,
      y = total_vendas
    )
  ) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  scale_x_log10()

# a correlação se mantém entre preço médio e total de vendas, mas passa a ser menos forte

# 15
# o celular é o produto que tem o melhor equilíbrio entre preço e vendas porque, em um gráfico de dispersão, é o ponto que mais se aproxima da linha de tendência 

# nível 6
# 16
modelo <- lm(vendas ~ preco, data = dados)

# 17
summary(modelo)
# estimate = -0.006
# significa que a cada +1 no preço, as vendas caem em 0.006

# r-squared = 0.74
# significa que o modelo explica bem, ou seja, cerca de 74% da variação na quantidade de vendas pode estar relacionada com o preço dos produtos

# p-value = 0.001
# significa que se trata de uma análise estatisticamente segura 

# 18
predict(modelo, newdata = data.frame(preco = c(1000, 2500, 4000)))
# 1000: aproximadamente 13 vendas
# 2500: aproximadamente 4 vendas
# 4000: chance de não haver vendas

# 19
cenario = data.frame(preco = seq(500, 4000, 500))
predict(modelo, newdata = cenario)
# 500: aproximadamente 16 vendas
# 1000: aproximadamente 13 vendas
# 1500: aproximadamtente 10 vendas
# 2000: aproximadamente 7 vendas
# 2500: aproximadamente 4 vendas
# 3000: aproximadamente 1 vendas
# 3500 e 4000: chance de não haver nenhuma venda

# padrão observado: com o aumento de 500 reais no preço, há chances de as vendas caírem em 3 unidades

# nível 6 - desafio
# 20 - eu sou um analista

# onde a empresa deve focar para aumentar o faturamento? 

# qual produto fatura mais?  
dados |> 
  group_by(produto) |> 
  summarise(
    faturamento_total = sum(faturamento)
  ) |> 
  arrange(desc(faturamento_total))
# celular: 36800 / tablet: 27100

# qual cidade fatura mais?  
dados |> 
  group_by(cidade) |> 
  summarise(
    faturamento_total = sum(faturamento)
  ) |> 
  arrange(desc(faturamento_total))
# SP fatura o dobro do RJ

dados |> 
  group_by(produto, cidade) |> 
  summarise(
    preco_medio = mean(preco),
    total_vendas = sum(vendas)
  ) |> 
  arrange(cidade)
# tablets são vendidos nas duas cidades, mas o celular só em SP

dados |> 
  group_by(produto, cidade) |> 
  summarise(
    preco_medio = mean(preco),
    total_vendas = sum(vendas)
  ) |> 
  filter(produto == 'Tablet') |> 
  mutate(faturamento = preco_medio * total_vendas)
# tablets faturam mais no RJ, ainda que com menor preço, porque tem mais vendas

# qual categoria fatura mais?  
dados |> 
  group_by(categoria) |> 
  summarise(
    total_vendas = sum(vendas),
    faturamento_total = sum(faturamento)
  ) |> 
  arrange(desc(faturamento_total))

# prevendo a quantidade de vendas do celular, caso o seu preço diminua
modelo <- lm(vendas ~ preco + produto, data = dados)
predict(modelo, newdata = data.frame(
  produto = 'Celular',
  preco = 1900
))
# faturamento atual do celular: 36800
# se ambos os modelos de celulares custassem 1900, venderiam, em média, 9 unidades cada, logo, 1900 * 18, o novo faturamento com celulares seria 34800, então uma diminuição no preço possivelmente não vai aumentar o faturamento 

# conclusões:
# a categoria dos eletrônicos, embora não venda tanto como os acessórios, gera um faturamento muito superior
# celular e tablets são os produtos que mais geram faturamento
# em relação ao tablet, vendê-lo a um preço menor, como feito no RJ, tem se mostrado uma alternativa mais promissora pelo maior faturamento gerado por esse produto nessa cidade
# a cidade de SP gera o dobro de faturamento que RJ, o produto que gera maior faturamento, o celular, não é vendido no RJ

