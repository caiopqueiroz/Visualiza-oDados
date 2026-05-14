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

#3.2.5
  
  
