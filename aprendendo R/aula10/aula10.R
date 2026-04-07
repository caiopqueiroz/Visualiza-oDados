# ggplot2 = mostrar dados 
# Sua estrutura básica é formada por:
# ggplot() - define os dados
# aes() - define os eixos x e y
# geom_ - tipo de gráfico

dados <- data.frame(
  produto = c('A', 'B', 'C', 'B'),
  preco = c(100, 200, 50, 220),
  vendas = c(20, 10, 40, 2)
)

# Gráfico de dispersão - mostra relação entre preço e vendas 
ggplot(dados, aes(x = preco, y = vendas)) + 
  geom_point()

# Gráfico de barras - cada barra é um valor
ggplot(dados, aes(x = produto, y = vendas)) +
  geom_col()

# Contagem automática - conta quantas vezes cada produto aparece
ggplot(dados, aes(x = produto)) +
  geom_bar()
