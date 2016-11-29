# ゼロから作るDeep Learingをなるべく元の本のコードに準拠しつつ、R実装する
# 3.6.2. (p75-)　手書き数字認識::ニューラルネットの推論処理
# そのまえにpickle形式の荷重をJSONに変換しておく。
# tutorials =  http://pythoninr.bitbucket.org/
# install.packages("PythonInR")

rm(list=ls())

require(tidyverse)
require(PythonInR)
require(jsonlite)

PythonInR:::pyConnectionCheck()
if( pyIsConnected() != TRUE ){
  # Windowsでの実行時以外はpythonExePathの指定は不要
  # ↓のPATHに空白(" ")が含まれているとパースエラーが起きるので注意。
  pyConnect(pythonExePath = "C:\\Anaconda3/python.exe")
}

# 仕方がないのでPythonで処理する。。 ----------------------------------------------------
# Python側で使うライブラリ群の読み込み
pyImport("sys")
pyImport("os")
pyExecp(code = 'sys.path.append(os.pardir)')
pyImport("pickle")
pyImport("json")

# いま自分がどこにいるか確認してから、適当なpathを指定する
getwd()
read_file <- "
with open(\"chap03/sample_weight.pkl\", \'rb\') as f: network = pickle.load(f)
"
pyExecp(code = read_file)

# 失敗してしまうが、不勉強なので原因がよくわからない。
write_JSON_file <- "
with open(\"chap03/sample_weight.json\", \'w\') as f: json.dump(network, f, sort_keys=True, indent=4)
"
# pyExecp(code = write_JSON_file)

# これも失敗：シリアライズされてるオブジェクトは変換できない？
p<- pyGet("network")
str(p)

# 仕方ないので一つずつ変換する：ベクトルの正しい取り出し方がわからなかった
pyExecp(code = "network.keys()") # -> dict_keys(['b2', 'b1', 'W2', 'W3', 'W1', 'b3'])

network_weight <- list(
  b1 = pyGet0(key="network[\'b1\']")$tolist(),
  b2 = pyGet0(key="network[\'b2\']")$tolist(),
  b3 = pyGet0(key="network[\'b3\']")$tolist(),
  W1 = pyGet( key="network[\'W1\']"),
  W2 = pyGet( key="network[\'W2\']"),
  W3 = pyGet( key="network[\'W3\']")
)
str(network_weight)

# うまく取得できたぽいのでJSON形式で保存する
write(file = "chap03/network_weight.JSON", toJSON(network_weight, pretty = TRUE))

x <- fromJSON("chap03/network_weight.JSON")
all.equal(network_weight, x)  # 微妙に丸められている...？

pyExit()


# END ---------------------------------------------------------------------
