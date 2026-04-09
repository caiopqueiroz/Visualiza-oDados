dados <- data.frame(
  produto = c('Fone', 'Teclado', 'Mouse', 'Fone', 'Mouse', 'Teclado', 'Mouse', 'Fone'),
  cidade = c('SP', 'SP', 'RJ', 'RJ', 'SP', 'RJ', 'RJ', 'SP'),
  preco = c(100, 200, 50, 120, 60, 210, 55, 110),
  vendas = c(5, 2, 10, 3, 8, 1, 6, 4)
  )

# ex01
# pergunta: produtos mais caros vendem menos? 
# objetivo do gráfico: definir a quantidade de vendas de cada produto e comparar com o seu preço médio 
  ggplot(
    dados, 
    aes(x = preco, y = vendas)
  ) +
  geom_point(aes(color = produto)) +
  geom_smooth(method = 'lm', se = FALSE)
# conclusão: sim, de acordo com a linha de tendência do gráfico, quanto mais alto o preço do produto, menos ele vende

# ex02
# pergunta: qual produto vende mais?
# objetivo: gráfico deve mostrar o produto que tem o maior número de vendas, considerando ambas as cidades
dados |> 
  group_by(produto) |> 
  summarise(total_vendas = sum(vendas)) |> 
  ggplot(
    aes(x = reorder(produto, -total_vendas), y = total_vendas)
  ) +
  geom_col()
# conclusão: o produto que mais vende no total é o mouse

# ex03
# pergunta: em qual cidade cada produto vende mais?
# objetivo do gráfico: agrupar os produtos, separar por cidade e comparar a quantidade de vendas em cada uma
# eixo x: produto
# eixo y: total_vendas
# cor: cidade
dados |> 
  group_by(produto, cidade) |> 
  summarise(total_vendas = sum(vendas)) |> 
  ggplot(
    aes(x = reorder(produto, total_vendas), y = total_vendas)
  ) + 
  geom_col(aes(fill = cidade), position = 'dodge')
# conclusão: o teclado e o fone vendem mais em SP, e o mouse vende mais no RJ

# ex04
# pergunta: existe diferença de comportamento entre cidades? 
# objetivo do gráfico: mostrar como cada preço e número de vendas de cada produto se diferencia entre cidades
# gráficos
# eixo x: produto
# eixo y: número de vendas
# cor: cidade

# eixo x: produto
# eixo y: preço médio
# cor: cidade
dados |>
  group_by(produto, cidade) |> 
  summarise(total_vendas = sum(vendas)) |> 
  ggplot(
    aes(x = reorder(produto, -total_vendas), y = total_vendas) 
  ) +
  geom_col(aes(fill = cidade), position = 'dodge')

dados |> 
  group_by(produto, cidade) |> 
  summarise(preco_medio = mean(preco)) |> 
  ggplot(
    aes(x = reorder(produto, -preco_medio), y = preco_medio)) +
  geom_col(aes(fill = cidade), position = 'dodge')

dados |>
  group_by(produto, cidade) |> 
  summarise(
    preco_medio = mean(preco),
    total_vendas = sum(vendas)) |> 
  ggplot(
    aes(x = preco_medio, y = total_vendas, color = cidade)) +
  geom_point(aes(shape = produto)) +
  geom_smooth(method = 'lm', se = FALSE)

dados |> 
  mutate(faturamento = preco * vendas) |> 
  ggplot(
    aes(x = preco, y = vendas, color = cidade)
  ) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)
# conclusao: o total bruto de vendas é praticamente o mesmo nas duas cidades, sendo que fones e teclados são mais vendidos em SP
# isso pode estar ligado ao preço médio desses dois produtos, que de fato é menor em SP, o mouse por sua vez é menos vendido pois, nessa cidade, é mais caro
# logo, os produtos vendem mais onde custam menos
# constata-se também, como mostra a linha de tendência, que o número total de vendas diminui conforme cresce o preço médio de cada produto
# além disso, tomando como média a linha de tendência, através desse gráfico, é possível notar que tanto a venda de mouses em SP, como de fones no RJ, estão abaixo da linha, ou seja, abaixo da média

# ex05
ggplot(
  dados,
  aes(x = produto, y = vendas)
) +
  geom_col()
# esse gráfico poderia ser enganoso caso o ggplot não agrupasse automaticamente os produtos com o mesmo nome, mas ele é capaz de fazer isso, logo o gráfico já nos mostra o total de vendas por produto

# ex06
# pergunta: qual produto tem o melhor equilíbrio entre preço e volume de vendas?
dados |> 
  group_by(produto) |> 
  summarise(
    total_vendas = sum(vendas),
    preco_medio = mean(preco)) |>
  mutate(eficiencia = total_vendas / preco_medio) |> 
  ggplot(
    aes(x = produto, y = eficiencia, fill = produto)
  ) + 
  geom_col()
# o produto mais equilibrado é o que apresenta maior eficiência, que é a relação direta entre o volume de vendas e o preço médio - é o mouse
