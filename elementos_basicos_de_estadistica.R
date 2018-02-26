#-----------------------------------------
#Día 2 - Elementos básicos de Estadística.
#-----------------------------------------

#-----------------------
#ESTADISTICA DESCRIPTIVA
#-----------------------
#Utilizando el dataset iris:
#   Calcular máximo, mínimo, media, mediana, varianza y desviación estándar de Petal.Length para cada especie.
#   ¿Cuál tiene mayor media? ¿Y mayor varianza?
#   Ayuda: ?max, ?min, ?mean, ?median, ?var, ?sd, ?summary

#El dataset iris viene precargado en R. Podemos analizar la estructura del dataset
class(iris) #Qué tipo de estructura de datos es
str(iris)   #Qué tipo de datos contiene
colnames(iris) #Los nombres de las columnas
nrow(iris) #Cuántas filas tiene
head(iris) #Imprimir las primeras filas
tail(iris) #Imprimir las últimas filas
table(iris$Species) #Qué especies tiene especies

#Para acceder a la columna Petal.Length podemos hacerlo de varias formas
head(iris$Petal.Length)      #Las tres formas son equivalentes
head(iris[, 3])              #Las tres formas son equivalentes
head(iris[, "Petal.Length"]) #Las tres formas son equivalentes
class(iris$Petal.Length)     #El tipo de dato ya no es más data.frame sino vector numérico
str(iris)                    #Qué tipo de datos contiene

#Máximo y mínimo de Petal.Length
max(iris$Petal.Length)
min(iris$Petal.Length)

?mean #Ayuda para mean
vec_prueba <- c(seq(1:9), NA, NA, NA) #Generamos un vector de prueba para demostrar como trabajar con NA
mean(vec_prueba)
mean(vec_prueba, na.rm = TRUE)

#media, mediana, varianza y desviación estándar de Petal.Length
mean(iris$Petal.Length)
median(iris$Petal.Length)
var(iris$Petal.Length)
sd(iris$Petal.Length)
summary(iris$Petal.Length)

#Máximo, mínimo, media, mediana, varianza y desviación estándar de Petal.Length para cada especie
#Tenemos que subsetear! Primero generamos un vector con todos los elementos de cada especie. 
#A mano sabiendo que las filas 1:50 corresponden a setosa, 51:100 a versicolor y 101:150 a virginica
iris 
setosa     <- 1:50
versicolor <- 51:100
virginica  <- 101:150
setosa
versicolor
iris[setosa, ]

#Generando un índice de true y false de 150 posiciones donde hay true en la especie que queremos
setosa <- versicolor <- virginica <- rep(FALSE, 150)
setosa[1:50]       <- TRUE
versicolor[51:100] <- TRUE
virginica[101:150] <- TRUE
setosa
versicolor
iris[setosa, ]

#Aprovechando las operaciones vectorizadas
setosa     <- iris$Species == "setosa" #Compara cada elemento de la columna Species con la palabra "setosa" 
                                       #y devuele TRUE o FALSE para cada elemento como vector.
versicolor <- iris$Species == "versicolor"
virginica  <- iris$Species == "virginica"
setosa
versicolor
iris[setosa, ]

#El último método nos permite trabajar con datos mezclados en lugar de datos ordenados y sin que tengamos que 
#ver manualmente que filas ocupan los datos que queremos usar.
#Estudiamos setosa
max(iris$Petal.Length[setosa])
min(iris$Petal.Length[setosa])
mean(iris$Petal.Length[setosa])
median(iris$Petal.Length[setosa])
var(iris$Petal.Length[setosa])
sd(iris$Petal.Length[setosa])

#Comparamos las tres y todas juntas de nuevo
summary(iris$Petal.Length[setosa])
summary(iris$Petal.Length[versicolor])
summary(iris$Petal.Length[virginica])
summary(iris$Petal.Length)

#--------
#GRAFICOS
#--------
#Graficar Petal.Length vs. Petal.Width para “setosa”. ¿Hay correlación entre ambas? 
#¿y para Sepal.Length vs. Sepal.Width? Ayuda: ?plot
#El método básico para graficar en R se llama plot. Permite realizar muchos tipos de gráficos distintos.
?plot #Vemos como se construye un plot

#Scatter plot - gráfico base con x vs y
length(iris$Petal.Length[setosa]) #Misma cantidad de x que de y
length(iris$Petal.Width[setosa])

#Gráfico básico
plot(iris$Petal.Length[setosa], iris$Petal.Width[setosa])

#Agregamos etiquetas
plot(iris$Petal.Length[setosa], iris$Petal.Width[setosa], main="Petal Length vs. Petal Width (setosa)", xlab="Length", ylab="Width")

#Cambiamos los límites 
plot(iris$Petal.Length[setosa], iris$Petal.Width[setosa], main="Petal Length vs. Petal Width (setosa)", xlab="Length", ylab="Width", xlim=c(0.5, 2.5), ylim=c(0, 1))

#¿Hay correlación?
?cor
cor(iris$Petal.Length[setosa], iris$Petal.Width[setosa])

