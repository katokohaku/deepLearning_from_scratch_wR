# ゼロから作るDeep Learingをなるべく元の本のコードに準拠しつつ、R実装する
# 3.3. (p53-)　多次元配列の計算~3層ニューラルネットワークの実装
rm(list=ls())
source("common/functions.R")

#  ------------------------------------------------------------------------


# 一応行列の内積もカバーしておく
# matrix of 2x3
A <- matrix(c(c(1,2,3),c(4,5,6)), nrow = 2, ncol = 3, byrow = TRUE)
A; dim(A)

# matrix of 3x2
B <- matrix(c(c(1,2),c(3,4),c(5,6)), nrow = 3, ncol = 2, byrow = TRUE)
B; dim(B)

# 内積
A %*% B

C <- matrix(c(7,8), nrow = 2, byrow = TRUE)
B %*% C


# 3.4.1. ニューラルネットワークの内積 ----------------------------------------------------------

X <- c(1,2) 
X; dim(X)

W <- matrix(c(c(1,3,5),c(2,4,6)), nrow = 2, ncol = 3, byrow = TRUE)
W; dim(W)

Y <- X %*% W
# この本を真面目に模写ならcrossprod()を使う方がやりやすい?
# matrix(c(1,2), nrow = 2, byrow = TRUE)
# crossprod(X,W)


# 3.4.2 各層における信号伝達の実装 -----------------------------------------------------
# from input to 1st layer: (A1 = X * W1 +b1) %>% sigmoid() -> Z1
X  <- c(1.0, 0.5)
W1 <- matrix(c(c(0.1,0.3,0.5), c(0.2,0.4,0.6)), nrow = 2, byrow = TRUE)
b1 <- c(0.1,0.2,0.3)
dim(W1) # -> NULL instead (2,3)
dim(X)  # -> (2,1)
dim(b1) # -> NULL instead (3,1)

A1 <- X %*% W1 + b1
Z1 <- sigmoid(A1)
print(A1) # -> 0.3  0.7  1.1
print(Z1) # 丸め精度が違う..?

# from 1st to 2nd layer: (A2 = A1 * W2 +b2)%>% sigmoid() -> Z2
W2 <- matrix(c(0.1,0.4,  0.2,0.5,  0.3,0.6), nrow = 3, ncol = 2, byrow = TRUE)
b2 <- c(1.0, 0.5)
str(Z1) # -> num [1, 1:3] 0.574 0.668 0.75, instead (3,)
str(W2) # ->  num [1:3, 1:2] as dim[3,2]
str(b2) # ->  num [1:2] 1 0.5, instead (2,)
A2 <- Z1 %*% W2 + b2
Z2 <- sigmoid(A2)

# from 2nd to output layer: (A3 = A2 * W3 +b3) %>% identity_function() -> Y

identity_function <- function(x){ x }

W3 <- matrix(c(0.1,0.3, 0.2,0.4), nrow = 2, byrow = TRUE)
b3 <- c(0.1,0.2)           
A3 <- Z2 %*% W3 + b3
Y <- identity_function(A3)

# 実装のまとめ：関数化 --------------------------------------------------------------
init_network <- function(){
  network <- list()
  network[["W1"]] <- matrix(c(0.1,0.3,0.5,  0.2,0.4,0.6), nrow = 2, byrow = TRUE)
  network[["b1"]] <- c(0.1,0.2,0.3)
  network[["W2"]] <- matrix(c(0.1,0.4,  0.2,0.5,  0.3,0.6), nrow = 3, ncol = 2, byrow = TRUE)
  network[["b2"]] <- c(1.0, 0.5)
  network[["W3"]] <- matrix(c(0.1,0.3, 0.2,0.4), nrow = 2, byrow = TRUE)
  network[["b3"]] <- c(0.1,0.2) 
  
  return(network)
}


forward <- function(network, x){
  W1 <- network[["W1"]]
  b1 <- network[["b1"]]
  W2 <- network[["W2"]]
  b2 <- network[["b2"]]
  W3 <- network[["W3"]]
  b3 <- network[["b3"]] 
  
  A1 <- X %*% W1 + b1
  Z1 <- sigmoid(A1)
  
  A2 <- Z1 %*% W2 + b2
  Z2 <- sigmoid(A2)
  
  A3 <- Z2 %*% W3 + b3
  Y <- identity_function(A3)
  
  return(Y)
}

network <- init_network()
x <- c(1.0, 0.5)
y <- forward(network, x)

Y # 本での出力値とずいぶん違うので丸め誤差だけなのかどうか不明

# END ---------------------------------------------------------------------
