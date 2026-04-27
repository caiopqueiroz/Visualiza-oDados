dados <- data.frame(
  produto = c('A', 'B', 'C', 'A', 'B', 'C', 'A', 'B', 'C'),
  preco = c(65, 46, 47, 16, 94, 33, 83, 52, 47),
  vendas = c(176, 48, 244, 365, 914, 529, 471, 433, 113)
)

dados2 <- data.frame(
  produto = c('X', 'Y', 'Z', 'X', 'Y', 'Z', 'X', 'Y', 'Z'),
  preco = c(10, 15, 30, 15, 22.5, 45, 5, 7.5, 15),
  vendas = c(900, 450, 300, 450, 400, 150, 1800, 1200, 450)
)

# ex01 
modelo <- lm(vendas ~ preco, data = dados)
summary(modelo)
# estimate = 5, logo, a cada +1 no preço, as vendas sobem 5 unidades
# r-squared = 0.2, então a explicação é fraca

modelo2 <- lm(vendas ~ preco, data = dados2)
summary(modelo2)
# estimate = -31, logo, a cada +1 no preço, as vendas caem 31 unidades
# r-squared = 0.5, então a explicação é média

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
  scale_x_log10()
# há uma relação fraca entre o aumento do preço e o aumento das vendas

ggplot(
  dados2,
  aes(
    x = preco,
    y = vendas
  )
) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  scale_x_log10() 
# há uma relação média entre o aumento do preço e a diminuição das vendas

# ex03
predict(modelo, newdata = data.frame(preco = 20))
# significa que para um preço de 20, a quantidade de será 186 unidades 
# o predict faz uma previsão com base nas informações já fornecidas, por exemlo, se eu quiser saber quanto venderá, em média, um produto que ainda não existe, com valor 100 reais, posso usar o predict 
predict(modelo, newdata = data.frame(preco = 100))
# resposta: aproximadamente 612 unidades 

# ex04
outro_modelo <- lm(vendas ~ preco + produto, data = dados)
summary(outro_modelo)
# resultado: 
# preco: efeito do preço, ou seja, se o preço subir +1, o produto venderá mais 4 unidades, em média
# produtoB: comparação do produto B com o produto A, ou seja, B vende 81 unidades a mais que A
# produtoC: comparação do produto C com o produto A, ou seja, C vende 18 unidades a mais que A

# ex05
modelo_mtcars <- lm(mpg ~ wt, data = mtcars)
summary(modelo_mtcars)
cor(mtcars$mpg, mtcars$wt)
# a cada +1 no peso, o carro faz -5 milhas por galão? 
# r-squared: 0.75, logo, o modelo é de qualidade 

# ex06
modelo2 <- lm(vendas ~ preco, data = dados2)
summary(modelo2)
# o modelo é significativo 
# a explicação não é fraca 
# ainda não sei interpretar bem o 'estimate'
ggplot(
  dados2,
  aes(
    x = preco,
    y = vendas
  )
) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  scale_x_log10()
cor(dados2$preco, dados2$vendas)
# de acordo com as informações, acredito que reduzir o preço possa sim aumentar as vendas, mas, ainda sim, o r-squared não demonstra um explicação forte, no entanto, o gráfico mostra uma linha de tendência bem clara e a correlação entre as variáveis é negativa forte 
