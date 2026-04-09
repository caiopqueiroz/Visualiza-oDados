# O gráfico errado pode levar a uma conclusão errada

dados <- data.frame(
  produto = c('A', 'B', 'C'),
  preco = c(10, 20, 5),
  vendas = c(100, 50, 400)
)
# Gráfico de dispersão - geom_point()
# Usar quando precisar ver relação entre 2 variáveis diferentes, e não comparar qual preço é maior, por exemplo
ggplot(
  dados,
  aes(x = preco, y = vendas)
) +
  geom_point()

# Gráfico de barras - geom_col()
# Usar quando precisar comparar valores dentro de uma mesma coluna (categoria), como por exemplo, faturamento por produto
dados |> 
  mutate(faturamento = preco * vendas) |> 
  ggplot(
    aes(x = produto, y = faturamento)
  ) + 
  geom_col()

# Gráfico de linha - geom_line()
# Usar quando houver passagem de tempo, como por exemplo, vendas ao longo dos meses 
dados2 <- data.frame(
  meses = c(1, 2, 3),
  vendas = c(20, 50, 70)
)

ggplot(
  dados2,
  aes(x = meses, y = vendas)
) +
  geom_line()

# Gráfico de barras lado a lado - geom_col(position = 'dodge')
# Usar quando comparar grupos dentro de categorias, como por exemplo, preço entre produtos
ggplot(
  dados,
  aes(x = produto, y = preco)
) +
  geom_col(aes(fill = produto), position = 'dodge')
