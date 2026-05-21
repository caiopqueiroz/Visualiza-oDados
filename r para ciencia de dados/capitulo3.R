# Capítulo 3

# Carregar uma função de um pacote específico
# nomedopacote::nomedafuncao()

glimpse(voos)

# Mostrar o banco de dados 
View(voos)

# Exemplo de uso do pipe
voos |> 
  filter(destino == 'IAH') |> 
  group_by(ano, mes, dia) |> 
  summarise(
    atraso_chegada = mean(atraso_chegada, na.rm = TRUE)
  )

# Verbos (funções) para linhas
# filter() modifica quais são as linhas presentes sem alterar a ordem
# arrange() modifica a ordem sem alterar quais as linhas presentes

# Exemplos de uso do filter()
voos |> 
  filter(atraso_saida > 120)

voos |> 
  filter(mes == 1 & dia == 1)

voos |> 
  filter(mes == 1 | mes == 2)

voos |> 
  filter(mes %in% c(1, 2))

# Salvando o data frame filtrado
jan1 <- voos |> 
  filter(mes == 1 & dia == 1)

# Exemplos de uso do arrange()
voos |> 
  arrange(ano, mes, dia, horario_saida)
# Ordenando em ordem crescente de ano, depois usando o mês em caso de mesmo ano, depois usando o dia em caso de mesmo mês e depois usando o horario_saida em caso de mesmo dia

voos |> 
  arrange(desc(atraso_saida))

# Exemplos de uso do distinct()
# Distinct() mostra todas as linhas únicas, ou seja, remove linhas duplicadas

voos |> 
  distinct()

voos |> 
  distinct(origem, destino)
# Usando o distinct apenas nas colunas origem e destino, logo ele vai mostrar apenas as linhas em que a origem é diferente do destino, ou seja, vai ocultar linhas duplicadas considerando apenas essas duas variáveis

voos |> 
  distinct(origem, destino, .keep_all = TRUE)
# Tem o mesmo efeito, mas não oculta as demais colunas

voos |> 
  count(origem, destino, sort = TRUE)
# Conta quantas ocorrências tiveram cada vôo com origem e destino diferentes 

# Exercícios:

# 1 -
voos |> 
  filter(atraso_chegada > 120) |> 
  filter(destino == 'IAH' | destino == 'HOU') |> 
  filter(companhia_aerea %in% c('UA', 'AA', 'DL')) |> 
  filter(mes %in% c(7, 8, 9)) |> 
  filter(atraso_saida < 90)

# 2 - 
voos |> 
  arrange(desc(atraso_saida), hora)

# 3 - 
voos |> 
  arrange(tempo_voo)

# 4 - Sim, houve ao menos 1 vôo por dia
voos |> 
  distinct(mes, dia)

# 5 - Maiores distâncias: 51 e 15. Menores distâncias: 1632  
voos |> 
  select(voo, distancia) |> 
  arrange(distancia)

# 6 - Faz diferença, se utilizo o filter antes do arrange, a quantidade de linhas que o arrange deve ordenar é menor. É a maneira que faz mais sentido de se usar

# Verbos (funções) para colunas 

# mutate() adiciona novas colunas que são calculadas a partir de colunas já existente
# Exemplos de uso do mutate()
voos |> 
  mutate(
    tempo_ganho = atraso_saida - atraso_chegada,
    velocidade = distancia / tempo_voo * 60,
    horas = tempo_voo / 60,
    tempo_ganho_hora = tempo_ganho / horas,
    .keep = 'used',
    .before = 1
  ) 

# select() seleciona colunas 
# Exemplos de uso do select()

# Seleciona colunas por nome
voos |> 
  select(ano, mes, dia)

# Seleciona colunas entre nomes
voos |> 
  select(ano:dia)

# Seleciona todas as colunas, exceto as que estão entre os nomes
voos |> 
  select(!ano:dia)

# Seleciona todas as colunas que são caracteres
voos |> 
  select(where(is.character))

# Seleciona todas as colunas que contêm 'hora' no nome 
voos |> 
  select(contains('hora'))

# Renomeando a coluna codigo_cauda com select()
voos |> 
  select(tail_num = codigo_cauda)

# rename() altera o nome de colunas
# Exemplos de uso do rename()
voos |> 
  rename(tail_num = codigo_cauda)

# relocate() altera a posição das variáveis 
# Exemplos de uso do relocate()
voos |> 
  relocate(data_hora, tempo_voo)

voos |> 
  relocate(
    ano:horario_saida,
    .after = data_hora)

voos |> 
  relocate(
    contains('cheg'),
    .before = horario_saida
  )

# Exercícios

# 1 - O atraso na saída é igual a diferença entre o horário da saída e a saída programada
voos |> 
  select(
    horario_saida,
    saida_programada,
    atraso_saida
    )

# 2 -
voos |> 
  select(
    horario_saida,
    atraso_saida,
    horario_chegada,
    atraso_chegada
  )

voos |> 
  relocate(
    contains('horario'),
    contains('atraso')
  )

voos |> 
  select(
    contains('horario'),
    contains('atraso')
  )

voos |> 
  select(
    ends_with('saida'),
    ends_with('chegada') 
  )

# 3 - A coluna aparece apenas uma vez
voos |> 
  select(
    dia,
    dia,
    dia
  )

# 4 - A função any_of() recebe um vetor com o nome de múltiplas variáveis e, depois, quando utilizada em conjunto com o select(), seleciona todas essas colunas no banco de dados
variaveis <- c('ano', 'mes', 'dia', 'atraso_saida', 'atraso_chegada')
voos |> 
  select(any_of(variaveis))

# 5 - As funções auxiliares não são sensíveis à letras maiúsculas e minúsculas, mas isso pode ser alterado definindo o parâmetro ignore.case como FALSE 
voos |> 
  select(
    contains('TEMPO', ignore.case = FALSE)
  )
    
# 6 - 
voos |> 
  rename(
    tempo_voo_min = tempo_voo
  ) |> 
  relocate(
    tempo_voo_min
  )

# 7 - Não funciona porque, ao selecionar apenas a coluna codigo_cauda, é impossível utilizar todas as outras em qualquer função que venha depois
voos |> 
  select(codigo_cauda) |> 
  arrange(atraso_chegada)

# Corrigindo:
voos |> 
  arrange(atraso_chegada) |> 
  select(codigo_cauda)

# 3.4