#¿y para Sepal.Length vs. Sepal.Width?
plot(iris$Sepal.Length[setosa], iris$Sepal.Width[setosa], main="Sepal Length vs. Sepal Width (setosa)", xlab="Length", ylab="Width", xlim=c(3.5, 6.5), ylim=c(2, 5))
cor(iris$Sepal.Length[setosa], iris$Sepal.Width[setosa])

#Histogramas
#Realizar un histograma de Petal.Length para todas las especies juntas y marcar la media de cada especie en 
#el gráfico. Modificar la cantidad de breaks del histograma para mejorar la visualización. 
#¿Se puede discriminar cada especie en el histograma? Ayuda: ?hist, ?abline
?hist
hist(iris$Petal.Length, main="Petal Lenght de todas las especies") #Histograma básico
#Cambiamos la cantidad de divisiones que tiene el histograma y lo pintamos
hist(iris$Petal.Length, main="Petal Lenght de todas las especies", breaks=30, col="lightblue")
#Mostramos un histograma de frequencias en lugar de cuentas
hist(iris$Petal.Length, main="Petal Lenght de todas las especies", breaks=30, col="lightblue", freq = FALSE)

#Rectas
?abline
#Armamos un vector con las medias para cada especie
m <- c(mean(iris$Petal.Length[setosa]), mean(iris$Petal.Length[virginica]), mean(iris$Petal.Length[versicolor]))
m
abline(v=m, col=c("blue", "red", "green"), lty=c(1,4,3), lwd=c(1, 1, 2)) #Imprimimos las rectas verticales
                                                                         #con distintas formas y tamaños

#Agregamos la leyenda
?legend
legend("topright", c("Setosa", "Versicolor", "Virginica"), #La ubicación puede ser una palabra o un par (x,y)
       col=c("blue", "red", "green"), lty=c(1,4,3), lwd=c(1, 1, 2))
       
#Boxplot
#Realizar un boxplot de Petal.Length y Sepal.Width para todas las especies. 
#¿Varía la longitud de los pétalos entre especies? ¿Y del ancho de los sépalos? Ayuda: ?boxplot
?boxplot
boxplot(iris$Petal.Length)
#A mano
boxplot(iris$Petal.Length[setosa], iris$Petal.Length[virginica], iris$Petal.Length[versicolor], col=c("red", "green", "blue"))
#Usando distintas "fórmula"
boxplot(iris$Petal.Length ~ iris$Species, main = "Petal Length")
boxplot(Petal.Length ~ Species, data = iris, main = "Petal Length")
boxplot(iris$Sepal.Width ~ iris$Species, main = "Sepal Width")

#--------------
#Distribuciones
#--------------

#Utilizando el generador de números aleatorios:
#Obtener 1000 números reales con distribución uniforme entre 0 y 10 y graficar un histograma. Ayuda: ?runif
?runif
unif <- runif(1000, min=0, max=10)
hist(unif)

#Obtener 10000 números reales con distribución uniforme entre 0 y 10 y graficar un histograma. Ayuda: ?runif
unif <- runif(10000, min=0, max=10)
hist(unif)

#Obtener 100000 números reales con distribución uniforme entre 0 y 10 y graficar un histograma. Ayuda: ?runif
unif <- runif(100000, min=0, max=10)
hist(unif)

#¿Qué pasa al aumentar la muestra?

#Tirar una moneda 10 y 1000 veces y graficar el resultado en un histograma. ¿Qué pasa al aumentar la muestra?
#Ayuda: ?sample
moneda <- sample(c("cara", "ceca"),10,replace=T)
barplot(table(moneda))
table(moneda)

moneda <- sample(c("cara", "ceca"),1000,replace=T)
barplot(table(moneda))
table(moneda)

#Tirar un dado de 6 caras
dado <- sample(1:6, 1000, replace=T)
hist(dado, breaks = 0:6)
table(dado)

#Obtener un grupo de 1000 números con distribución normal con media 3 y desviación estándar 2.
#Calcular la media y la desviación estándar del grupo. ¿Son exactamente las esperadas? 
#¿Por qué? Realizar un histograma. Ayuda: ?rnorm
?rnorm
norm <- rnorm(1000, mean = 3, sd = 2)
mean(norm)
sd(norm)
hist(norm)

#Estandarizar los números anteriores y realizar un histograma. 
#¿Cuánto valen la media y la desviación estándar ahora? Ayuda: z = ( x-mean(x) ) / sd(x)
z = ( norm-mean(norm) ) / sd(norm) #Notar que las operaciones de + - * / pueden aplicar un escalar
                                   #a cada uno de los elementos de un vector
mean(z)
sd(z)
hist(z)

#¿Qué tipo de distribución parece ser? Utilizar el test de Shapiro-Wilk para decidir si la distribución es 
#normal o no. Ayuda: ?shapiro.test()
shapiro.test(z)

#Graficar la densidad estimada para Sepal.length de setosa y superponerle su histograma (con freq = FALSE).
#¿Qué tipo de distribución parece ser? ¿Cómo podés "verificarlo"? Ayuda: ?density
d <- density(iris$Sepal.Length[setosa])
plot(d)
hist(iris$Sepal.Length[setosa], add = TRUE, freq = FALSE)
shapiro.test(iris$Sepal.Length[setosa])
