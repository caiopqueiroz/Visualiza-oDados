dados <- data.frame(
  nome = c('Caio', 'Pedro', 'Ighor', 'Bernardo', 'Matheus'),
  idade = c(18, 17, 24, 17, 25),
  nota = c(10, 9, 7, 3.5, 9.75)
)

# Criando nova coluna
dados |> 
  mutate(aprovado = nota >= 7) |> 
  mutate(cidade = c('PM', 'PM', 'PM', 'PM', 'PM'))

# Criando com condição
dados |> 
  mutate(status = ifelse(nota >=7, 'Aprovado', 'Reprovado'))

# Modificando coluna existente
dados |> 
  mutate(nota = nota * 10)

# Usando múltiplas colunas
dados |> 
  mutate(resultado = nota + idade)

# Criando várias colunas
dados |> 
  mutate(
    aprovado = nota >= 7,
    bonus = nota * 0.1
  )

# Encadeando com outras funções
# Esse código se lê: pegue os 'dados', me mostre apenas as linhas em que a nota for maior que 7, depois, nessas linhas, crie uma nova coluna chamada 'status' e me mostre só as colunas 'nome' e 'status'
dados |> 
  filter(nota > 7) |> 
  mutate(status = 'Bom aluno') |> 
  select(nome, status)
