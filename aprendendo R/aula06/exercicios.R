dados <- data.frame(
  nome = c('Júlia', 'Clésio', 'Stefânia'),
  idade = c(20, 52, 56),
  nota = c(9.5, 7, 4)
)

# ex01
dados |> 
  mutate(aprovado = nota >= 7)

# ex02
dados |> 
  mutate(status = ifelse(nota >= 7, 'Aprovado', 'Reprovado'))

# ex03
dados |> 
  mutate(nota = nota * 10)

# ex04
dados |> 
  mutate(idade_futura = idade + 5)

# ex05
dados |> 
  mutate(
    aprovado = nota >=7,
    bonus = nota * 0.5
  ) |> 
  filter(aprovado)

# ex06
dados |> 
  filter(nota >= 7) |> 
  mutate(status = 'Aprovado') |> 
  select(nome, status)
