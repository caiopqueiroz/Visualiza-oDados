# Vetores (como listas simples no Python)
numeros <- c(1, 2, 3, 4, 5)

# Operações vetorizadas
numeros * 2

# Média 
mean(numeros)

# Média usando o pipe
numeros |> mean()

# Condicional (filtro)
# Retorna apenas os elementos do vetor 'numeros' que são maiores que 3
numeros[numeros > 3]