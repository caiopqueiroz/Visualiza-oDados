# Carregando pacotes
library(tidyverse)
library(gt)
library(gtExtras)

# Lendo banco de dados
dados <- read_csv('Estudos/VisualizaçãoDados/trabalho_dieta_treino/dados.csv')

# Alterando o nome das variáveis
colnames(dados) <- c('data_hora', 'exercicios', 'dias_exercicio', 'alimentacao', 'dieta', 'sono', 'bem_estar', 'melhora', 'idade')

# Tratando os dados
dados <- dados |> 
  mutate(
    exercicios = ifelse(dias_exercicio == '0 dias', 'Não', 'Sim'),
    dias_exercicio = ifelse(dias_exercicio == '0 dias', 0, 
                             ifelse(dias_exercicio == '1 a 2 dias', 1,
                                    ifelse(dias_exercicio == '3 a 4 dias', 3,
                                           ifelse(dias_exercicio == '5 ou mais dias', 5, 'Erro'
  )))),
    sono = ifelse(sono == 'Menos de 5 horas', 4, 
                  ifelse(sono == '5 a 6 horas', 5,
                         ifelse(sono == '6 a 7 horas', 6,
                                ifelse(sono == '7 a 8 horas', 7, 'Erro'
  ))))
  )

# Adicionando a variável id 
dados <- dados |>
  select(- data_hora) |> 
  mutate(
    id = seq(0, 35)
  ) |> 
  relocate(id)

# Exibindo lista com os dados ordenados 
dados |> 
  arrange(id) |> 
  drop_na(exercicios) |> 
  gt() |> 
  gt_theme_espn()



# ---



# Agrupando pelo nível de alimentação e calculando o valor médio do bem-estar
# Ou seja, por exemplo: Qual o nível médio de bem-estar que tem as pessoas que consideram sua alimentação nota 0? 
# Relacionando alimentação a bem-estar 
dados |> 
  filter(alimentacao > 0) |> 
  group_by(alimentacao) |> 
  summarise(
    media_bem_estar = mean(bem_estar)
  ) |> 
  ggplot(
    aes(
      x = alimentacao,
      y = media_bem_estar,
      label = round(media_bem_estar,2)
    )
  ) +
  geom_col() +
  geom_text(vjust = -0.5)
# Nota-se que as pessoas que tem a alimentação melhor se tem melhor bem-estar físico e mental

# Relacionando dieta a bem-estar
dados |> 
  group_by(dieta) |> 
  summarise(
    media_bem_estar = mean(bem_estar)
  ) |> 
  drop_na(dieta) |> 
  ggplot(
    aes(
      x = dieta,
      y = media_bem_estar,
      label = round(media_bem_estar,2)
    )
  ) +
  geom_col() +
  geom_text(vjust = -0.5)
# Possível alerta: pessoas que seguem parcialmente uma dieta são as que se sentem piores

# Número de ocorrências de cada nível de alimentação 
dados |> 
  drop_na(alimentacao) |> 
  ggplot(
    aes(
      x = alimentacao,
      fill = 'green'
    )
  ) +
  geom_density(
    linewidth = 0.75
  )

# Número de ocorrências de cada nível de bem-estar 
dados |>
  drop_na(bem_estar) |> 
  ggplot(
    aes(
      x = bem_estar,
      fill = 'green'
    )
  ) +
  geom_density(
    linewidth = 0.75
  )

# Número de ocorrências de pessoas que treinam e não treinam
dados |>
  drop_na(bem_estar) |> 
  ggplot(
    aes(
      x = exercicios
    )
  ) +
  geom_bar()

# Pessoas que praticam exercícios tem melhor bem estar? 
dados |> 
  drop_na(exercicios) |> 
  group_by(exercicios) |> 
  summarize(
    media_bem_estar = mean(bem_estar)
  )
# Sim, a média de nota para o bem estar é maior entre as pessoas que praticam exercícios

# Pessoas que dormem mais tem melhor bem estar?
dados |> 
  drop_na(sono) |> 
  group_by(sono) |> 
  summarize(
    media_bem_estar = mean(bem_estar)
  )
# Fato curioso: A média de nota para o bem estar é maior entre as pessoas com 5 horas de sono

# Pessoas que percebem melhora com a alimentação balanceada e o treino realmente treinam e comem bem?
dados |> 
  filter(melhora %in% c(4, 5)) |> 
  count(exercicios == 'Sim')
# A grande maioria das pessoas que percebem grande melhora com o treino e alimentação realmente treinam

dados |> 
  filter(melhora %in% c(4, 5)) |> 
  count(dias_exercicio %in% c(3, 5))
# Fato curioso: Mas menos da metade treina pelo menos 3 dias por semana

dados |> 
  filter(melhora %in% c(4, 5)) |> 
  count(alimentacao %in% c(3, 4, 5))
# Mas de fato a maioria considera sua alimentação equilibrada

# Ou seja, por mais que quase todas as pessoas notem uma melhora muito alta ao conciliar treino e alimentação, a maioria das pessoas pratica exercícios físicos 2 vezes ou menos por semana

# Pessoas que consideram sua alimentação boa seguem dieta?
dados |> 
  filter(alimentacao %in% c(4, 5)) |> 
  count()
  
dados |> 
  filter(alimentacao %in% c(4 ,5)) |> 
  filter(dieta %in% c(4, 5)) |> 
  count()
# Fato curioso: Apenas um terço das pessoas que dizem ter uma alimentação muito boa seguem um plano alimentar de forma rigorosa


