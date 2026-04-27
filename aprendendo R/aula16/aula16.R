# Regressão linear simples:
# Beta1 é a inclinação, ou seja, significa o efeito que x causa em y 
# Exemplo: x = preço e y = vendas. Se beta1 = -2, então, a cada +1 no preço, as vendas caem 2 unidades, em média

dados <- data.frame(
  produto = c('A', 'B', 'C', 'B'),
  preco = c(10, 20, 30, 25),
  vendas = c(145, 220, 180, 195)
)

# Calculando a regressão
modelo <- lm(vendas ~ preco, data = dados)
summary(modelo)
# Interpretação do summary:
# Estimate: impacto
# p-value: significância
# Multiple R-squared: qualidade do modelo

# p-value: testa se a relação é real 
# valor < 0.05: significativo
# valor > 0.05: pode ser aleatório

# Multiple r-squared: varia de 0 a 1
# valor >= 0.8: modelo explica bem
# valor <= 0.3: explicação fraca 

# Mostrando visualmente a regressão
ggplot(
  dados,
  aes(
    x = preco,
    y = vendas
  )
) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)

