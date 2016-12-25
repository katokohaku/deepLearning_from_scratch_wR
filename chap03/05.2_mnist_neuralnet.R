# ゼロから作るDeep Learingをなるべく元の本のコードに準拠しつつ、R実装する
# 3.6.2. (p75-)　手書き数字認識::ニューラルネットの推論処理
rm(list=ls())
source("common/functions.R")

# mnistデータの取得/解凍 ---------------------------------------------------------
source("dataset/mnist.R")

mnist <- load_mnist_CSV()
str(mnist, max.level = 1)

# initialize network as init_network()

network_weight <- jsonlite::fromJSON("./chap03/network_weight.JSON")
str(network_weight)

predict <- function(network, x){
  W1 <- network[["W1"]]
  b1 <- network[["b1"]]
  W2 <- network[["W2"]]
  b2 <- network[["b2"]]
  W3 <- network[["W3"]]
  b3 <- network[["b3"]]
  
  A1 <- unlist(x) %*% W1 + b1
  Z1 <- sigmoid(A1)
  
  A2 <- Z1 %*% W2 + b2
  Z2 <- sigmoid(A2)
  
  A3 <- Z2 %*% W3 + b3
  Y <- softmax(A3)
  
  return(Y)
}

# 予測正答数のカウントと正答率
true_labels <- mnist$test_label %>% unlist %>% as.integer
labels <- 0:9
X <- mnist$test_image

accuracy <- NULL
for(i in 1:NROW(X)){
  y <- predict(network = network_weight, X[i, ])
  p <- which.max(y)
  df <- data.frame(predict=labels[p], label=true_labels[i])
  accuracy <- rbind(accuracy, df)
}
accuracy %>% str
accuracy_cnt <- accuracy %$% sum(predict == label)

print(accuracy_cnt / NROW(accuracy))




# END ------------------------------------------------------------------------


