library(dados)
library(ggplot2)
library(tidyverse)
?pinguins

Profundidade <- pinguins$profundidade_bico
Comprimento <- pinguins$comprimento_bico

ggplot(data = pinguins, mapping = aes(x = Profundidade, y = Comprimento)) +
  geom_point(aes(color = especie)) + geom_smooth(aes(color = especie))

