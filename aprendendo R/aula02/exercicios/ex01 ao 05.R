# Criando tabela

alunos <- data.frame(
  nome = c('Lucas', 'Fernanda', 'Carlos'),
  idade = c(19, 21, 20),
  nota = c(6.5, 8.0, 7.5)
)

# Mostrando só a coluna 'nome'
alunos$nome 
# ou
alunos[, 1]

# Mostrando só a segunda linha
alunos[2, ]

# Mostrando apenas os alunos com a nota >= 7
alunos[alunos$nota >= 7, ]
# ou mostrando apenas seus nomes 
alunos[alunos$nota >= 7, 1]

# Criando nova coluna chamada 'status'
# Acessando e alterando os elementos da coluna 'status'
# Para isso, especificando a linha (no caso, as linhas que possuem, na coluna 'status', o valor TRUE) e a coluna (no caso, a 4ª)
alunos$status <- alunos$nota >= 7 
alunos[alunos$status == TRUE, 4] <- 'Aprovado'
alunos[alunos$status == FALSE, 4] <- 'Reprovado'
# ou
# Na função 'ifelse', se escreve primeiro a condição, depois a alternativa caso ela seja verdadeira e, por fim, a alternativa caso ela seja falsa
alunos$status <- ifelse(alunos$nota >= 7, 'Aprovado', 'Reprovado')

# Acessando apenas as linhas em que o aluno tem idade > 19 e nota > 7
alunos[alunos$idade > 19 & alunos$nota > 7, ] 
