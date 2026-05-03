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
      shape = especie
      )
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
# 1 - 344 linhas e 8 colunas

# 2 - Descreve um número inteiro que indica a profundidade do bico (em milímetros)

# 3 - Gráfico de dispersão: comprimento_bico por profundidade_bico
pinguins |> 
  ggplot(
    aes(
      x = comprimento_bico,
      y = profundidade_bico
    )
  ) +
  geom_point(
    aes(
    color = especie,
    shape = especie 
      )) +
  geom_smooth(method = 'lm', se = FALSE) 
# Se a profundidade do bico é menor, há indício de que o comprimento do bico tende a ser maior 
  
# 5 - Gráfico de dispersão - espécie por profundidade do bico
pinguins |> 
  drop_na(profundidade_bico) |> 
  group_by(especie) |> 
  summarise(
    profundidade_media_bico = mean(profundidade_bico)
  ) |> 
  ggplot(
    aes(
      x = especie,
      y = profundidade_media_bico,
      label = round(profundidade_media_bico,2),
      fill = especie
    )
  ) +
  geom_col() +
  geom_text(vjust = -0.5) +
  theme(
    legend.position = 'none',
    axis.text.x = element_text(angle = 20, vjust = 1)
  )
# O gráfico de dispersão é uma má escolha. A melhor decisão seria agrupar a variável de acordo com a espécie, calcular a média e exibir como um gráfico de colunas.

# 5 - Ocorre porque o parâmetro mapping da função não foi definido. Definí-lo irá corrigir o problema.

# 6 - O argumento na.rm decide se os valores não informados (NA) vão ser considerados (FALSE) ou se não vão (TRUE). Por padrão, na.rm = FALSE, NA são considerados 
ggplot(
  pinguins,
  aes(
    x = comprimento_bico,
    y = comprimento_nadadeira
  )
) + 
  geom_point(
    na.rm = TRUE,
    aes(
      color = especie,
      shape = especie
    )) +
  geom_smooth(method = 'lm', se = FALSE) +
  labs(
    caption = 'Os dados são provenientes do pacote dados'
  )

# 7 - Adicionando legenda ao gráfico do exercício 6 
 
  