# Pipeline 
# Use isso e, com o resultado, faça aquilo

dados <- data.frame(
  produto = c('Fone', 'Teclado', 'Mouse', 'Fone', 'Mouse'),
  preco = c(100, 200, 50, 120, 60),
  vendas = c(5, 2, 10, 3, 8)
)

# ex01
dados |> 
  mutate(faturamento = preco * vendas)

# ex02
dados |> 
  mutate(faturamento = preco * vendas) |> 
  group_by(produto) |> 
  summarise(faturamento_total = sum(faturamento))

# ex03
dados |> 
  mutate(faturamento = preco * vendas) |> 
  group_by(produto) |> 
  summarise(
    faturamento_total = sum(faturamento),
    media_vendas = mean(vendas)
  ) |> 
  arrange(desc(faturamento_total))

# ex04
dados |> 
  mutate(faturamento = preco * vendas) |> 
  group_by(produto) |> 
  summarise(
    faturamento_total = sum(faturamento),
    numero_vendas = n(),
    eficiencia = faturamento_total / numero_vendas
  ) |> 
  arrange(desc(eficiencia))
