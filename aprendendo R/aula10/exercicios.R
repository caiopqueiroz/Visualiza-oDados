dados <- data.frame(
  produto = c('Fone', 'Teclado', 'Mouse', 'Fone', 'Mouse'),
  preco = c(100, 200, 50, 120, 60),
  vendas = c(5, 2, 10, 3, 8)
)

# ex01
ggplot(
  dados,
  aes(x = preco, y = vendas)) + 
  geom_point()

# ex02
ggplot(
  dados,
  aes(x = produto, y = vendas)) + 
  geom_col()

# ex03
ggplot(
  dados,
  aes(x = produto)) +
  geom_bar()

# ex04
dados |> 
  group_by(produto) |> 
  summarise(total_vendas = sum(vendas)) |> 
  ggplot(
    aes(x = produto, y = total_vendas)) +
    geom_col()
