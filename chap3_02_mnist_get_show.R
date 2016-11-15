# ゼロから作るDeep Learingをなるべく元の本のコードに準拠しつつ、R実装する
# 3.7. (p72-)　手書き数字認識

# mnistデータの取得/解凍 ---------------------------------------------------------
# Yann LeCun のMNISTのページから入手するのは前処理が面倒なので、
# H2O World Training MaterialsからCSVを落としてくる。
require(R.utils)
require(data.table)

dataset_dir = "./dataset"
if(! dir.exists(dataset_dir)){
    dir.create(dataset_dir)
}

dlfile <-   paste(dataset_dir, "mnist_train.csv.gz", sep="/")
destfile <- paste(dataset_dir, "mnist_train.csv", sep="/")
if(! file.exists(destfile)){
  download.file(
    url = "https://s3.amazonaws.com/h2o-training/mnist/train.csv.gz",
    destfile = dlfile
  )
  gunzip(dlfile)
}

mnist_train <- fread(destfile, data.table = FALSE)
dim(mnist_train)

img_show <- function(v){
  v <- as.numeric(v[1:784])  #V785 はラベルデータ
  m <- matrix(v, 28, 28, byrow = FALSE)
  image(1:28, 1:28, z=m)
}

img_show( mnist_train[1,] )
# END ------------------------------------------------------------------------


