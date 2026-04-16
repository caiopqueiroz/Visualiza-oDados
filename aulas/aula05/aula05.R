# Carregando os pacotes necessários
library(tidyverse)

# Banco de dados 'msleep' -> informações sobre animais e o seu sono
# 'sleep_total' = tempo total de sono
# 'bodywt' = peso corporal
# 'brainwt' = peso do cérebro
# etc

# help
?msleep

# Para ver o banco de dados
# tibble: 6 x 11 (6 linhas e 11 colunas)
head(msleep)
glimpse(msleep)

# Pergunta: qual animal dorme menos?
msleep |> 
  filter(sleep_total < 4) |> 
  select(name, sleep_total) |> 
  ggplot(
    aes(x = reorder(name, sleep_total), y = sleep_total, label = sleep_total)
  ) +
  geom_text(nudge_y = 0.2) +
  geom_col(aes(fill = name)) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = 'none'
  )
# Resposta: Girafa 

# Criando um gráfico
# Pensar em uma pergunta e tentar respondê-la através de um gráfico: quanto maior o peso do animal, mais ele dorme?
# scale_x_log10() - altera a escala para logarítmica
ggplot(
  msleep,
  aes(x = bodywt, y = sleep_total)
) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = 'lm') +
  scale_x_log10()
  
# Usando o filter
# alpha = 0.5 - adicionar transparência
# filter(vore == 'herbi') - filtrar somente os herbívoros
msleep |> 
  filter(vore == 'herbi') |> 
  ggplot(
    aes(x = bodywt, y = sleep_total)
  ) +
  geom_point(color = 'green4',
             alpha = 0.5
             ) +
  geom_smooth(method = 'lm',
              color = 'green4') +
  scale_x_log10()
# Resposta: quanto maior o peso do animal, menos ele dorme

# Usando o select
# select(vore, bodywt, sleep_total) - usar apenas algumas colunas
msleep |> 
  select(vore, bodywt, sleep_total) |> 
  filter(vore == 'carni') |> 
  ggplot(
    aes(x = bodywt, y = sleep_total)
  ) +
  geom_point() +
  geom_smooth(method = 'lm')

# Pergunta: animais que dormem mais tem também mais sono_rem? 
msleep |> 
  mutate(prop_rem = sleep_rem / sleep_total) |>
  filter(prop_rem > 0.2) |> 
  ggplot(
    aes(x = reorder(name, prop_rem), y = prop_rem)
  ) +
  geom_col(aes(fill = name)) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = 'none'
  )

msleep |> 
  mutate(prop_rem = sleep_rem / sleep_total) |>
  ggplot(
    aes(x = sleep_total, y = prop_rem) 
  ) +
  geom_point() +
  geom_smooth(method = 'lm')
# Resposta: não

# Para adicionar definitivamente a nova coluna criada ao banco
# msleep <- msleep |> 
#   mutate(prop_rem = sleep_rem / sleep_total)

# Usando group_by e summarise
# sd(sleep_total) - calcula o desvio padrão
# drop_na(vore) - desconsidera os valores NA da coluna vore
# geom_segment(aes(y = 0, yend = media_sleep_total)) - cria uma linha
# scale_x_discrete(labels = c('carni' = 'Carnívoros')) - troca o nome dos valores do eixo x
# Pergunta: Os herbívoros dormem mais que carnívoros?
msleep |>
  drop_na(vore) |> 
  group_by(vore) |> 
  summarise(media_sleep_total = mean(sleep_total),
            desvio_padrao_sono = sd(sleep_total)) |> 
  ggplot(
    aes(x = reorder(vore, media_sleep_total), 
        y = media_sleep_total, 
        label = round(media_sleep_total,2))
  ) +
  geom_text(nudge_y = 0.5, ) +
  geom_col(aes(fill = vore)) +
  theme_minimal() +
  theme(
    legend.position = 'none'
  ) +
  labs(
    x = 'Alimentação',
    y = 'Média de sono'
  ) +
  #geom_segment(aes(y = 0, 
  #                 yend = media_sleep_total,
  #                 linewidth = 10)) +
  scale_x_discrete(labels = c('carni' = 'Carnívoros',
                              'herbi' = 'Herbívoros',
                              'omni' = 'Onívoros',
                              'insecti' = 'Insetívoros'))
# Resposta: não, os carnívoros dormem mais que os herbívoros   


