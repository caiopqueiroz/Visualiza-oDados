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

# 8 - A profundidade do bico deve ser mapeada para color dentro da geometria porque os pontos são os únicos que devem ter cor de acordo com essa variável
pinguins |> 
  drop_na(comprimento_nadadeira, massa_corporal) |> 
  ggplot(
    aes(
      x = comprimento_nadadeira,
      y = massa_corporal
    )
  ) +
  geom_point(aes(
    color = profundidade_bico
  )) +
  geom_smooth()
  
# 9 - Como o parâmetro color está definido de forma global, ambos o geom_point e o geom_smooth devem obedecer a ele, por isso os pontos e as linhas foram divididos por 3 cores
ggplot(
  pinguins,
  aes(
    x = comprimento_nadadeira,
    y = massa_corporal,
    color = ilha
  )
) +
  geom_point() +
  geom_smooth(
    se = FALSE
  )

# 10 - Ambos são iguais, mas no segundo não há nenhum parâmetro global, apenas dentro das geometrias, que é uma outra maneira possível de se construir um gráfico
ggplot(
  pinguins,
  aes(
    x = comprimento_nadadeira,
    y = massa_corporal
  )
) +
  geom_point() +
  geom_smooth()

ggplot() +
  geom_point(
    data = pinguins,
    mapping = aes(
      x = comprimento_nadadeira,
      y = massa_corporal
    )
  ) +
  geom_smooth(
    data = pinguins,
    mapping = aes(
      x = comprimento_nadadeira,
      y = massa_corporal
    )
  )

# Variáveis categóricas
# Uma variável é categórica (ou seja, é uma categoria) se puder assumir apenas um valor de um pequeno conjunto de valores
# Exibindo quantas vezes cada espécie (variável categórica) aparece
pinguins |> 
  ggplot(
    aes(
      x = especie
    )
  ) +
  geom_bar()

# Ordenando a variável categórica com base na frequência, ou seja, da espécie com mais observações para a espécie com menos observações
# Para isso, a variável deve ser transformada em um fator (fct ou factor)
pinguins |> 
  ggplot(
    aes(
      x = fct_infreq(especie)
    )
  ) +
  geom_bar()

# Variáveis numéricas
# Uma visualização comumente usada para variáveis numéricas é um histogramas
pinguins |> 
  ggplot(
    aes(
      x = massa_corporal
    )
  ) +
  geom_histogram(
    binwidth = 200
    )
# A cada 200 gramas a mais de massa corporal, há uma barra diferente, e a altura de cada barra representa a quantidade de pinguis que tem a massa_corporal nessa faixa de peso

# Outra forma de visualizar variáveis numéricas seria através da sua curva de densidade, que é uma representação suavizada do histograma
pinguins |> 
  ggplot(
    aes(
      x = massa_corporal
    )
  ) +
  geom_density()

# Exercícios:

# 1 - É um gráfico de barras horizontais
pinguins |> 
  ggplot(
    aes(
      y = fct_infreq(especie)
    )
  ) +
  geom_bar()

# 2 - O parâmetro color apenas contorna as barras com a cor vermelha, já o fill preenche elas completamente, por isso é mais útil
pinguins |> 
  ggplot(
    aes(
      x = especie
    )
  ) +
  geom_bar(fill = 'red')

pinguins |> 
  ggplot(
    aes(
      x = especie
    )
  ) +
  geom_bar(color = 'red')

# 3 - O argumento bins é o número de barras em que serão divididas as observações, e não a largura delas
pinguins |> 
  ggplot(
    aes(
      x = massa_corporal
    )
  ) + 
  geom_histogram(bins = 20)

# 4 - Com o binwidth definido como 0.1, é possível visualizar claramente o padrão da variável quilate
diamante |> 
  ggplot(
    aes(
      x = quilate
    )
  ) +
  geom_histogram(binwidth = 0.1) +
  scale_x_continuous(limits = c(0, 3))

# Relações:
# Variável numérica e variável categórica:
# Uma maneira de relacionar uma variável numérica com uma variável categórica é utilizando boxplots
pinguins |> 
  drop_na(especie, massa_corporal) |> 
  ggplot(
    aes(
      x = especie,
      y = massa_corporal
    )
  ) + 
  geom_boxplot()

# Uma outra alternativa seria usar o geom_density e separar as especies usando cores 
pinguins |> 
  drop_na(massa_corporal) |> 
  ggplot(
    aes(
      x = massa_corporal,
      color = especie
    )
  ) + 
  geom_density(linewidth = 0.75)
# Além de alterar a espessura das linhas, podemos também preencher o conteúdo delas usando fill e adicionar transparência usando alpha (0 a 1)
pinguins |> 
  drop_na(massa_corporal) |> 
  ggplot(
    aes(
      x = massa_corporal,
      color = especie,
      fill = especie
    )
  ) +
  geom_density(
    alpha = 0.5,
    linewidth = 0.75
  )

# Duas variáveis categóricas:
# Podemos representar através de um gráfico de barras mapeando uma variável para o eixo x e outra no argumento fill
pinguins |> 
  ggplot(
    aes(
      x = ilha,
      fill = especie 
    )
  ) +
  geom_bar()
# Nesse caso, vemos a distribuição das espécies em cada ilha

# Utilizando o argumento position = fill no geom_bar(), todas as barras se tornam proporcionais, assim é mais fácil visualizar a proporção entre as espécies de pinguim em cada 
pinguins |> 
  ggplot(
    aes(
      x = ilha,
      fill = especie 
    )
  ) +
  geom_bar(
    position = 'fill'
  )
# Dessa forma, é possível notar, por exemplo, que na ilha Dream mais ou menos metade dos pinguins são de adélia, enquanto na ilha Biscoe, apenas um quarto 

# Duas variáveis numéricas:
# O gráfico mais utilizado nesse caso é o gráfico de dispersão
pinguins |> 
  ggplot(
    aes(
      x = comprimento_nadadeira,
      y = massa_corporal
    )
  ) +
  geom_point()

# Três ou mais variáveis:
ggplot(
  pinguins,
  aes(
    x = comprimento_nadadeira,
    y = massa_corporal
     ) 
  ) +
    geom_point(
      aes(
        color = especie,
        shape = ilha
      )
    )
# Para evitar que o gráfico fique confuso, dividimos ele em facetas usando facet_wrap()
pinguins |> 
  ggplot(
    aes(
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
  facet_wrap(~ ilha)

# Exercícios

# 1 - As variáveis categóricas são: fabricante, modelo, transmissao, tracao, combustivel e classe. Já as numéricas: cilindrada, ano, cilindros, cidade e rodovia. As variáveis categóricas são escritas usando aspas

# 2 - Nas variáveis numéricas, a cor se mantém a mesma, o que muda é o tom, e o parâmetro shape não funciona. Nas categóricas, as cores são bem distintas e é possível separar por shape
milhas |> 
  ggplot(
    aes(
      x = rodovia,
      y = cilindrada
    )
  ) +
  geom_point(
    aes(
      color = cilindros,
      size = cilindros,
      alpha = 0.5,
    )
  )

milhas |> 
  ggplot(
    aes(
      x = rodovia,
      y = cilindrada
    )
  ) +
  geom_point(
    aes(
      color = tracao,
      size = tracao,
      alpha = 0.5,
      shape = tracao
    )
  )

# 3 - Nada
milhas |> 
  ggplot(
    aes(
      x = rodovia,
      y = cilindrada,
      linewidth = ano
    )
  ) +
  geom_point()

