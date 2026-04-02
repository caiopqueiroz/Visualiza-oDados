#ex01
x <- '10'
class(x)
as.numeric(x)

#ex02
y <- c('1', '2', '3', '4')
as.numeric(y)

#ex03
cursos <- c('ADS', 'Engenharia', 'ADS', 'Direito')
cursos <- factor(cursos)
levels(cursos)

#ex04
triplo <- function(numero=0) {
  numero * 3
}

#ex05
verificar <- function(nota) {
  if (nota >= 7) {
    'Aprovado'
  } else {
    'Reprovado'
  }
}

#ex06
acima_media <- function(...) {
  numeros <- c(...)
  return(numeros[numeros > mean(numeros)])
}