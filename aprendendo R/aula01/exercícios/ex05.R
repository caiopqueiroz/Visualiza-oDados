numeros <- c(10, 20, 30, 40)

# Definindo o vetor 'novos_numeros' como uma cópia de 'numeros' para não alterar o vetor original
novos_numeros <- numeros

# Cada elemento do novo vetor terá seu valor alterado para 100 caso seja maior que 20
# O que está acontecendo na prática:
# 10 não é maior que 20 - Logo, FALSE
# 20 não é maior que 20 - Logo, FALSE
# 30 é maior que 20 - Logo, TRUE - recebe 100
# 40 é maior que 20 - Logo, TRUE - recebe 100
novos_numeros[numeros > 20] <- 100

