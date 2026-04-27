dados <- data.frame(
  produto = c('X', 'Y', 'Z', 'Y', 'Z'),
  preco = c(4.90, 16.99, 39.90, 14.50, 45.90),
  vendas = c(128, 114, 89, 147, 42)
)

# ex01
modelo <- lm(vendas ~ preco, data = dados)
summary(modelo)
# beta1 = -2
# isso significa que, com o aumento de 1 no preço, as vendas caem, em média 2 unidades

# ex02
# o r-squared é igual a 0.78, ou seja, o modelo explica que cerda de 78% da alteração nas vendas é pelo preço, logo, alterar o preço pode ter um impacto real nas vendas
# o p-value vale 0.04, ou seja, a relação é estatisticamente significativa

# ex03
predict(modelo, newdata = data.frame(preco = c(10, 50)))
# com o preço 10, as vendas serão 133, em média
# já com o preço 50, as vendas serão 51, em média

# ex04
cenario <- data.frame(preco = seq(0, 50, 5))
predict(modelo, newdata = cenario)
# as vendas caem, em média, 10 unidades a cada aumento de 5 reais no preço 

# ex05
predict(modelo, newdata = data.frame(preco = c(2.5, 59.90)))
# com um preço baixo, espera-se que as vendas sejam muito mais altas em comparação com um preço alto

# ex06 
modelo = lm(vendas ~ preco + produto, data = dados)
predict(modelo, newdata = data.frame(
  preco = 38.90,
  produto = 'Z'
))
# Usando o comportamento do produto Z em relação ao produto de referência (X) e o comportamento do preço para fazer a previsão, vemos que a sua venda de Z será, em média, 100 unidades caso o preço seja 38.90 

# ex07
modelo = lm(vendas ~ preco, data = dados)
predict(modelo, newdata = data.frame(preco = dados$preco - 10))
