numeros <- c('10', '20', '30')
class(numeros)
as.numeric(numeros)
as.numeric(numeros[1]) + as.numeric(numeros[2]) + as.numeric(numeros[3])

numeros2 <- factor(c('1', '2', '3'))
as.numeric(numeros2)
as.numeric(as.character(numeros2))

status <- c('Aprovado', 'Reprovado', 'Aprovado', 'Reprovado')
status <- factor(status)
levels(status)

quadrado <- function(numero) {
  numero ** 2
}
quadrado(9)

par_ou_impar <- function(numero) {
  if (numero %% 2 == 0) {
    'Par'
  } else {
    'Ímpar'
  }
}
9 |> par_ou_impar()

menor_media <- function(...) {
  numeros <- c(...)
  numeros[numeros < mean(numeros)]
}
menor_media(1, 3, 5, 7, 9)

analise <- function(...) {
  notas <- c(...)
  list(media = mean(notas), quantidade_acima_media = sum(notas[notas > mean(notas)]))
}
