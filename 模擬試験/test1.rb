class C1
    @val = 3 #=> これはクラスインスタンス変数
    attr_accessor :val
    class << self #=> これは特異クラスをオープンしている状態
      @val = 10 #=> これは特異クラスのクラスインスタンス変数
    end
    def initialize #=> インスタンス変数にアクセスできるのは、initializeメソッドとオブジェクトのインスタンスメソッドだけ
      @val *= 2 if val
    end
  end
  
#   c = C1.new  
#   c.val += 10
#   p c.val || "なにもない"

# between?メソッドを利用するにはクラスにComparableモジュールのインクルードが必要
# 3.between?(1, 5) 

class Ca
    CONST = "001"
end

class Cb
    CONST = "010"
end

class Cc
    CONST = "011"
end

class Cd
    # CONST = "100"
end
# CONST = "1111111111111"
class BasicObject
    CONST = "999999999999"
end
module M1
    class C0 < Ca
        class C1 < Cc
            class BasicObject
                class Object
                    class C2 < Cd
                        p self.ancestors
                        p CONST #=> 100
                        # レキシカルスコープに定数がない場合は、スーパークラスの探索を行います。
                        class C2 < Cb
                        end
                    end
                end
            end
        end
    end
end
# 定数の参照
# まずレキシカルすカープ内で該当の定数が定義されているか探索する。
# 見つからなければ継承チェーンを登って探索する。
# 今回のこの問題は継承チェーンを表しているわけではなくただ単にネストさせているだけだから、
# 他クラスで同名の定数が定義されていても関係ない


def foo(n)
    n ** n
end

foo = Proc.new { |n| #=> Procはcallまたは[]で呼び出す
    n * 3
}

# puts foo[2] * 2



# 演算	戻り値クラス
# Date同士の減算	Rational
# Time同士の減算	Float
# DateTime同士の減算	Rational


def hoge(*args, &block)
    block.call(args)
end

hoge(1,2,3,4) do |*args|
    # ここの引数でも*argsと受けっているから配列を渡した場合、配列の中に配列となる
    p args.length < 0 ? "hello" : args
end


module Parent
    def method_1
        __method__
    end
end

module Child
    # include Parent
    # extend self

    extend Parent
end

p Child::method_1
p Child.singleton_methods






