# Carregando pacotes necessários
library(tidyverse)
library(gt)
library(gtExtras)
library(dados)

# Criando um banco de dados
dados <- data.frame(
  produto = c('A', 'B', 'C'),
  preco = c(10, 20, 5),
  vendas = c(50, 100, 200)
)

# Criando uma tabela
# gt() cria tabelas em HTML ou PDF para dashboards ou relatórios
gt(
  data = dados
)

# Consultando a documentação das funções
?nome_da_função

# Os nomes dos carros, nesse banco de dados, estão definidos com o nome das linhas. A função rownames_to_column() faz com o que elas sejam exibidas na tabela 
mtcars |> 
  rownames_to_column('car') |> 
  gt()

# Adicionando um tema com a função gt_theme_espn()
mtcars |> 
  rownames_to_column('car') |> 
  gt() |> 
  gt_theme_espn()

# Adicionando um título com a função tab_header()
mtcars |> 
  rownames_to_column('car') |> 
  gt() |> 
  gt_theme_dot_matrix() |> 
  tab_header(
    title = 'Carros antigos e suas características',
    subtitle = 'Dados da revista Motor Trend dos EUA, de 1974'
    )

# Criando um tema 
my_theme <- function(gt_object, ...) {
  gt_object |> 
    tab_options(
      column_labels.background.color = 'blue2',
      heading.align = 'center',
      ...
    ) |> 
    tab_style(
      style = cell_text(
        color = 'blue4', 
        size = px(24),
        weight = 'bold'
        ),
      locations = cells_title('title')
    )
}

# Adicionando o seu tema à tabela
mtcars |> 
  rownames_to_column('car') |> 
  gt() |> 
  tab_header(
    title = 'Carros antigos e suas características',
    subtitle = 'Dados da revista Motor Trend, de 1974'
  ) |> 
  my_theme() |> 
  gt_theme_espn()
  
# Criando um mapa de calor com a função gt_hulk_col_numeric() e ordenando com arrange()
mtcars |> 
  arrange(desc(hp)) |> 
  rownames_to_column('car') |> 
  gt() |> 
  tab_header(
    title = 'Carros antigos e suas características',
    subtitle = 'Dados da revista Motor Trend, de 1974'
  ) |> 
  my_theme() |> 
  gt_theme_espn() |> 
  gt_hulk_col_numeric(hp) 

# Criando um mapa de calor com a função data_color() e ordenando com arrange()
mtcars |> 
  arrange(desc(hp)) |> 
  rownames_to_column('car') |> 
  gt() |> 
  tab_header(
    title = 'Carros antigos e suas características',
    subtitle = 'Dados da revista Motor Trend, de 1974'
  ) |> 
  my_theme() |> 
  gt_theme_espn() |> 
  data_color(
    hp,
    colors = c('white', 'blue3'),
    alpha = 0.8,
    apply_to = 'fill'
    )

# Criando um mapa de calor com a função gt_color_rows() e ordenando com arrange()
mtcars |> 
  arrange(desc(hp)) |> 
  rownames_to_column('car') |> 
  gt() |> 
  tab_header(
    title = 'Carros antigos e suas características',
    subtitle = 'Dados da revista Motor Trend, de 1974'
  ) |> 
  my_theme() |> 
  gt_theme_espn() |> 
  gt_color_rows(
    hp,
    palette = 'Blues'
  )

# Destacando uma linha com a função 
mtcars |> 
  arrange(desc(hp)) |> 
  rownames_to_column('car') |> 
  gt() |> 
  tab_header(
    title = 'Carros antigos e suas características',
    subtitle = 'Dados da revista Motor Trend, de 1974'
  ) |> 
  my_theme() |> 
  gt_theme_espn() |> 
  gt_highlight_rows(
    rows = hp > 250,
    fill = 'blue3',
    font_color = 'white'
  ) 

# Misturando gráficos e tabelas com a função gt_plt_dist()
mtcars |> 
  group_by(cyl) |> 
  summarise(
    dados_mpg = list(mpg)
  ) |> 
  gt() |> 
  gt_plt_dist(
    column = dados_mpg,
    type = 'histogram'
  )
  
# Criando outra tabela 
pinguins |> 
  drop_na(sexo) |> 
  gt()
