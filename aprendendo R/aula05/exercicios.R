dados <- data.frame(
  nome = c('Caio', 'Pedro', 'Ighor', 'Bernardo', 'Matheus'),
  idade = c(18, 17, 24, 17, 25),
  nota = c(7.5, 7, 6, 7, 9)
)

# ex01
dados |> 
  filter(nota > 7)

# ex02
dados |> 
  select(nome, idade)

# ex03
dados |> 
  filter(idade > 20) |> 
  select(nome, nota)

# ex04
dados |> 
  filter(nota > 7, idade > 20)

# ex05
dados |> 
  select(-idade)

# ex06
dados |> 
  filter(nota <= 7) |> 
  select(nome)
