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

# 3.2.3 