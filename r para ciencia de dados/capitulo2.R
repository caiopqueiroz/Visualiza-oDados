# Capítulo 2
# O segundo capítulo do livro ensina o básico sobre o console do RStudio, atribuição de valores à variáveis, vetores, etc. É um conteúdo simples que acredito que eu já tenha domínio.

# Exercícios:

# 1 - O código não funciona porque o nome da variável não foi escrito corretamente

# 2 -
library(tidyverse)
library(dados)

ggplot(data = milhas, aes(x = cilindrada, y = rodovia)) +
  geom_point() +
  geom_smooth(method = 'lm')

# 3 - Eu abro o guia de atalhos. Consigo acessa essa janela pelo menu Help também

# 4 - Nesse caso, o gráfico salvo é o segundo, porque indicamos isso ao atribuir o nome da variável meu_grafico_de_barras no parâmetro da função ggsave
meu_grafico_de_barras <- ggplot(milhas, aes(x = classe)) + geom_bar()
meu_grafico_de_dispersao <- ggplot(milhas, aes(x = cidade, y = rodovia)) + geom_point()
ggsave(filename = 'milhas-plot.png', plot = meu_grafico_de_barras)