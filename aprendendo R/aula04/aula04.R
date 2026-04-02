# Descobrindo o tipo do dado
x <- 10
class(x)

# Convertendo tipos
as.numeric(x)
as.character(x)
as.logical(x)

# Criando um fator (variável categórica)
sexo <- factor(c('M', 'F', 'F', 'M'))
levels(sexo)

# Criando um fator com números em forma de 'character' e mostrando eles como valores 'numeric'
numeros <- factor(c('1', '2', '3'))
as.numeric(as.character(numeros))

# Criando funções
minha_funcao <- function(parametro) {
  return(parametro * 2)
}
minha_funcao(5)

soma <- function(a=0, b=0) {
  return(a + b)
soma(3, 4)
}

# Uma função não necessariamente precisa de um 'return'
dobro <- function(a=0) {
  a * 2
}

# Função com condição
verificar <- function(nota) {
  if (nota >= 7) {
    return('Aprovado')
  } else {
    return('Reprovado')
  }
}