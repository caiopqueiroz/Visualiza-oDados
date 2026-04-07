dados <- data.frame(
  produto = c('Fone', 'Teclado', 'Mouse', 'Fone', 'Mouse', 'Teclado', 'Mouse', 'Fone'),
  cidade = c('SP', 'SP', 'RJ', 'RJ', 'SP', 'RJ', 'RJ', 'SP'),
  preco = c(100, 200, 50, 120, 60, 210, 55, 110),
  vendas = c(5, 2, 10, 3, 8, 1, 6, 4)
)

# ex01
ggplot(
  dados,
  aes(x = preco, y = vendas, color = produto)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)
# existe, de modo geral, quanto menor o preço, maior é o número de vendas

# ex02
dados |> 
  mutate(faturamento = preco * vendas) |> 
  group_by(produto) |> 
  summarise(faturamento_total = sum(faturamento)) |> 
  ggplot(
    aes(x = produto, y = faturamento_total)) +
  geom_col(aes(fill = produto))
# o mouse gera mais faturamento total

# ex03
dados |> 
  mutate(faturamento = preco * vendas) |> 
  group_by(produto, cidade) |> 
  summarise(faturamento_total = sum(faturamento)) |> 
  arrange(cidade) |> 
  ggplot(
    aes(x = produto, y = faturamento_total)) +
    geom_col(aes(fill = cidade), position = 'dodge')
# o faturamento com fones e teclados é maior em SP, já com mouses, é maior no RJ

# ex04
# eficiencia = faturamento total / ocorrencia 
# gráfico será: eixo x = produto, eixo y = eficiencia
dados |> 
  mutate(faturamento = preco * vendas) |> 
  group_by(produto) |> 
  summarise(
    faturamento_total = sum(faturamento),
    ocorrencia = n(),
    eficiencia = faturamento_total / ocorrencia
    ) |> 
  ggplot(
    aes(x = produto, y = eficiencia)) +
  geom_col(aes(fill = produto))
# o mouse é o produto com a maior eficiência

# ex05
# pergunta: o que a empresa precisa focar pra ganhar mais dinheiro? 
# ideias: 
# investir no produto que mais vende
# aumentar a produção desse produto na cidade onde ele é mais vendido 
# diminuir a produção do produto menos vendido, ou, abaixar o seu preço 

ggplot(
  dados,
  aes(x = produto, y = vendas)) +
  geom_col()
# produto mais vendido - mouse
dados |> 
  group_by(cidade, produto) |> 
  summarise(total_vendas = sum(vendas)) |> 
  arrange(desc(total_vendas)) |> 
  ggplot(
    aes(x = produto, y = total_vendas)) +
  geom_point(aes(color = cidade))
# mouse vende o dobro no RJ

dados |> 
  mutate(faturamento = preco * vendas) |> 
  ggplot(
    aes(x = produto, y = faturamento)) +
  geom_col(aes(fill = produto))
# já o teclado vende pouco em qualquer uma das cidades, por mais que seja mais caro, ou seja, deveria retornar mais dinheiro à empresa, na prática isso não é verdade, pois o faturamento gerado por ele é equivalente à metade do faturamento gerado pelos outros produtos 

# conclusão final: 
# a empresa deve aumentar a produção de mouses, tanto no RJ como em SP, mas com foco maior e mais imediato no RJ. E, em adição a isso, seria inteligente e lucrativo também interromper a produção de teclados em ambas as cidades. 