# ゼロから作るDeep Learingをなるべく元の本のコードに準拠しつつ、R実装する
# common functions & utilities

require(ggplot2)
require(tidyverse)
require(foreach)
#  ------------------------------------------------------------------------

identity_function <- function(x){ 
  x
}
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
# # or
# relu <- Vectorize( function(x){ max(0, x) })


