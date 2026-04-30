# Importando banco de dados diretamente do link 
url <- 'https://archive.ics.uci.edu/ml/machine-learning-databases/00519/heart_failure_clinical_records_dataset.csv'

# Lendo o banco de dados 
df <- read_csv(url)

# Pré-visualização do banco
glimpse(df)

# Transformando o tipo das variáveis
# df <- df |> 
#   mutate(
#     anaemia = ifelse(anaemia == 1, 'Sim', 'Não'),
#     diabetes = ifelse(diabetes == 1, 'Sim', 'Não'),
#     )

df <- df |> 
  mutate(
    anaemia = factor(anaemia, 
                     levels = c(0, 1),
                     labels = c('Não', 'Sim')
                     ),
    high_blood_pressure = factor(high_blood_pressure, 
                     levels = c(0, 1),
                     labels = c('Não', 'Sim')
                     ),
    sex = factor(sex, 
                     levels = c(0, 1),
                     labels = c('Mulher', 'Homem')
                     ),
    smoking = factor(smoking, 
                     levels = c(0, 1),
                     labels = c('Não', 'Sim')
                     ),
    diabetes = factor(diabetes, 
                     levels = c(0, 1),
                     labels = c('Não', 'Sim')
                     ),
    DEATH_EVENT = factor(DEATH_EVENT, 
                     levels = c(0, 1),
                     labels = c('Vivo', 'Morto')
                     )
  )

# Será que os hipertensos morreram mais que os não hipertensos? 
# high blood pressure e DEATH_EVENT
df |> 
  ggplot(
    aes(
      y = high_blood_pressure,
      fill = DEATH_EVENT
    )
  ) +
  scale_fill_manual(
    values = c('Morto' = 'darkred', 'Vivo' = '#90ee90')
  ) +
  geom_bar(position = 'fill', width = 0.4) +
  theme_classic() +
  theme(
    plot.title = element_text(face = 'bold', size = 16)
  ) +
  labs(
    title = 'Impacto da Hipertensão em Pacientes Cardíacos',
    subtitle = 'Pacientes com hipertensão tem maiores taxas de óbito',
    x = 'Porcentagem',
    y = 'Hipertensão',
    fill = 'Condição'
  ) +
  geom_text(
    data = tabela_auxiliar,
    aes(
      x = taxa_obito / 100,
      y = high_blood_pressure,
      fill = 'NULL',
      label = paste0(taxa_obito, '%'),
      hjust = 1.25,
      fontface = 'bold',
      color = 'white'
    )
  )
# fill deixa as barras proporcionais
# usando outro data frame no ggplot do gráfico, dentro do geom text, para exibir mais informações 

# Calculando as porcentagens para exibir no gráfico
tabela_auxiliar <- df |> 
  group_by(high_blood_pressure) |> 
  summarise(
    total = n(),
    total_obito = sum(DEATH_EVENT == 'Morto'),
    taxa_obito = round((total_obito / total) * 100)
  )

# Pacote para fazer tabelas usando R
library(gt)
