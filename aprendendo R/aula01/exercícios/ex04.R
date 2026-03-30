# Criando um vetor com números aleatórios
# A função 'sample' pode receber como parâmetros:
# x = Range 
# size = Quantidade de números
# replace = Permitir ou não valores repetidos
numeros <- sample(x = 1:100, size = 10, replace = FALSE)

# O operador de resto de divisão é '%%'
pares <- numeros[numeros %% 2 == 0]

media <- mean(numeros)


