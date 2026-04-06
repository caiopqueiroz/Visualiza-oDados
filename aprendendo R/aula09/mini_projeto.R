library(dplyr)

dados <- data.frame(
  produto = c('Fone', 'Teclado', 'Mouse', 'Fone', 'Mouse', 'Teclado', 'Mouse'),
  cidade = c('SP', 'SP', 'RJ', 'RJ', 'SP', 'RJ', 'RJ'),
  preco = c(100, 200, 50, 120, 60, 210, 55),
  vendas = c(5, 2, 10, 3, 8, 1, 6)
)

# missão: gerar insights para o gerente 
dados |> 
  mutate(faturamento = preco * vendas)

dados |> 
  mutate(faturamento = preco * vendas) |> 
  group_by(produto) |> 
  summarise(
    faturamento_total = sum(faturamento),
    media_vendas = mean(vendas),
    total_vendas = sum(vendas)
    ) |> 
  arrange(desc(faturamento_total))

dados |> 
  mutate(faturamento = preco * vendas) |> 
  group_by(cidade) |> 
  summarise(
    faturamento_total = sum(faturamento),
    media_vendas = mean(vendas),
    total_vendas = sum(vendas)
    ) |> 
  arrange(desc(faturamento_total))
# total de faturamento: 1400(RJ), 1380(SP)
# RJ tem um número bruto de vendas maior, mas a média é a mesma

dados |> 
  mutate(faturamento = preco * vendas) |> 
  group_by(produto, cidade) |> 
  summarise(
    faturamento_total = sum(faturamento),
    total_vendas = sum(vendas)
    ) |> 
  arrange(desc(faturamento_total))
# combinação mais lucrativa: mouse e RJ(830)

dados |> 
  mutate(faturamento = preco * vendas) |> 
  group_by(produto) |> 
  summarise(
    faturamento_total = sum(faturamento),
    modelos = n(),
    eficiencia = faturamento_total / modelos
  ) |> 
  arrange(desc(eficiencia))

dados |> 
  mutate(faturamento = preco * vendas) |> 
  group_by(produto) |> 
  summarise(
    faturamento_total = sum(faturamento),
    total_vendas = sum(vendas),
    preco_medio = faturamento_total / total_vendas
  ) |> 
  arrange(preco_medio)

# o mouse lidera em faturamento total e média de vendas, além disso, se consideramos o seu faturamento separadamente em cada cidade, no RJ lucra 330 a mais do que o segundo item da lista, portanto, é o produto que performa melhor

# RJ é a cidade mais forte, tanto no faturamento total como em no total bruto de vendas, apesar de empatar com SP quando se trata do número médio de vendas

# de maneira geral, os itens mais baratos, como os mouses, apesar do seu baixo preço, geram o maior faturamento em vista da grande quantidade vendida, ou seja, preço baixo = muita venda = muito lucro 

