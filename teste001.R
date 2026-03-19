library(ggplot2)


nome <- c('Caio', 'Júlia', 'Lucas', 'Luiza')
idade <- c(18, 20, 16, 16)
dados <- data.frame(cbind(nome, idade))
ggplot(data = dados, aes(x = nome, y = idade, group='idade', color = idade)) + geom_line() + geom_point()

