dados <- data.frame(
  produto = c('A', 'A', 'B', 'B', 'C'),
  vendas = c(10, 20, 15, 25, 30),
  categoria = c(1, 1, 1, 1, 2)
)

dados2 <- data.frame(
  nome = c('Júlia', 'Caio', 'Lucas', 'Lucas', 'Júlia', 'Júlia', 'Lucas', 'Caio', 'Caio'),
  nota = c(10, 5, 6.7, 3.5, 8, 6.75, 8, 7, 0)
)

dados3 <- data.frame(
  produto = c('A', 'A', 'B', 'B', 'C', 'C', 'A'),
  cidade = c('SP', 'RJ', 'SP', 'RJ', 'SP', 'RJ', 'SP'),
  vendas = c(10, 20, 15, 25, 30, 35, 10)
)

# Possível pergunta: Qual o total de vendas por produto?
# Preparando os dados 
dados |> 
  group_by(produto)

dados2 |>
  group_by(nome)

# Criando um resumo
# Ou seja, usando o 'summarise' para criar uma nova coluna que soma o número de vendas que se referem ao mesmo produto 
dados |> 
  group_by(produto) |> 
  summarise(total_vendas = sum(vendas))

dados2 |> 
  group_by(nome) |> 
  summarise(nota_final = sum(nota) / 3) |> 
  mutate(aprovado = nota_final >= 6) |> 
  filter(aprovado) |> 
  select(nome)

# Criando várias novas colunas
dados |> 
  group_by(produto) |> 
  summarise(
    total = sum(vendas),
    media = mean(vendas),
    maximo = max(vendas),
    minimo = min(vendas),
    n = n() # Em quantas linhas estava separado antes de ser agrupado 
  )

# Agrupando por mais de uma variável
dados3 |> 
  group_by(produto, cidade) |> 
  summarise(total_vendas = sum(vendas)) |> 
  arrange(desc(total_vendas))

dados3 |> 
  group_by(produto, cidade) |> 
  summarise(
    total = sum(vendas), 
    media = mean(vendas),
    quantidade = n()
  )
