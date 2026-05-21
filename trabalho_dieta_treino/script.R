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

dados$dias_exercicio <- as.numeric(dados$dias_exercicio)
dados$sono <- as.numeric(dados$sono)

# Adicionando a variável id 
dados <- dados |>
  select(- data_hora) |> 
  mutate(
    id = seq(0, 53)
  ) |> 
  relocate(id)

# Exibindo lista com os dados ordenados 
dados |> 
  arrange(id) |> 
  drop_na(exercicios) |> 
  gt() |> 
  gt_theme_espn()



# ---



# Separando as perguntas por variáveis:

# sono / bem_estar
# Pessoas que dormem mais tem melhor bem estar?

# melhora / alimentacao / exercicios / dias_exercicio
# Pessoas que percebem melhora com a alimentação balanceada e o treino realmente treinam e comem bem?

# alimentacao / dieta
# Pessoas que consideram sua alimentação boa seguem dieta?

# idade / alimentacao
# Pessoas mais jovens se alimentam melhor?

# idade / dias_exercicio
# Pessoas mais jovens treinam mais?

# exercicios / dias_exercicio / dieta
# Quantas pessoas treinam e segue dieta?

# exercicios / dieta / bem_estar
# É realmente necessário treinar e fazer dieta para se sentir bem?
# Pessoas que praticam exercícios tem melhor bem estar?



# ---


# Criando visualizações:

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
      y = as.character(alimentacao),
      x = media_bem_estar,
      label = round(media_bem_estar,2),
      fill = as.character(alimentacao)
    )
  ) +
  scale_fill_manual(
    values = c(
      '5' = 'green2',
      '4' = 'green3',
      '3' = 'green4',
      '2' = 'red3',
      '1' = 'red2'
    )
  ) +
  geom_col() +
  geom_text(
    hjust = 1.5,
    color = 'white',
    size = 8
      ) +
  theme(
    legend.position = 'none'
  )
# Nota-se que as pessoas que tem a alimentação melhor tem melhor bem-estar físico e mental

# Relacionando dieta a bem-estar
dados |> 
  filter(dieta != 5) |> 
  group_by(dieta) |> 
  summarise(
    media_bem_estar = mean(bem_estar)
  ) |> 
  drop_na(dieta) |> 
  ggplot(
    aes(
      x = as.character(dieta),
      y = media_bem_estar,
      label = round(media_bem_estar,2)
    )
  ) +
  geom_col() +
  geom_text(vjust = -0.5)
# As pessoas que seguem uma dieta ou plano alimentar tem melhor bem estar

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
  count(pessoas = ifelse(alimentacao %in% c(4, 5), 'Alimentação boa', 'Alimentação ruim')) |> 
  ggplot(
    aes(
      y = pessoas,
      x = n
    )
  ) +
  geom_col() +
  labs(
    title = 'Pessoas que percebem melhora muito alta ao associar exercício físico e boa alimentação',
    subtitle = 'Quantas delas realmente se alimentam muito bem?'
  )
# Fato curioso: Mas menos da metade considera sua alimentação muito boa 

# Ou seja, por mais que quase todas as pessoas notem uma melhora muito alta ao conciliar treino e alimentação, a maioria das pessoas pratica exercícios físicos 2 vezes ou menos por semana e não come tão bem assim

# Pessoas que consideram sua alimentação boa seguem dieta?
dados |> 
  filter(alimentacao %in% c(4, 5)) |> 
  count(dieta = ifelse(dieta %in% c(4, 5), 'Sigo', 'Não sigo'))
# Fato curioso: Entre as pessoas que consideram sua alimentação muito boa, a maioria diz não seguir à risca uma dieta 

# Pessoas mais jovens se alimentam melhor?
dados |> 
  drop_na(idade) |> 
  group_by(idade) |> 
  summarize(
    media_alimentacao = mean(alimentacao)
  )

dados |> 
  filter(idade == '18 - 21') |> 
  count(alimentacao %in% c(4, 5))

dados |> 
  filter(idade == '26 ou mais.') |> 
  count(alimentacao %in% c(4, 5))

