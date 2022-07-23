# 環境変数 ENV は「文字列」がキー。
# p ENV['sample']

# -Iオプション
# 引数で指定したディレクトリを$LOAD_PATH変数に追加する。
# 引数でしてしたディレクトリ($LOAD_PATH)はrequireやloadメソッドが呼ばれた時のファイル探索の際に使用される。

# 結合順
# 3.downto(0) {|i| puts i}
# 3.downto(0) do |i| puts i end
# 3.downto 0 do |i| puts i end
# 3.downto 0 {|i| puts i} #=> {}は()を省略することができないため文法エラーとなる。


# pメソッドとinspectメソッドの関係
# inspectメソッドはpメソッドでオブジェクトそのものを出力した際の文字列表現を指定するメソッドです。


