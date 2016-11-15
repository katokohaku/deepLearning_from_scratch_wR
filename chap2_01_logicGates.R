# ゼロから作るDeep Learingをなるべく元の本のコードに準拠しつつ、Rぽく実装する
# （１）パーセプトロンで論理ゲートが実装できる(p26-)
# 

x <- c(1, 0)
w <- c(0.5, 0.5)
b <- -0.7
w*x
sum(w*x) + b 

# ゲート関数
AND <- function(x1, x2){
  x <- c(x1, x2)
  w <- c(0.5, 0.5)
  b <- -0.7
  tmp <- sum(w*x) + b
  
  ifelse(tmp <= 0, 0, 1)
}
AND(1,1) #to be 1
AND(1,0) #to be 0
AND(0,1) #to be 0
AND(0,0) #to be 0

`%AND%` <- AND
1 %AND% 1
1 %AND% 0 
0 %AND% 1 
0 %AND% 0

# パーセプトロンを用いると、
# 重みとバイアスのちがいでAND/OR/NANDゲートが表現できる

NAND <- function(x1, x2){
  x <- c(x1, x2)
  w <- c(-0.5, -0.5) # ANDゲートとは荷重が反転
  b <- 0.7
  tmp <- sum(w*x) + b
  
  ifelse(tmp <= 0, 0, 1)
}
NAND(1,1) #to be 0
NAND(1,0) #to be 1
NAND(0,1) #to be 1
NAND(0,0) #to be 1

OR <- function(x1, x2){
  x <- c(x1, x2)
  w <- c(0.5, 0.5)
  b <- -0.2          # ANDゲートとはバイアスの大きさが異なる
  tmp <- sum(w*x) + b
  
  ifelse(tmp <= 0, 0, 1)
}
OR(1,1) #to be 1
OR(1,0) #to be 1
OR(0,1) #to be 1
OR(0,0) #to be 0

# XORゲートは単層のパーセプトロンでは表現できないが、
# 2層のパーセプトロンにすれば表現できる
XOR <- function(x1, x2){
  s1 <- NAND(x1, x2)
  s2 <- OR(x1, x2)
  y  <- AND(s1,s2) 
  return(y)
}
XOR(1,1) #to be 0
XOR(1,0) #to be 1
XOR(0,1) #to be 1
XOR(0,0) #to be 0


