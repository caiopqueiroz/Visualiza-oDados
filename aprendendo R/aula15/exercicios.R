dados <- data.frame(
  produto = c('A', 'B', 'C', 'D', 'B', 'C'),
  vendas = c(20, 15, 18, 20, 5, 40),
  preco = c(15, 10, 5, 25, 30, 10)
)

# ex01
cor(dados$preco, dados$vendas)
# ou 
dados |> 
  select(preco, vendas) |> 
  cor()

# ex02 
ggplot(
  dados,
  aes(
    x = preco,
    y = vendas
  )
) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = 'bold')
  ) +
  labs(
    title = 'Relação entre quantidade de vendas e preço',
    subtitle = 'A diminuição nas vendas está associada ao aumento do preço'
  )
# a relação entre preço e vendas, nesse caso, é médio-negativa

# ex03
# verificando correlação:
dados |> 
  group_by(produto) |> 
  summarise(
    total_vendas = sum(vendas),
    preco_medio = mean(preco)
  ) |> 
  select(total_vendas, preco_medio) |> 
  cor()

# Visualizando através de um gráfico:
dados |> 
  group_by(produto) |> 
  summarise(
    total_vendas = sum(vendas),
    preco_medio = mean(preco)
    ) |>
  ggplot(
    aes(
      x = preco_medio,
      y = total_vendas
    )
  ) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  theme_classic() +
  theme(
    plot.title = element_text(size = 14, face = 'bold')
  ) +
  labs(
    title = 'Forte correlação entre total de vendas e preço médio',
    subtitle = 'O gráfico mostra que a queda nas vendas se relaciona com o aumento do preço do produto'
  )

# ex04
dados2 <- data.frame(
  produto = c('A', 'B', 'C'),
  preco = c(20, 30, 100),
  vendas = c(1000, 900, 500)
)
cor(dados2$preco, dados2$vendas)
# correlação negativa forte 

dados3 <- data.frame(
  produto = c('A', 'B', 'C'),
  demanda = c(2000, 1500, 500),
  estoque = c(3500, 2000, 700)
)
cor(dados3$demanda, dados3$estoque)
# correlação positiva forte

# ex05
library(tidyverse)
cor(mtcars$wt, mtcars$hp)
# 0.65
# existe relação positiva moderada entre o peso de um carro e seus cavalos de potência

cor(mtcars$carb, mtcars$mpg)
# -0.55
# existe relação médio-negativa entre a quantidade de carburadores a quantidade de milhas por galão que um carro faz

cor(mtcars$mpg, mtcars$wt)
# -0.86
# existe relação negativa forte entre a quantidade de milhas por galão e o peso do carro, ou seja, quanto mais pesado o veículo, menor a distância que ele consegue fazer com uma quantidade x de gasolina

# ex06
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
  theme_classic() +
  theme(
    plot.title = element_text(size = 16, face = 'bold')
  ) +
  labs(
    title = 'Gráfico vendas por preço',
    subtitle = 'Há uma relação sutil entre as vendas e o aumento de preço'
  )
# de acordo com o banco 'dados', o peso se relaciona sim às vendas, mas é uma relação de força média