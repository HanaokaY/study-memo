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

