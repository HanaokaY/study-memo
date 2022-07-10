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
class A
    @@x = 0
    class << self
        @@x = 1
        def x
            @@x
        end
    end

    def x
        @@x = 2
    end
end

class B < A
    @@x = 3
end

p A.x

# クラスインスタンス変数とインスタンス変数は定義の仕方と、見た目は同じ。
# 定義する場所が違う。クラスインスタンス変数はクラス定義式内で定義される（メソッド内で初期化されない）。
# 普通のインスタンス変数はinitializeなどのメソッド内で初期化される。