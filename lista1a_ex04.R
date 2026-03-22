library(dados)
library(ggplot2)
library(tidyverse)

ggplot(data = pinguins, mapping = aes(x = comprimento_nadadeira, y = massa_corporal)) +
  geom_point(aes(color = profundidade_bico)) + geom_smooth()