dados <- data.frame(
  produto = c('A', 'B', 'C'),
  preco = c(10, 15, 5),
  vendas = c(20, 10, 30)
)

# Regressão linear: criação de um modelo
# Modelo: é uma reta que tenta explicar os dados
# beta0: é o valor de y quano x = 0
# beta1: é o valor somado a y quando x aumenta +1

# Exemplo concreto:
modelo <- lm(vendas ~ preco, data = dados)
summary(modelo)

# Interpretação: 

# beta0 = intercept = 4
# beta1 = preco = -2
# A cada aumento de 1 unidade no preço, as vendas diminuem, em média, 2 unidades

# Multiple R-squared = 1 
# Significa que o modelo explica bem o comportamento das vendas em relação ao preço, ele é um modelo de previsão confiável
# Nesse caso, como é 1, ele explica 100%, ou seja, 100% da variação nas vendas é explicada pelo preço

# p-value = 3.199e-16  
# Responde se a relação é real ou aleatória
# Se o p-value for maior que 0.05, significa que pode ser acaso
# Nesse exemplo, como p-value < 0.05, há evidência estatística de relação entre preço e vendas

# Uso de predição:
# Uso do modelo para calcular: qual valor de y esperamos para um novo x?
modelo <- lm(vendas ~ preco, data = dados)
predict(modelo, newdata = data.frame(preco = 7.5))
# Interpretação:
# Se um produto custar 7.5, espera-se que ele venda 25 unidades

# Retornando várias previsões
predict(modelo, newdata = data.frame(preco = c(7.5, 11, 12, 4.90)))

# Criando cenário
cenario <- data.frame(preco = seq(1, 19, 2))
# Significa um cenário que contém os preços 1 até o 19 pulando de 2 em 2
predict(modelo, newdata = cenario)

# Usando predict com mais variáveis
predict(modelo, newdata = data.frame(
  preco = 7.5,
  produto = 'B'
))
# Agora é feita uma previsão que depende do preço do produto A
