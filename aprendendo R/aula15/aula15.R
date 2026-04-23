dados <- data.frame(
  produto = c('A', 'B', 'C'),
  preco = c(10, 20, 15),
  vendas = c(80, 50, 55)
)

dados2 <- data.frame(
  produto = c('A', 'B', 'C'),
  procura = c(100, 200, 250),
  estoque = c(50, 100, 125)
)

# Fazendo correlação simples:
# -1: negativa / 0: não há relação / 1: positiva
cor(dados$preco, dados$vendas)
cor(dados2$procura, dados2$estoque)

# Exibindo matriz de correlação
dados |> 
  select(preco, vendas) |> 
  cor()
dados2 |> 
  select(procura, estoque) |> 
  cor()

# Visualização através de um gráfico de dispersão
ggplot(
  dados,
  aes(
    x = preco,
    y = vendas
  )
) + 
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)

# Dicas de interpretação:
# cor > 0.8: forte relação positiva
# cor < -0.8: forte relação negativa 
# -0.2 < cor < 0.2: relação fraca
# cor = 0: nenhuma relação

# Importante: duas variáveis podem ser correlatas, mas, não necessariamente uma é causadora da outra
