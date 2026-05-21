# Elementos para encaixar no dashboard final

# Carregando pacotes
library(tidyverse)
library(dslabs)
library(plotly)
library(gganimate)

# Carregando os dados
glimpse(gapminder)

# Banco que tem uma variável de tempo - possível trabalhar com séries temporais

# Banco com medições que foram repetidas seguidamente durante os anos

gap_anual <- gapminder |> 
  mutate(
    pib_per_capita = gdp / population
  ) |> 
  filter(year <= 2011) |> 
  drop_na(pib_per_capita, life_expectancy, population)

glimpse(gap_anual)

# Perguntas:
# A população influencia na expectativa de vida?
# A população influencia no pib per capita? 

# Gráfico transversal (significa que se refere a um momento específico no tempo)

gap_2011 <- gap_anual |> 
  dplyr::filter(year == 2011)

gap_1960 <- gap_anual |> 
  dplyr::filter(year == 1960)

# Desafio:
grafico1 <- gap_2011 |> 
  ggplot(
    aes(
      x = pib_per_capita,
      y = life_expectancy
    )
  ) +
  geom_point(
    aes(
      size = population,
      alpha = 0.7,
      color = continent,
      text = paste(
        'País:', country, 
        '<br>PIB Per Capita:', 'U$', format(round(pib_per_capita,2), decimal.mark = ','),
        '<br>Expectativa de vida:', life_expectancy, 'anos',
        '<br>População:', format(population, big.mark = '.')
      )
    )
  ) +
  geom_smooth(method = 'lm', se = FALSE) +
  scale_x_log10() +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = 'bold'),
    legend.position = 
  ) +
  labs(
    title = 'Expectativa de vida cresce com o PIB Per Capita',
    x = 'Pib Per Capita',
    y = 'Expectativa de vida',
    size = 'População',
    color = 'Continente'
  ) +
  guides(
    alpha = FALSE,
    size = FALSE
  )
# A função guides() pode ocultar uma legenda específica
# text = paste() altera as informações exibidas no gráfico interativo

# Tornando o gráfico interativo
ggplotly(grafico1, tooltip = 'text')
# tooltip = 'text' exibe as informações

# Criando um gráfico animado
grafico2 <- gap_anual |> 
  ggplot(
    aes(
      x = pib_per_capita,
      y = life_expectancy
    )
  ) +
  geom_point(
    aes(
      size = population,
      alpha = 0.7,
      color = continent,
      text = paste(
        'País:', country, 
        '<br>PIB Per Capita:', 'U$', format(round(pib_per_capita,2), decimal.mark = ','),
        '<br>Expectativa de vida:', life_expectancy, 'anos',
        '<br>População:', format(population, big.mark = '.')
      )
    )
  ) +
  geom_smooth(method = 'lm', se = FALSE) +
  scale_x_log10() +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = 'bold'),
    legend.position = 
  ) +
  labs(
    title = 'Expectativa de vida cresce com o PIB Per Capita',
    x = 'Pib Per Capita',
    y = 'Expectativa de vida',
    size = 'População',
    color = 'Continente'
  ) +
  guides(
    alpha = FALSE,
    size = FALSE
  ) +
  transition_time(year) + # Define a variável temporal
  ease_aes('linear') # Define uma transição suave

animate(
  grafico2,
  nframes = 30,
  fps = 4,
  renderer = gifski_renderer()
  )

# Ano de 1960:
grafico3 <- gap_1960 |> 
  ggplot(
    aes(
      x = pib_per_capita,
      y = life_expectancy
    )
  ) +
  geom_point(
    aes(
      size = population,
      alpha = 0.7,
      color = continent,
      text = paste(
        'País:', country, 
        '<br>PIB Per Capita:', 'U$', format(round(pib_per_capita,2), decimal.mark = ','),
        '<br>Expectativa de vida:', life_expectancy, 'anos',
        '<br>População:', format(population, big.mark = '.')
      )
    )
  ) +
  geom_smooth(method = 'lm', se = FALSE) +
  scale_x_log10() +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = 'bold'),
    legend.position = 
  ) +
  labs(
    title = 'Expectativa de vida cresce com o PIB Per Capita',
    x = 'Pib Per Capita',
    y = 'Expectativa de vida',
    size = 'População',
    color = 'Continente'
  ) +
  guides(
    alpha = FALSE,
    size = FALSE
  )
  
ggplotly(grafico3, tooltip = 'text')
  

# A populacão influencia na expectativa de vida?

gap_2011 |> 
  ggplot(
    aes(
      x = population,
      y = life_expectancy
    )
  ) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  scale_x_log10()
# Não

# A população influencia no pib per capita?
gap_2011 |> 
  ggplot(
    aes(
      x = population,
      y = pib_per_capita
    )
  ) +
  geom_point() +
  scale_x_log10() +
  geom_smooth(method = 'lm', se = FALSE)
# Não
  
# A taxa de fertilidade está relacionada com a taxa de mortalidade infantil?
gap_2011 |> 
  ggplot(
    aes(
      x = fertility,
      y = infant_mortality
    )
  ) +
  theme_minimal() +
  geom_point(
    aes(
      color = continent
    )
  ) +
  scale_x_log10() +
  geom_smooth(method = 'lm', se = FALSE)
# Sim

gap_1960 |> 
  ggplot(
    aes(
      x = fertility,
      y = infant_mortality
    )
  ) +
  theme_minimal() +
  geom_point(
    aes(
      color = continent
    )
  ) +
  scale_x_log10() +
  geom_smooth(method = 'lm', se = FALSE)
