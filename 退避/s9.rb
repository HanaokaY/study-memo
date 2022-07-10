# a = 1.0 + 1
# p "#{a.class},#{a}" #=> Float
# a = a + (1/2r)
# p "#{a.class},#{a}" #=> Float
# a = a + (1 + 2i)
# p "#{a.class},#{a}" #=> Complex

# p 2r.class #=> Rational
# p 2i.class #=> Complex


# begin
#     "cat".narrow
# rescue NameError #=> なぜNoMethodErrorの例外処理をNameErrorが拾えるのか？＝＞NoMethodErrorの親クラスだから。
#    raise
# end


# 変数について記憶の整理
# 変数の種類 => グローバル変数、クラスインスタンス変数、クラス変数、インスタンス変数、ローカル変数
# 下記はクラス変数
# class A
#     @@x = 0
#     class << self
#         @@x = 1
#         def x
#             @@x
#         end
#     end

#     def x
#         @@x = 2
#     end
# end

# class B < A
#     @@x = 3
# end

# p A.x

# クラスインスタンス変数とインスタンス変数は定義の仕方と、見た目は同じ。
# 定義する場所が違う。クラスインスタンス変数はクラス定義式内で定義される（メソッド内で初期化されない）。
# 普通のインスタンス変数はinitializeなどのメソッド内で初期化される。

class A
    # @x = 0

    def initialize
        @x = 4
    end

    class << self
        p self.object_id
        def x
            @x = 11
        end
    end

    def x
        p self.object_id
        p @x
    end
end

# class B < A
#     @x = 3
# end
# A.x #=> クラスメソッドからはインスタンス変数にはアクセスできない
# A.new.x

# インスタンス変数
# インスタンス変数にアクセスできるのは、initializeメソッドとオブジェクトのインスタンスメソッドだけ

# クラス変数
# クラスとそのインスタンスがスコープになる
# クラスメソッド、インスタンスメソッド、クラス定義式内でアクセス可能

# クラスインスタンス変数
# ・アクセス可能
# クラスメソッドからはアクセスできる
# ・アクセス不可
# そのクラスのみでしか参照できない
# そのクラスを継承したクラスではその変数にアクセスできない
# インスタンスメソッドからアクセスすることはできない（クラスオブジェクトのインスタンス変数であるため。つまり自分とオブジェクトが違う。）

module Mod
    def foo
        p 'Modのfoo'
    end
end
class Cls1
    include Mod
end

class Cls
    # include Mod
    # prepend Mod
    def foo
        p 'Clsのfoo'
    end
    undef :foo
    # prepend Mod
end
# 「undef」という名前ですが、「呼ぶとNameErrorになるようにメソッドを定義する」と考えたほうが適切です。
# undef のより正確な動作は、メソッド名とメソッド定義との関係を取り除き、そのメソッド名を特殊な定義と関連づけます。
# この状態のメソッドの呼び出しはたとえスーパークラスに同名のメソッドがあっても例外 NameError を発生させます。
# 要は、undefを使ったら系諸チェーンを探索しに行くこともなくNoMethodErrorとなる。
# Cls.new.foo


p [1,3,4,6].sort{|a,b|a - b}

#p self #=> Objectクラスのオブジェクトであるmain

class << self
    def main_method
        p 'main#method'
    end
end

def hanaoka_method
    p 'これはトップレベルで定義してから継承先でパブリックに変更している'
end
class Test
    def hanaoka_method
        super
    end
end
Test.new.hanaoka_method

# トップレベルでメソッドを定義すると Object のメソッドとして定義される
# トップレベルの self が main っていう特別なオブジェクトなので、どうしてもそっちの方に意識が向くんですが、
# トップレベルの self とトップレベルのメソッドは特に関連性はありません。
# 一旦、mainについてはそういうものがあるって程度に留めておこう。

class Err1 < StandardError; end
class Err2 < Err1; end

begin
    raise Err2
rescue Err1 => e
    p e.class
end


