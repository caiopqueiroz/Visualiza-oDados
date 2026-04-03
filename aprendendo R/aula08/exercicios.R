dados <- data.frame(
  produto = c('Fone', 'Cooler', 'Memória RAM', 'Cooler', 'Cabo HDMI', 'Fone', 'Fone'),
  vendas = c(5, 1, 1, 2, 7, 4, 2)
)

# ex01
dados |> 
  group_by(produto) |> 
  summarise(
    total_vendas = sum(vendas),
    media_vendas_produto = mean(vendas)
  )

# ex02
dados |>
  group_by(produto) |> 
  summarise(
    total_vendas = sum(vendas),
    quantidade_categorias = n()
    )

# ex03
dados2 <- data.frame(
  produto = c('A', 'A', 'B', 'B', 'C'),
  cidade = c('SP','RJ', 'SP', 'RJ', 'SP'),
  vendas = c(10, 20, 15, 25, 30)
)

# Qual o total de vendas por produto e cidade? 
dados2 |> 
  group_by(produto, cidade) |>
  summarise(total_vendas = sum(vendas))

# Qual produto tem a maior média de vendas? 
dados2 |> 
  group_by(produto) |> 
  summarise(media_vendas = mean(vendas)) |> 
  arrange(desc(media_vendas))
# O produto C tem a maior média de vendas 

# ex04
dados2 |> 
  group_by(produto, cidade) |> 
  summarise(media_vendas = mean(vendas)) |> 
  arrange(desc(media_vendas))
# O produto C ainda tem a maior média de vendas considerando a combinação produto + cidade
