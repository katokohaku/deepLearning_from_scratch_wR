# ゼロから作るDeep Learingをなるべく元の本のコードに準拠しつつ、R実装する
# 3.1 パーセプトロンからニューラルネットワークへ(p39-)
require(ggplot2)
require(tidyverse)
require(foreach)
# いろいろな活性化関数とグラフ  ---------------------------------------------
# ステップ関数
step_function <- function(x){
  ifelse( x>0, 1, 0)
}

# シグモイド関数
sigmoid <- function(x){
  1 / (1 + exp(-x)) 
}

# ReLU
relu <- function(x){
  foreach(i=x, .combine=c) %do% max(0, i)
}
# or
relu <- Vectorize( function(x){ max(0, x) })

# 可視化して比較
X <- seq(from = -5.0, to = 5.0, by = 0.01)
y_step    <- data.frame(x=X, y=step_function(X), f="step")
y_sigmoid <- data.frame(x=X, y=sigmoid(X),       f="sigmoid")
y_relu    <- data.frame(x=X, y=relu(X),          f="ReLU")

df <- rbind(y_step, y_sigmoid, y_relu)
df %>% str
  
p <- df  %>% ggplot(aes(x=x, y=y, colour=f, linetype=f)) +
  geom_line()
p






