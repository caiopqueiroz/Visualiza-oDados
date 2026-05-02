# Capítulo 1: Visualização de dados 

library(tidyverse)
library(ggthemes)
library(dados)

# Os pinguins com nadadeiras mais compridas pesam mais ou menos que pinguins com nadadeiras curtas?
# Tornar a resposta mais precisa através das perguntas: como é a relação entre o comprimento da nadadeira e massa corporal? Ela é positiva? Negativa? Linear? Não linear? A relação varia com a espécie do pinguim? E quanto à ilha onde o pinguim vive?

# Data frame é um coleção em formato de tabela, as variáveis são as colunas e as observações (informações) são as linhas
# Mostrando o data frame pinguins
dados::pinguins
glimpse(pinguins)
View(pinguins)

# Página de ajuda 
?pinguins

# Criando um gráfico ggplot
ggplot(
  data = pinguins,
  mapping = aes(
    x = comprimento_nadadeira,
    y = massa_corporal
  )
) +
  geom_point(
    aes(
      color = especie,
      shape = especie)
  ) +
  geom_smooth(method = 'lm') +
  labs(
    title = 'Massa Corporal e comprimento da nadadeira',
    subtitle = 'Medidas para Pinguim-de-adélia, Pinguim-de-barbicha e Pinguim-gentoo',
    x = 'Comprimento da nadadeira (mm)',
    y = 'Massa corporal (g)',
    color = 'Espécie',
    shape = 'Espécie'
  ) +
  scale_color_colorblind()

# Exercícios:
