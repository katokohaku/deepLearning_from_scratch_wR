# ゼロから作るDeep Learingをなるべく元の本のコードに準拠しつつ、R実装する
# common functions & utilities
require(data.table)
require(tidyverse)
require(foreach)
require(magrittr)

change_ont_hot_label <- function(v){
  m <- foreach(idx = 1+unlist(v), .combine = rbind)  %do% { 
    one_hot <- rep(0, 10)
    one_hot[ idx ] <- 1
    one_hot %>% t %>% data.frame
  }
 colnames(m) <- paste0("V",0:9)
 return(m)
}
change_ont_hot_label(0:9)


load_mnist_CSV <- function(
  save_file = "./dataset/mnist_train.csv", 
  normalize = TRUE,     # 画像のピクセル値を0.0~1.0に正規化する
  flatten   = TRUE,     # 画像を一次元配列に平にするかどうか
  one_hot_label = FALSE,# ラベルはone-hot配列として返す
  n_train   = 55000     # 教師データに使用するデータサイズ
  )
{
  stopifnot( file.exists(save_file))
  
  mnist <- fread(save_file, data.table = FALSE)
  train <- mnist %>% slice(1:n_train)
  test  <- mnist %>% slice((1+n_train):n())
  
  train_image <- train %>% select(-NCOL(mnist))
  train_label <- train %>% select( NCOL(mnist))
  test_image  <- test  %>% select(-NCOL(mnist))
  test_label  <- test  %>% select( NCOL(mnist))
  
  if( normalize ){
    train_image %<>% divide_by(255)
    test_image  %<>% divide_by(255)
  }

  
  if (one_hot_label){
    train_label %<>% change_ont_hot_label
    train_label %<>% change_ont_hot_label
  }  
  
  invisible(
    list(train_label = train_label,
         train_image = train_image,
         test_label  = test_label,
         test_image  = test_image
    )
  )
}

m <- load_mnist_CSV()
str(m, max.level = 1)  
