dados <- data.frame(
  produto = c('Notebook', 'Teclado', 'Celular', 'Estojo', 'Caneta', 'Lapiseira', 'Borracha', 'Borracha', 'Celular'),
  categoria = c('Eletrônico', 'Periférico', 'Eletrônico', 'Escolar', 'Escolar', 'Escolar', 'Escolar', 'Escolar', 'Eletrônico'),
  preco = c(2000, 110, 1800, 30, 2.5, 7, 2, 1.5, 2500),
  vendas = c(3, 20, 15, 7, 8, 45, 10, 50, 20),
  estado = c('MG', 'MG', 'SP', 'RS', 'MG', 'MG', 'MG', 'MG', 'SP')
)

# ex01
# gráfico simples: preço médio por produto
dados |> 
  group_by(produto, categoria) |> 
  summarise(preco_medio = mean(preco)) |> 
  ggplot(
    aes(x = reorder(produto, preco_medio), y = preco_medio, fill = categoria)
  ) +
  geom_col(width = 0.6) +
  labs(
    title = 'Gráfico Preço Médio por Produto',
    subtitle = 'Gritante diferença de preço entre os produtos',
    x = 'Produto',
    y = 'Preço médio'
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = 'bold'),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# ex02
# mostrar faturamento por categoria
dados |> 
  mutate(faturamento = preco * vendas) |> 
  group_by(categoria) |> 
  summarise(faturamento_total = sum(faturamento)) |> 
  ggplot(
    aes(x = reorder(categoria, faturamento_total), y = faturamento_total, fill = categoria, label = faturamento_total)
      ) +
  geom_text(nudge_y = 5000) +
  scale_fill_manual(values = c('Escolar' = 'darkred', 'Periférico' = 'goldenrod', 'Eletrônico' = 'darkblue')) +
      geom_col(width = 0.7) +
  theme_classic() +
  theme(
    legend.position = 'none',
    plot.title = element_text(size = 14, face = 'bold'),
  ) +
  labs(
    title = 'Gráfico Faturamento por Categoria',
    subtitle = 'Eletrônicos dominantes',
    x = 'Categoria',
    y = 'Faturamento em reais'
  )

# ex03
# gráfico com nomes longos
provas <- data.frame(
  materia = c('Geometria Analítica e Álgebra Linear', 'Matemática Elementar'),
  nota = c(13.5, 24)
)
ggplot(
  provas,
  aes(x = materia, y = nota, fill = materia, label = nota)
) +
  geom_text(nudge_y = 1) +
  geom_col() +
  labs(
    title = 'Respectivas notas nas provas do Curso de Matemática',
    x = 'Matéria',
    y = 'Nota'
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 10, face = 'bold'),
    axis.text.x = element_text(angle = 15, hjust = 0.65, vjust = 0.65),
    legend.position = 'none'
  )

# ex04
brasileiro <- data.frame(
  time = c('Cruzeiro', 'Atlético-MG', 'América-MG'),
  gols = c(86, 95, 41)
)
ggplot(
  brasileiro,
  aes(x = time, y = gols, fill = time, label = gols)
) +
  geom_text(nudge_y = 3) +
  scale_fill_manual(values = c('Cruzeiro' = 'blue', 'Atlético-MG' = 'black', 'América-MG' = 'green')) +
  geom_col(width = 0.7) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = 'bold'),
    legend.position = 'none'
  ) +
  labs(
    title = 'Gols Marcados na Temporada 2025',
    subtitle = 'Atlético-MG se sobressai em Minas Gerais',
    x = 'Clube',
    y = 'Gols'
  )
# escolhi essas cores porque são as cores de cada time 

# ex05
# gráfico bonito para colocar no linkedin
# ideias:
# buscar por dados de alguma empresa e construir um gráfico apontando algo (sugestão de melhoria ou apontar um problema existente)
# criar um gráfico com a evolução das minhas cargas na academia
# eixo x: exercício
# eixo y: carga
# cores: 1 ano atrás x atualmente
# colocar uma coluna sobre a outra, a ideia é que a coluna que representa 1 ano atrás fique por cima da outra, já que será sempre menor 
academia <- data.frame(
  exercicio = c('Pulley Frente', 'Supino Reto', 'Elevação Lateral', 'Rosca Alternada', 'Tríceps Barra', 'Agachamento', 'Pulley Frente', 'Supino Reto', 'Elevação Lateral', 'Rosca Alternada', 'Tríceps Barra', 'Agachamento'),
  carga = c(70, 34, 14, 20, 73, 20, 55, 24, 10, 14, 45, 25),
  data = c('2026', '2026', '2026', '2026', '2026', '2026', '2025', '2025', '2025', '2025', '2025', '2025')
)
ggplot(
  academia,
  aes(
    x = reorder(exercicio, carga), 
    y = carga, 
    fill = data
    )) +
  scale_fill_manual(values = c('2025' = 'gray70', '2026' = 'blue')) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 20, hjust = 1),
    plot.title = element_text(size = 16, face = 'bold'),
    legend.position = c(0.15, 0.8)
  ) +
  geom_col(position = 'dodge', width = 0.6) +
  labs(
    title = 'Carga Máxima em Cada Exercício',
    subtitle = 'Pernas não acompanharam a evolução do corpo em 1 ano',
    x = 'Exercício',
    y = 'Peso em kg',
    fill = 'Ano'
  )
