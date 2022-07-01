# def内でdef式の呼び出し

class C1
    def method1
        def method2
        end
    end
end

# p C1.instance_methods(false)
# C1.new.method1
# p C1.instance_methods(false) # 結果が変わる

# メソッドは普段、クラス内で定義しているからクラスに属していることが明らか
# 今回のような場合、method2の定義先はどこになるのか
# それは、method1のselfとなる。
# つまり、結局C2(クラス)

# includeとprependの違い

module M1
    def method1; "m1"; end
end

class C2
    prepend M1
    def method1; "c2"; end
end

class C3
    include M1
    def method1; "c3"; end
end

# p C2.new.method1
# p C3.new.method1

# C2のprependメソッドの方は、ancestorsメソッドで継承チェーンを
# 確認すればわかるけど、モジュールに対応する特異クラスを先頭に追加するため
# 先にモジュール内のメソッドから呼ばれる。


# クラスメソッドの定義
# Classクラスにメソッドを追加することでクラスメソッドになる。
class Class
    def c_method1
        "Classクラスのメソッド"
    end
    # p self.ancestors
end

# p C3.c_method1
# p Class.ancestors

# p self.class
# p :Kernel.methods

# クラス変数

class Quex5
    @@v1 = 1
    def v1; @@v1; end
    def v1=(value); @@v1 = value; end
end

class SubQuex5 < Quex5
end

# qux5 = Quex5.new
# qux5.v1=(5)
# p qux5.v1

# subquex5 = SubQuex5.new
# p subquex5.v1

# 名前空間、定数、モジュール
# ::は名前空間
# p Math.constants #=> [:PI, :E, :DomainError]
# p Math::PI #=> 3.141592653589793 円周率が格納された定数

# 名前空間は同名のメソッドの衝突を防いでくれる。

# def num
#     p 1
# end
# def num
#     p 2
# end
# num #=> 2
# num #=> 2
# 後述のメソッドにより最初のnumメソッドが同盟だから上書きされてしまう。
# 要は２つは同じメソッド。最初にメソッドを定義して、すぐにオープンしただけ。
# これがそれぞれ別のクラスに定義されていれば別のメソッドとなる。


# 組み込みクラス

# clone

a1 = [1,2,3]
ac1 = a1.clone
# ac1.freeze
# p ac1
# ac1[0] = 2
# p ac1


# もしかして、rubyでは整数は基本的に勝手にFixnumクラスのオブジェクトになってる？
p 10.class #=>Integer
# 全然違ったわ
# ruby2.4からIntegerに一本化されたらしい


# 1.5.step(50,2.5){|i|puts i}

p "はなおかゆうだい"[1..3]
# sliceと同じ結果

name = "はなおかゆうだい"
name.slice!(1..3)
p name

a = [1,2,3,4,5,6,2]
# p a.join(", ")

h1 = {"apple" => "fruit", "coffee" => "drink"}
# h1.delete("apple") # 破壊的
# h1.delete_if{|key,value|value == "fruit"} # 同じく破壊的
# p h1.reject{|key,value| value == "drink"} # 破壊的ではない
h1.reject!{|key,value| value == "drink"} # 破壊的
# p h1










