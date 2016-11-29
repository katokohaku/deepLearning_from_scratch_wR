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




# def relu_grad(x):
#   grad = np.zeros(x)
# grad[x>=0] = 1
# return grad



softmax <- function(x){
  
  
}
#   if x.ndim == 2:
#   x = x.T
# x = x - np.max(x, axis=0)
# y = np.exp(x) / np.sum(np.exp(x), axis=0)
# return y.T 
# 
# x = x - np.max(x) # オーバーフロー対策
# return np.exp(x) / np.sum(np.exp(x))
# 







# 
# 
# def softmax(x):
#   if x.ndim == 2:
#   x = x.T
# x = x - np.max(x, axis=0)
# y = np.exp(x) / np.sum(np.exp(x), axis=0)
# return y.T 
# 
# x = x - np.max(x) # オーバーフロー対策
# return np.exp(x) / np.sum(np.exp(x))
# 
# 
# def mean_squared_error(y, t):
#   return 0.5 * np.sum((y-t)**2)
# 
# 
# def cross_entropy_error(y, t):
#   if y.ndim == 1:
#   t = t.reshape(1, t.size)
# y = y.reshape(1, y.size)
# 
# # 教師データがone-hot-vectorの場合、正解ラベルのインデックスに変換
# if t.size == y.size:
#   t = t.argmax(axis=1)
# 
# batch_size = y.shape[0]
# return -np.sum(np.log(y[np.arange(batch_size), t])) / batch_size
# 
# 
# def softmax_loss(X, t):
#   y = softmax(X)
# return cross_entropy_error(y, t)
