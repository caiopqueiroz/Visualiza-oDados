dados <- read_csv('Estudos/VisualizaçãoDados/trabalho_dieta_treino/dados.csv')

colnames(dados) <- c('data_hora', 'exercicios', 'dias_exercicio', 'alimentacao', 'dieta', 'sono', 'bem_estar', 'melhora', 'idade')

dados <- dados |> 
  mutate(
    exercicios = ifelse(dias_exercicio == '0 dias', 'Não', 'Sim')
  )

dados |> 
  arrange(desc(dieta)) |> 
  drop_na(data_hora) |> 
  gt() |> 
  gt_theme_espn()

dados |> 
  ggplot(
    aes(
      x = dieta,
      y = melhora
    )
  ) +
  geom_point() +
  geom_smooth(
    method = 'lm'
  )
  
  
