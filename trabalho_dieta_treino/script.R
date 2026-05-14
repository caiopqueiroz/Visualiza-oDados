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

dados |>
  drop_na(bem_estar) |> 
  ggplot(
    aes(
      x = exercicios
    )
  ) +
  geom_bar()
