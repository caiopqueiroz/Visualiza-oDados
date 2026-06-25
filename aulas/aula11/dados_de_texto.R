# Trabalhando com dados de texto 

# Instalando novos pacotes
install.packages('tidytext')
install.packages('ggwordcloud')
install.packages('stopwords')

# Carregando pacotes
library(tidyverse)
library(tidytext)
library(ggwordcloud)
library(stopwords)

# Lendo o banco de dados
dados <- read_csv('C:/Users/Servidor/Documents/Estudos/VisualizaçãoDados/aulas/aula11/noticias.csv')

# Checando o banco de dados
glimpse(dados)

# slice(1) exibe apenas a primeira notícia 
# pull(texto) exibe apenas o texto da notícia
dados |> 
  slice(1) |> 
  pull(texto)

# Token é a unidade mínima escrita no texto, ou seja, são as palavras, cada palavra no texto é um token diferente

# Criando um banco de dados com os tokens separados
# input é qual coluna do banco ele vai separar 
# output é o nome da nova coluna criada 
palavras <- dados |> 
  unnest_tokens(
    output = palavra,
    input = texto
  )

# Contando quantas vezes apareceu cada palavra
palavras |> 
  count(palavra) |> 
  arrange(desc(n))

palavras |> 
  count(palavra, sort = TRUE)

# Removendo as stopwords (a, o, para, qual, os, as)
stop_pt <- get_stopwords(language = 'pt')

# a função anti_Join() vai retirar todas as palavras do banco que forem iguais às da coluna word, que tem as stopwords
palavras_limpas <- palavras |>
  anti_join(
    stop_pt,
    by = c('palavra' = 'word')
    )

contagem <- palavras_limpas |> 
  count(palavra, sort = TRUE)

# Criando um gráfico de barras com as palavras que mais aparecem
contagem |> 
  filter(n > 15) |> 
  ggplot(
    aes(
      x = n,
      y = reorder(palavra, n)
    )
  ) + 
  geom_col(
    position = 'identity'
  )

# slice_max(n, n = 10) define que apenas as primeiras 10 palavras do gráfico serão exibidas
contagem |> 
  filter(palavra != 'sobre', palavra != 'após', palavra != 'longo') |> 
  slice_max(n, n = 10) |>
  ggplot(
    aes(
      x = n,
      y = reorder(palavra, n),
      label = n,
      fill = n
    )
  ) + 
  geom_col(
    position = 'identity'
  ) +
  geom_text(
    hjust = 1.5,
    color = 'white'
  ) +
  scale_fill_gradient(
    low = 'gray',
    high = 'blue4'
  ) +
  theme(
    legend.position = 'none'
  )

# Construindo uma nuvem de palavras com a função geom_text_wordcloud()
contagem |> 
  slice_max(n, n = 100) |> 
  ggplot(
    aes(
      label = palavra,
      size = n,
      color = n
    )
  ) +
  geom_text_wordcloud() +
  scale_fill_gradient(
    high = 'green3',
    low = 'gray70'
  ) +
  labs(
    title = 'Nuvem de palavras incrível'
  )

# Contagem de palavras por editoria 
contagem_maior <- palavras_limpas |> 
  count(editoria, palavra, sort = TRUE)

# Nuvem de palavras por editoria
contagem_maior |>
  group_by(editoria) |> 
  slice_max(n, n = 30) |> 
  ggplot(
    aes(
      label = palavra,
      size = n,
      color = editoria
    ) 
  ) +
  geom_text_wordcloud()

# Gráfico de frequência de palavras por editoria
contagem_maior |> 
  group_by(editoria) |> 
  slice_max(n, n = 5) |> 
  ggplot(
    aes(
      x = n,
      y = reorder(palavra, n)
    )
  ) +
  geom_col() +
  facet_wrap(~ editoria, scales = 'free_y')
  



