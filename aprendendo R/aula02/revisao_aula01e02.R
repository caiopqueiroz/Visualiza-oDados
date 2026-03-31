#ex01
numeros <- c(3, 8, 15, 2, 10, 7)

numeros[numeros > 5]

numeros * 2

novos_numeros <- numeros
novos_numeros[novos_numeros > 10] <- 999

#ex02
numeros <- sample(x = 1:50, size = 15)

numeros[numeros %% 2 != 0]

media <- mean(numeros)

numeros[numeros > media]

#ex03 ex04 ex05 ex06
funcionarios <- data.frame(
  nome = c('Ana', 'Bruno', 'Carlos', 'Daniela'),
  idade = c(23, 35, 29, 41),
  salario = c(2000, 3500, 2800, 4000)
)

funcionarios$salario

funcionarios[funcionarios$salario > 3000, ]

funcionarios$bonus <- ifelse(funcionarios$salario > 3000, 500, 200)

funcionarios[funcionarios$idade > 30 & funcionarios$salario > 3000, ]

funcionarios$nivel <- ifelse(funcionarios$salario >= 3500, 'Senior', ifelse(funcionarios$salario >= 2500, 'Pleno', 'Junior'))
