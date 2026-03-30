# Agrupar os dados em listas (concatenação de variáveis)
# Uma lista pra cada exercício - conteúdo: cargas na ordem em ordem cronológica 

puxada_aberta <- c(65, 65, 65, 65, 65, 65, 65, 65, 70, 70, 70, 70, 70, 70, 70, 70, 75, 75, 75, 75, 77, 75, 80, 80)
puxada_fechada <- c(65, 50, 55, 65, 55, 60, 60, 65, 65, 65, 70, 70, 70, 70, 70, 70, 70, 75, 80, 80, 80, 85, 80, 77, 80, 80, 80)
remada_fechada <- c(65, 65, 65, 65, 70, 70, 70, 70, 75, 75, 80, 80, 80, 85, 85, 84, 85, 85, 90, 90)
remada_unilateral <- c(24, 27, 27, 29, 31, 31, 32, 31, 33, 33, 36, 36, 36, 36, 34, 34, 37, 37, 37, 37, 37, 37)
rosca_direta <- c(14, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 18, 16, 18, 18, 18, 18, 18, 18, 18, 18)
rosca_scott <- c(10, 12, 12, 12, 12, 12, 12, 10, 15, 20, 20, 20, 20, 20)
rosca_45 <- c(12, 14, 12, 12, 12, 12, 12, 10, 12, 12, 14, 14, 14, 14, 14, 14)
rosca_barra <- c(35, 40, 40, 45, 45, 50, 50, 50, 50)
rosca_martelo <- c(14, 14, 14, 16, 16, 16, 12, 18, 16, 18)
remada_curvada <- c(30, 35)
remada_maquina <- c(40, 50, 60)

#

ex01 <- c(10, 15, 20)
ex02 <- c(40, 50, 60)
treino <- data.frame(ex01, ex02)
rownames(treino)[1] <- 'Dia 1'
treino

# Eixo x - exercícios / eixo y - séries / informação - repetições

supino_inclinado <- c(4, 4, 4)
supino_maquina <- c(7, 7)
cross_alto <- c(9, 5, 4)
elevaçao_frontal <- c(8)
elevaçao_lateral <- c(10, 9, 9)
triceps_barra <-c(7, 5)
triceps_frances <- c(8, 8)
remada_unilateral <- c(6, 6, 6)
treino <- data.frame(supino_inclinado, supino_maquina, cross_alto, elevaçao_frontal, elevaçao_lateral, triceps_barra, triceps_frances, remada_unilateral)
rownames(treino) <- c('Série 1', 'Série 2', 'Série 3')
treino

