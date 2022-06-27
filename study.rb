# p (1..10).lazy.map{|num|
#     num * 2
# }.take(3).inject(0, &:+) 
# lazyは処理が効率良くなる感じ
# takeはarrayから指定の数の要素を扱う。
# injectは初期値0に対して、:+はarrayの合計値を足している。

def hoge(n)
    if n % 3 == 0
        "hello"
    elsif n % 5 == 0
        "world"
    end
end

# str = ''
# str.concat hoge(3)
# str.concat hoge(5)

# puts str

# inject
# array = 1..6
# p array.inject(:+) #配列の要素をすべて足す
# p array.inject(3,:+) #初期値3に対して、arrayの合計値を足す
# p array.inject(:*) #配列の要素をすべて掛ける
# p array.inject(3,:*) #初期値3に対して、arrayの合計値を掛ける
# p array.inject(100,:-) #100からarrayの合計値を引く

# Proc
# proc = Proc.new{|x| x.map{|x|p x.concat('さん')}}
# proc.call(['はなおか','さいとう','こうさか'])

# lambdaメソッド ruby1.9からの書き方
# lmd = -> (x){p x}
# lmd.call("はなおか")
# 個人的にはコレがラムダ関数なんだなってひと目ではわからりにくいから、
# 古い書き方のほうが良いかもしれない。↓

# lambdaメソッド　ruby1.9以前の書き方
lmd = lambda{|x| p x }
# lmd.call("さいとう")
# コッチのほうがprocインスタンス生成時にlambdaと名前がつくから、
# ひと目でラムダ関数なんだなとわかりやすい気がする。

# スレッド
# t = Thread.new do 
#     p "スタート"
#     sleep 5
#     lmd.call("さいとう")
#     p '終わり'
# end

# p '待って'
# t.join

# ファイバ ※kotlinでいうコルーチン
# f = Fiber.new do
#     (1..3).each do |i|
#         Fiber.yield i
#     end
#     nil
# end
# p f.resume
# p f.resume
# p f.resume
# p f.resume
# p f.resume

# ループを途中で抜ける脱出構文

# 10.times do |i|
#     next if i == 5
#     print i," "
# end

# 例外処理

# begin
#     p 1
# rescue # => エラーがないからここだけが実行されない。
#     p 0
# else
#     p 2
# ensure
#     p 3
# end

def foo
raise
rescue
    p 1
end
# メソッド内部のエラーが発生したら、rescue以降が実行される。






