# freezeの配列じゃない場合

# char = { :a => "A" }.freeze
# char[:a] = "B"
# p char
# 解説
# freezeメソッドはオブジェクトを変更不可能にするメソッドです。
# ハッシュオブジェクトの値を変更しようとしている行でエラーが発生し、プログラムが終了します。

# 

# a, b = [1, 2, 3]
# p a
# p b
# 解説
# Rubyは多重代入をサポートしておりますので、一度に複数の変数に代入することができます。問題文のコードは下記のコードと同様です。

# a = 1
# b = 2

# 左辺の変数の数より、右辺の値の数の方が多い場合は残りの値を破棄します。

# 

# class MyNum
#     attr_reader :num
#     def initialize(num)
#         @num = num
#     end
    
#     def <=>(other) #=> このメソッドを作成することが重要
#         @num <=>other.num
#     end
# end


# num1 = MyNum.new(30)
# num2 = MyNum.new(10)
# num3 = MyNum.new(20)
# p [num1, num2, num3].sort.map{|n| n.num }

# [実行結果]
# [10, 20, 30]
# 数値や文字列などの既存のオブジェクトに関しては、
# <=>演算子が定義されているので、sortメソッドを使用することができますが、
# 作成したクラスのオブジェクトには、<=>演算子を定義する必要があります。


# 

# ary = [:job1, :job2, :job3]
# ary.push(:job4)
# ary.unshift(:job5)
# ary.pop
# ary.shift
# p ary

# 解説
# Array#push, Array#pop, Array#unshift, Array#shiftはすべて配列の要素の追加と取り出しを行うメソッドです。

# ary = [:job1, :job2, :job3]

# ary.push(:job4) #=> 後ろに追加

# p ary     #=> [:job1, :job2, :job3, :job4]

# ary.unshift(:job5) #=> 先頭に追加

# p ary     #=> [:job5, :job1, :job2, :job3, :job4]

# ary.pop #=> 後ろを削除

# p ary     #=> [:job5, :job1, :job2, :job3]

# ary.shift #=> 先頭を削除

# p ary     #=> [:job1, :job2, :job3]


# 

obj = Object.new
def obj.hello
 puts "hello"
end
obj.hello
p obj.methods.include?(:hello) #=> インスタンスの特異メソッドだから、このインスタンスしか参照できないメソッドになる。
p Object.new.methods.include?(:hello)
# Object.new.hello #=> ここでNoMethodError
# 解説
# def obj.helloでobjの特異クラスに特異メソッドを定義しているわけだから、このインスタンスの特異クラスは他のインスタンスとは関係ない。
# 各インスタンスでmethodsメソッドで特異メソッドを確認すれば理解できる。


# 

class Foo
    def foo
        "foo"
    end
end


class Bar < Foo
    def foo
        super + "bar"
    end
    alias bar foo
    undef foo
end
puts Bar.new.bar


# 

# FileTestモジュールに存在しないメソッドを選択してください。
# => child?メソッド

# 

class Log
    [:debug, :info, :notice].each do |level|
        # __(1)__(level) do #=> 動的にメソッドを定義したい
        method_define(level) do
            @state = level
    end
    attr_reader :state
end

log = Log.new
log.debug  ; p log.state
log.info   ; p log.state
log.notice ; p log.state


# [実行結果]
# :debug
# :info
# :notice

# 

# webrickライブラリ
# => webrickライブラリは、Webサーバを実装するためのライブラリでRuby on Railsでも使用されている

# 



