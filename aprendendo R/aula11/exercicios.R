dados <- data.frame(
  produto = c('Notebook', 'Smartphone', 'Tablet', 'Notebook', 'Smartphone', 'Tablet', 'Fone', 'Teclado'),
  categoria = c('Eletrônicos', 'Eletrônicos', 'Eletrônicos', 'Eletrônicos', 'Eletrônicos', 'Eletrônicos', 'Acessórios', 'Acessórios'),
  cidade = c('SP', 'SP', 'RJ', 'RJ', 'SP', 'RJ', 'SP', 'RJ'),
  preco = c(3500, 2000, 1500, 3700, 2100, 1400, 200, 300),
  vendas = c(3, 10, 5, 2, 8, 6, 20, 15)
)

# ex01
# pergunta: produtos mais caros vendem menos? 
# quero analisar 2 variáveis dos produtos - preço e vendas - logo, gráfico de dispersão
dados |> 
  group_by(produto, categoria) |> 
  summarise(
    total_vendas = sum(vendas),
    preco_medio = mean(preco)
    ) |> 
  ggplot(
    aes(x = preco_medio, y = total_vendas)
  ) +
  geom_point(aes(color = produto, shape = categoria))
# não necessariamente, o smartphone vende mais que o teclado e o fone, mesmo custando mais caro, mas, por outro lado, o notebook é o produto mais caro de todos e também é o menos vendido, logo o preço não a única coisa que influencia nas vendas

# ex02
# pergunta: qual categoria gera mais faturamento? 
# o produto em si não importa, é necessário separar os produtos por categoria e criar o seu faturamento, como a ideia é comparara faturamentos (1 variável), o gráfico certo é o de barras
dados |> 
  group_by(categoria) |> 
  mutate(faturamento = preco * vendas) |> 
  summarise(faturamento_total = sum(faturamento)) |> 
  ggplot(
    aes(x = categoria, y = faturamento_total)
  ) + 
  geom_col(aes(fill = categoria))
# o que gera mais faturamento são os eletrônicos

# ex03
# pergunta: existe diferença de desempenho entre cidades? 
# agrupar os dados por cidade e comparar a quantidade de vendas de cada produto, usar cores pra diferenciar as categorias - usar gráfico de barras
dados |> 
  group_by(cidade, categoria) |>
  mutate(faturamento = preco * vendas) |> 
  summarise(faturamento_total = sum(faturamento)) |> ggplot(
    aes(x = cidade, y = faturamento_total)
  ) +
  geom_col(aes(fill = categoria), position = 'dodge')

dados |> 
  group_by(cidade, categoria) |> 
  summarise(total_vendas = sum(vendas)) |> 
  ggplot(
    aes(x = cidade, y = total_vendas)
  ) +
  geom_col(aes(fill = categoria), position = 'dodge')
# sim, SP vende mais e, com isso, também fatura mais

# ex04
# pergunta: qual produto vende melhor?
# gráfico bom: colunas comparando quantidade de vendas entre produtos
# gráfico ruim: gráfico de dispersão 
dados |> 
  group_by(produto, categoria) |> 
  summarise(total_vendas = sum(vendas)) |> 
  ggplot(
    aes(x = reorder(produto, total_vendas), y = total_vendas)
  ) +
  geom_col(aes(fill = categoria))
# esse gráfico é bom pois utiliza colunas para comparar 1 variável e está organizado do número menor para o número maior de vendas, facilitando o entendimento rápido dos resultados

ggplot(
  dados,
  aes(x = produto, y = vendas)
) +
  geom_point(aes(color = categoria))
# ruim porque não agrupa os produtos, não organiza e usa dispersão de pontos, o que dificulta o entendimento nesse caso

# ex05
# pergunta: onde a empresa deve focar para aumentar o faturamento?
# primeiro: cálculo do faturamento, depois separar por cidade e por produto
dados |> 
  group_by(cidade, produto, categoria) |> 
  mutate(faturamento = preco * vendas) |> 
  summarise(faturamento_total = sum(faturamento)) |> ggplot(
    aes(x = cidade, y = faturamento_total)
  ) + 
  geom_col(aes(fill = produto), position = 'dodge')
# para aumentar o faturamento, a empresa deve focar em tablets no RJ e em smartphones em SP

# ex06
# gráfico deve mostrar relação entre preço, vendas e categoria - não agrupar pois dispersão é mais eficiente com muitos pontos
ggplot(
  dados,
  aes(x = preco, y = vendas)
) + 
  geom_point(aes(color = categoria, size = vendas))
# nesse gráfico é possível notar que os eletrônicos, em geral, são mais caros que os acessórios, e também vendem menos que eles, com excessão do smartphone