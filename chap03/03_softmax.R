# ゼロから作るDeep Learingをなるべく元の本のコードに準拠しつつ、R実装する
# 3.5. (p66-)　出力層の設計：恒等関数とソフトマックス関数
rm(list=ls())
# -> implimente into ("common/functions.R")

#  ------------------------------------------------------------------------

# 恒等関数は入力をそのまま出力する
identity_function <- function(x){ x }

# ソフトマックス逐次的処理

a <- c(0.3, 2.9, 4.0)
exp_a <- exp(a)         # -> 1.349859 18.174145 54.598150
sum_exp_a <- sum(exp_a) # -> 74.12215
y <- exp_a / sum_exp_a  # -> 0.01821127 0.24519181 0.73659691

# ソフトマックスの関数化
softmax <- function(a){

  exp_a <- exp(a)
  y <- exp_a / sum(exp_a)
  return( y )
}
softmax(a)  # -> 0.01821127 0.24519181 0.73659691



softmax <- function(x){
  
  
}


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




# END ---------------------------------------------------------------------
