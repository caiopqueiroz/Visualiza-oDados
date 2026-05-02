dados <- data.frame(
  produto = c('A', 'B', 'C', 'D', 'E', 'A', 'B', 'D', 'A', 'C'),
  preco = c(10, 20, 30, 40, 50, 15, 22, 35, 7.5, 28),
  vendas = c(100, 80, 70, 50, 20, 90, 75, 50, 200, 60),
  cidade = c('PM', 'PM', 'PM', 'BH', 'BH', 'BH', 'PM', 'BH', 'PM', 'BH'),
  categoria = c('X', 'X', 'X', 'X', 'Y', 'X', 'X', 'X', 'X', 'X')
)


# Fase 4 - Revisão completa 

# 1 - correlação 
# cor() - cor.test()

# Mede relação linear entre duas variáveis numéricas
cor(dados$preco, dados$vendas)
cor.test(dados$preco, dados$vendas)

# Correlação é diferente de causalidade.

# 2 - regressão linear
# lm()

# O quanto as vendas mudam quanto o preço aumentar 1 unidade
# Checando se o 1º (vendas) muda de acordo com o 2º (preço) 
modelo <- lm(vendas ~ preco, data = dados)
summary(modelo)

# 3 - previsão
# predict()

# Média de vendas esperada caso o preço seja 10
predict(modelo, newdata = data.frame(preco = 10))

# Simulando cenários
cenario <- data.frame(preco = seq(0, 50, 5))
predict(modelo, newdata = cenario)

# 4 - teste t
# t.test()

# Responde se a média do 1º (vendas) agrupada de acordo com o 2º (cidade) é real ou acaso
t.test(vendas ~ cidade, data = dados)

# 5 - ANOVA - comparar mais de 2 grupos 

# p-value < 0.05: pelo menos um grupo é diferente
anova <- aov(vendas ~ produto, data = dados)
summary(anova)

# 6 - Tukey 

# Mostra quais grupos são diferentes
TukeyHSD(anova)

# Interpretação:
# y ~ x:  y é explicado por x / x explica y 
# y: variável numérica que você quer explicar 
# x: variável que explica (grupo ou fator)

# Exemplo:
# preco ~ categoria + produto: o preço depende da categoria e do produto?
aov(preco ~ categoria + produto, data = dados)
