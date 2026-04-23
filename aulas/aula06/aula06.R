#q1
starwars |>
  group_by(species) |>
  drop_na(mass) |> 
  summarise(peso_medio = mean(mass, na.rm = T)) |>
  filter(peso_medio > 80) |> 
  ggplot(
    aes(
      x = reorder(species, peso_medio),
      y = peso_medio,
      fill = species,
      label = round(peso_medio)
      )
    ) +
  geom_col() +
  geom_text(vjust = -0.5, size = 3) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = 'none',
    plot.title = element_text(size = 14, face = 'bold') 
    ) +
  labs(
    title = 'Star wars: Média de peso por espécie',
    subtitle = 'Apenas de espécies mais pesadas que 80 kg',
    x = 'Espécie',
    y = 'Peso médio em kg'
    )

starwars |>
  group_by(species) |>
  drop_na(mass) |> 
  summarise(peso_medio = mean(mass, na.rm = T)) |>
  filter(peso_medio < 80) |> 
  ggplot(
    aes(
      x = reorder(species, peso_medio),
      y = peso_medio,
      fill = species,
      label = round(peso_medio)
      )
    ) +
  geom_col() +
  geom_text(vjust = -0.5, size = 3) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = 'none',
    plot.title = element_text(size = 14, face = 'bold') 
    ) +
  labs(
    title = 'Star wars: Média de peso por espécie',
    subtitle = 'Apenas de espécies até 80 kg',
    x = 'Espécie',
    y = 'Peso médio em kg'
    )

#q2
ggplot(
  starwars,
  aes(
    x = mass,
    y = height 
    )
  ) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  scale_x_log10() +
  theme_classic() +
  theme(
    plot.title = element_text(face = 'bold', size = 14)
    ) +
  labs(
    title = 'Correlação entre altura e peso dos personagens',
    subtitle = 'Star Wars: Maior altura pode se relacionar com maior peso',
    x = 'Peso em kg',
    y = 'Altura em cm'
    )

#q3
humanos_starwars <- starwars |> 
  filter(species == 'Human')
peso_medio_humanos <- mean(humanos_starwars$mass, na.rm = T)

nao_humanos_starwars <- starwars |> 
  filter(species != 'Human')
peso_medio_nao_humanos <- mean(nao_humanos_starwars$mass, na.rm = T)

analise <- data.frame(
  especie = c('Humanos', 'Não-humanos'),
  peso_medio_especie = c(81.31, 107.56)
  )

ggplot(
  analise,
  aes(
    x = especie,
    y = peso_medio_especie,
    label = peso_medio_especie,
    fill = especie 
    )
  ) +
  geom_text(vjust = -0.5) +
  geom_col(width = 0.5) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = 'bold', size = 14),
    legend.position = 'none'
    ) +
    labs(
      title = 'Star Wars: Peso médio dos personagens',
      subtitle = 'Não-humanos são 20% mais pesados',
      x = 'Espécie',
      y = 'Peso médio em kg'
      )



