p (1..10).lazy.map{|num|
    num * 2
}.take(3).inject(0, &:+) 
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
proc = Proc.new{|x| p x}
proc.call(1)

