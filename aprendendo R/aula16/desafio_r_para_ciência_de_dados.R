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

# informações:
# produto com maior faturamento: celular 
# eletrônicos faturam mais, no geral
# acessórios vendem mais 
# celular só é vendido em SP

dados |> 
  select(produto, faturamento, vendas) |> 
  arrange(desc(faturamento))

dados |> 
  group_by(categoria) |> 
  summarise(total_vendas = sum(vendas))

dados |> 
  group_by(cidade, produto) |> 
  summarise(
    total_vendas =  sum(vendas),
    preco_medio = mean(preco)
  ) |> 
  arrange(desc(total_vendas))

modelo <- lm(vendas ~ preco + produto, data = dados)
predict(modelo, newdata = data.frame(
  preco = c(2200, 2500, 2800),
  produto = c('Celular', 'Celular', 'Celular')
))

previsao_dados <- data.frame(
  produto = c('Celular Antes', 'Celular Depois'),
  preco = c(2100, 2200),
  previsao_vendas = c(10, 8)
)

previsao_dados |> 
  mutate(faturamento = preco * previsao_vendas) |> 
  ggplot(
  aes(
    x = reorder(produto, faturamento),
    y = faturamento,
    label = faturamento
  )
) + 
  geom_col() +
  geom_text(vjust = -0.5)

# Bom dia, chefe, tudo bem? 
# Onde a empresa deve focar para aumentar o faturamento? Bom, o nosso produto que retorna maior faturamento são os celulares. Eu realizei um cálculo e, utilizando regressão linear, cheguei à conclusão de que é provável que eles não terão queda significativa nas vendas com o aumento do seu preço, é uma análise estatisticamente segura.
# Ainda que não seja o produto com a maior quantidade de vendas, o faturamento é muito superior em relação aos demais. Logo, a depender dos custos, é claro, pode ser uma excelente alternativa para focarmos. Minha sugestão é que inicie a produção de celulares em RJ e a aumente em SP. 