dados |>
  drop_na(idade) |> 
  group_by(idade) |> 
  summarize(
    quantidade_pessoas = n()
  )
# Os dados indicam que os mais jovens se alimentam melhor, mas a resposta é incerta porque só 6 pessoas com mais de 26 anos respondeu a pesquisa 

# Pessoas mais jovens treinam mais?   
dados |> 
  drop_na(idade) |> 
  filter(exercicios == 'Sim') |> 
  group_by(idade) |> 
  summarize(
    media_dias_exercicio = mean(dias_exercicio)
  )

dados |> 
  drop_na(idade) |> 
  group_by(idade, exercicios) |>
  summarize(
    pessoas = n()
  ) |> 
  filter(exercicios == 'Sim')

dados |> 
  drop_na(idade) |> 
  group_by(idade, exercicios) |> 
  summarize(
    pessoas = n()
  ) |> 
  ggplot(
    aes(
      y = idade,
      x = pessoas,
      fill = exercicios
    )
  ) +
  geom_col(position = 'fill')
# Conclusão incerta pela falta de dados, mas:
# idade: 26 ou mais - 100% treinam
# idade: 22 - 25 - +-50%  treinam
# idade: 18 - 21 - +-60% treinam
# idade: 14 - 17 - 100% treinam

# Quantas pessoas treinam e seguem dieta? 
dados |> 
  drop_na() |> 
  filter(exercicios == 'Sim' & dieta != 0) |> 
  count()

dados |> 
  drop_na() |> 
  mutate(
    treino_dieta = ifelse(exercicios == 'Sim' & dieta != 0, 'Sim', 'Não'),
    pessoas = ifelse(exercicios == 'Sim' | exercicios == 'Não', 'total_pessoas', 0)
  ) |> 
  ggplot(
    aes(
      y = pessoas,
      fill = treino_dieta
    )
  ) +
  geom_bar(width = 0.2, position = 'fill')
# Aproximadamente 50% das pessoas praticam exercícios físicos e seguem um plano alimentar em algum nível

dados |> 
  drop_na() |> 
  mutate(
    treino_dieta_rigoroso = ifelse(dias_exercicio %in% c(3, 5) & dieta %in% c(4, 5), 'Sim', 'Não'),
    pessoas = ifelse(exercicios == 'Sim' | exercicios == 'Não', 'total_pessoas', 0)
  ) |>  
  ggplot(
    aes(
      y = pessoas,
      fill = treino_dieta_rigoroso
    )
  ) +
  geom_bar(width = 0.2, position = 'fill')
# Mas, aproximadamente apenas 12% das pessoas praticam exercícios pelo menos 3 dias por semana e seguem rigorosamente um plano alimentar

# É realmente necessário treinar e ter uma boa alimentação para se sentir bem?  
dados |> 
  filter(exercicios == 'Sim' & alimentacao %in% c(4, 5)) |> 
  mutate(
    media_bem_estar = mean(bem_estar)
  ) |> 
  select(media_bem_estar)

dados |> 
  filter(exercicios == 'Não' & alimentacao %in% c(0, 1, 2, 3)) |> 
  mutate(
    media_bem_estar = mean(bem_estar)
  ) |> 
  select(media_bem_estar)

dados_comparacao_bem_estar <- data.frame(
  habito = c('Treino e alimentação boa', 'Sedentário e alimentação ruim'),
  media_bem_estar = c(3.46, 2.17)
)

dados_comparacao_bem_estar |> 
  ggplot(
    aes(
      y = habito,
      x = media_bem_estar,
      fill = habito,
      label = media_bem_estar
    )
  ) +
  scale_fill_manual(
    values = c('Treino e alimentação boa' = 'green4', 
               'Sedentário e alimentação ruim' = 'red4')
  ) +
  geom_col(width = 0.3) +
  geom_text(hjust = 1.5, 
            color = 'white',
            size = 8
            )
# Os dados indicam que a média de bem estar entre as pessoas é melhor para quem treina e tem uma alimentação muito boa 
