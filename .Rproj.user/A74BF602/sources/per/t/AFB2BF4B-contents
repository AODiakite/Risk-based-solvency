# Préparation des données
data <- data.frame(energy = c(11.546653, 11.367820, 22.084005, 21.144520),
                   cpu = c(80.74489, 112.67965, 63.93077, 73.02971))

# Ajustement du modèle
library(forecast)
fit <- auto.arima(data$energy, xreg = data$cpu)

# Prédiction à différents horizons
h <- 3
fcast <- forecast(fit, h = h, xreg = rep(mean(data$cpu), h))
fcast

h <- 6
fcast <- forecast(fit, h = h, xreg = rep(mean(data$cpu), h))
fcast

# Code 2

# Préparation des données
data <- data.frame(energy = c(11.546653, 11.367820, 22.084005, 21.144520),
                   cpu = c(80.74489, 112.67965, 63.93077, 73.02971))

# Division des données en échantillons d'apprentissage et de test
n <- nrow(data)
n_train <- round(n * 0.8)
train <- data[1:n_train, ]
test <- data[(n_train + 1):n, ]

# Ajustement du modèle sur les données d'apprentissage
library(forecast)
fit <- auto.arima(train$energy, xreg = train$cpu)

# Prévision sur les données de test
fcast <- forecast(fit, h = nrow(test), xreg = test$cpu)

# Calcul du MAE et du RMSE
mae <- mean(abs(fcast$mean - test$energy))
rmse <- sqrt(mean((fcast$mean - test$energy)^2))

mae
rmse

