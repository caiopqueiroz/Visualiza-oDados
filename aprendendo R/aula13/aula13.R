# Trabalhando com facetas (múltiplos gráficos automaticamente)
dados <- data.frame(
  produto = c('A', 'B', 'C', 'A', 'B'),
  vendas = c(10, 20, 15, 20, 5),
  cidade = c('X', 'X', 'X', 'Y', 'Y'),
  categoria = c('I', 'I', 'J', 'I', 'I')
)

# Criando gráficos separados por uma variável
ggplot(
  dados,
  aes(
    x = produto,
    y = vendas,
    fill = cidade
  )) +
  geom_col() +
  facet_wrap(~ cidade)

# Versão mais avançada separando linhas e colunas
# Nesse caso, é formada uma 'matriz' de gráficos
# As linhas representam as categorias e as colunas representam as cidades 
ggplot(
  dados,
  aes(
    x = produto,
    y = vendas
  )
) +
  geom_col() +
  facet_grid(categoria ~ cidade)

# Exemplo completo 
dados |> 
  group_by(produto, cidade) |> 
  summarise(total_vendas = sum(vendas)) |> 
  ggplot(
    aes(
      x = produto,
      y = total_vendas,
      fill = produto
    )
  ) +
  geom_col() +
  facet_wrap(~ cidade) +
  theme_minimal() +
  theme(
    legend.position = 'none'
  )
