# parte 1

# q1
notas = c(7, 8, 5, 10, 6)
mean(notas)
notas[notas > 7]

# q2
dados = data.frame(
  nome = c('Ana', 'João', 'Pedro'),
  idade = c(20, 25, 22),
  nota = c(8, 7, 9)
)
dados |>
  select(nome)
dados |> 
  filter(nota > 7)

# q3
categorias <- c('baixo', 'médio', 'alto', 'médio')
categorias <- factor(categorias)

# parte 2

dados <- data.frame(
  produto = c('Fone', 'Teclado', 'Mouse', 'Fone', 'Mouse'),
  preco = c(100, 200, 50, 120, 60),
  vendas = c(5, 2, 10, 3, 8)
)

# q4
dados |> 
  filter(preco > 80)

# q5
dados |> 
  select(produto, vendas)

# q6
dados |> 
  mutate(faturamento = preco * vendas)

# parte 3

# q7
# 1 - total de vendas por produto: fone(8) - mouse(18) - teclado(2)
dados |> 
  group_by(produto) |> 
  summarise(total_vendas = sum(vendas))
# 2 - média de preço por produto: fone(110) - mouse(55) - teclado(200)
dados |> 
  group_by(produto) |> 
  summarise(media_preco = mean(preco))

# q8
dados2 <- data.frame(
  produto = c('Fone', 'Fone', 'Mouse', 'Mouse'),
  cidade = c('SP', 'RJ', 'SP', 'RJ'),
  vendas = c(5, 10, 8, 12)
)
dados2 |> 
  group_by(produto, cidade) |> 
  summarise(total_vendas = sum(vendas))

# q9
# produto que tem o maior faturamento total: fone(980)
dados |>
  mutate(faturamento = preco * vendas) |> 
  group_by(produto) |> 
  summarise(total_faturamento = sum(faturamento)) |> 
  arrange(desc(total_faturamento))

# desafio final
# produto que tem o maior desempenho médio de vendas (considerando apeans produtos com ocorrência > 1): mouse(9)
dados |> 
  group_by(produto) |> 
  summarise(
    ocorrencia = n(),
    media_venda = mean(vendas)
    ) |> 
  filter(ocorrencia > 1) |> 
  arrange(desc(media_venda))

