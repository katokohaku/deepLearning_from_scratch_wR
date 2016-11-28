# ゼロから作るDeep Learingをなるべく元の本のコードに準拠しつつ、R実装する
# 3.6.2. (p75-)　手書き数字認識::ニューラルネットの推論処理
rm(list=ls())

# mnistデータの取得/解凍 ---------------------------------------------------------
source("dataset/mnist.R")

# get data
mnist <- load_mnist_CSV()
str(mnist, max.level = 1)

# initialize network
network_weight <- fromJSON("./network_weight.JSON")
str(network_weight)


# def predict(network, x):
#   W1, W2, W3 = network['W1'], network['W2'], network['W3']
# b1, b2, b3 = network['b1'], network['b2'], network['b3']
# 
# a1 = np.dot(x, W1) + b1
# z1 = sigmoid(a1)
# a2 = np.dot(z1, W2) + b2
# z2 = sigmoid(a2)
# a3 = np.dot(z2, W3) + b3
# y = softmax(a3)
# 
# return y
# 
# 
# x, t = get_data()
# network = init_network()
# accuracy_cnt = 0
# for i in range(len(x)):
#   y = predict(network, x[i])
# p= np.argmax(y) # 最も確率の高い要素のインデックスを取得
# if p == t[i]:
#   accuracy_cnt += 1
# 
# print("Accuracy:" + str(float(accuracy_cnt) / len(x)))

# END ------------------------------------------------------------------------


