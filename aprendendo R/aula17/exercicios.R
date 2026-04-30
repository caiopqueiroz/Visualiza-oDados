# recapitulando:
produtoA <-  data.frame(
  preco = c(10, 20, 15, 17.5, 12.5, 30),
  vendas = c(50, 30, 45, 32, 40, 5),
  cidade = c('SP', 'SP', 'SP', 'RJ', 'RJ', 'RJ'),
  categoria = c('Eletrônico', 'Eletrônico', 'Eletrônico', 'Eletrônico', 'Eletrônico', 'Eletrônico')
)

# possíveis análises:
# correlação / regressão linear / média 

cor(produtoA$preco, produtoA$vendas)
# cor = -0.97
# indício de relação negativa forte

modelo <- lm(vendas ~ preco, data = produtoA)
summary(modelo)
# r-squared = 0.95
# p-value = 0.0009
# preco = -2.2
# preço pode se relacionar à vendas de modo estatístico
predict(modelo, newdata = data.frame(
  preco = mean(produtoA$preco)
))
# previsão para preço 17.5 = 33.66

t.test(vendas ~ cidade, data = produtoA)
# p-value = 0.27
# média em SP > média no RJ: mas não há evidência estatística que explique essa diferença

t.test(preco ~ cidade, data = produtoA)
# p-value = 0.46
# média no RJ > média em SP: mas não há evidência estatística que explique essa diferença

# nível 1

dados <-  data.frame(
  produto = c('A', 'A', 'A', 'A', 'A', 'A', 'B', 'B', 'B', 'B', 'B', 'B'),
  preco = c(10, 20, 15, 17.5, 12.5, 30, 5, 6, 7.5, 4, 4.5, 5.5),
  vendas = c(50, 30, 45, 32, 40, 5, 100, 89, 71, 120, 110, 99),
  cidade = c('SP', 'SP', 'SP', 'RJ', 'RJ', 'RJ', 'SP', 'SP', 'SP', 'RJ', 'RJ', 'RJ'),
  categoria = c('Eletrônico', 'Eletrônico', 'Eletrônico', 'Eletrônico', 'Eletrônico', 'Eletrônico', 'Acessório', 'Acessório', 'Acessório', 'Acessório', 'Acessório', 'Acessório')
)

# 1
t.test(vendas ~ cidade, data = dados)
# há pouca diferença entre as médias, mas não há evidência estatística para essa diferença

# 2
cor.test(dados$vendas, dados$preco)
# indício promissor de relação negativa
# p-value indica hipótese não nula, ou seja, é improvável que seja coincidência

# nível 2
# 3
t.test(vendas ~ categoria, data = dados)
# há grande diferença entre as médias (65) e, como p-value < 0.05, significa que há evidências estatísticas para essa diferença, ou seja, há indícios de que não é aleatória

# 4
t.test(preco ~ cidade, data = dados)
# há evidências estatísticas de que o preço médio entre cidades varie aleatoriamente 

# nível 3
# 5
dados |> 
  filter(produto == 'A') -> dados_A
t.test(vendas ~ cidade, data = dados_A)
# p-value = 0.27 
# há diferença entre as médias de vendas (16), mas não há evidências estatísticas para isso

# 6 
cor.test(dados$preco, dados$vendas)
# há indícios sim que o preço se relaciona de forma negativa com as vendas uma vez que cor = -0.92 e p-value < 0.05

# nivel 4
# 7
cor.test(dados$preco, dados$vendas)
# cor = -0.92
# p-value = 0.00002

# conclusão clara:
# também existe evidência indicadora de que as vendas diminuem com o aumento do preço (p-value = 0.00002), uma relação negativa (-0.92) 