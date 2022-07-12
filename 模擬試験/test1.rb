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
    class << self
        def method_2
            p 'クラスメソッド'
        end
    end
end

module Child
    include Parent
    # extend self
    # extend Parent
end

class Class3
    include Parent
end
# Class3.method_2
# p Class3.method_1

# Rubyでは全てのインスタンスには必ず特異クラス（シングルトンクラス）が存在
# 特異クラスとは、特定のインスタンスのみに適用されるクラスの事を指します。
# そしてクラスメソッドというのは、あるクラスの特異クラスに定義されたメソッドのことを指しているのです。
# 特異クラス=クラスメソッドの住む場所



# extendについて
# モジュールをクラスに取り込む際にextendを使用すると、
# モジュール内のインスタンスメソッドをselfの特異メソッドとして追加する。

# これが何を意味するか。
# 取込先のオブジェクト(クラスでよく使われる)では、いわゆるクラスメソッドとして使用可能になるのだ。
# 下記がその例だ。
module SampleModule
    def sample_method
        p 'これはモジュールのメソッドだ'
    end
    def self.not_extend_method; end
end
class SampleClass; extend SampleModule; end
SampleClass.sample_method #=> これはモジュールのメソッドだ

# SampleClass.not_extend_methodはエラーとなる。
# 理由は、extendでオブジェクトに取り込むことができるメソッドはインスタンスメソッドだけだからだ。
# not_extend_methodはモジュール内で定義された特異メソッド(クラスメソッド)である。
# 何故クラスメソッドは取り込み不可なのか。
# その理由は、Rubyのオブジェクト指向モデルを見れば理解しやすい。
# Rubyでは全てのインスタンスには必ず特異クラス（シングルトンクラス）が存在する。
# そして、特異メソッドは特異クラスに定義されたメソッドのことを言う。
# つまり、いわゆるクラスメソッドはインスタンスの特異クラスに存在しているため、
# クラスメソッドを発見して呼び出すことが出来るのは、特異クラスに該当するインスタンスのみなのだ。
# だから、クラスメソッドに関しては取り込むことができない。
# 仮にクラスメソッドのみが定義されたモジュールをインクルードしたとしても、なにもメソッドを取り込めていないのと同じことだ。

# なぜもクラスではクラスメソッドが継承されているのか？
# モジュールの特異メソッド(クラスメソッド)は定義してあっても、クラスインスタンスにインクルードすると参照先インスタンスでは使用不可になる。
# ※というか、実際にはモジュールのクラスメソッドは取り込むことができていないのだ。
# 手書きの継承チェーンを図したものを見るとわかりやすい。
# Cクラスにてクラスメソッドを定義する。
# Class C
# def self.method; end
# end
# コレは、Cクラスに定義しているように見えるが、実際はCクラスの特異メソッドに定義していのだ。
# したがって、特異クラスの縦の継承チェーンではself.methodが継承されていっているのがわかる。
# ※厳密には継承されているというよりは、該当のメソッドを実行する際に定義されているクラスまで探索が行われる。
# コレにより、Aクラスからself.methodは実行することが出来るわけだ。
# さらに、クラスメソッドをクラスのインスタンスである図のaオブジェクトが実行することができない理由は、aからはAクラスの特異クラスが見えていないから。


class SampleClass3
    def sample_method2
        p 'SampleClass3定義のインスタンスメソッド'
    end
end


# include
class SampleClass2 < SampleClass3; include SampleModule; end
p SampleClass2.instance_methods(false) #=> [] クラス、モジュールを継承しても空

# 上記の結果は[](空っぽ)なのである。
# 今までインクルードや継承をすると、さも継承したクラスにもスーパークラスと同名のメソッドが取り込まれる(再定義される感覚？)と思っていたが、
# 実際にはメソッドが呼ばれてから、定義元であるクラスまで探索が行っているだけっぽい？
