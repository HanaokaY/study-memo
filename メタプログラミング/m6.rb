# ブロックについて

# def a_method(a,b)
#     p block_given? ? 'block true' : 'No Block'
#     p a + yield(a,b)
# end

# a_method(1,2){|a,b|(a+b)*3}

def my_method
    x = "Goodbye"
    yield("cruel")
end

x = "Hello"
my_method{|y| "#{x},#{y}world" } #=> "Hello,cruelworld"
# 束縛
# ブロックは定義した時点での変数情報を格納するらしい。
# ブロックを受け取ったメソッド内にも同盟変数が定義されていたとしても、ブロックはメソッド内の変数は見ることができない。
# これを束縛という



# class,module,defのキーワードを使わなければスコープのフラット化が可能
# javaと同じくローカル変数を扱うことが出来る
my_var = "トップレベルのローカル変数"

MyClass = Class.new{
    # puts my_var

    define_method :my_method do
        puts my_var
    end
}

# MyClass.new.my_method


def d_method
    shared = 0

    Kernel.send :define_method, :counter do
        p shared
    end

    Kernel.send :define_method, :inc do |x|
        shared += x
    end
end

# d_method

# counter
# inc(4)
# counter

def methodb &block
    p block.call if block_given?
    # yieldでもいい
end

pr = proc{"hello"} #=> Proc.newでもいい
methodb &pr




# メソッドをオブジェクトにして、動的に新しいメソッドを作成
# ちょっと複雑

module MyModule
    def my_method
        p 'hello'
    end
end

unbound = MyModule.instance_methods(:my_method)
unbound.class #=> UnboundMethodというクラスやモジュールから引き離されたメソッドを指すクラスになる。

# String.send :define_method :another_method, MyModule.instance_methods(:my_method)
# "Stringのオブジェクト".another_method


class Sample
    def initialize
        @x = 1
    end
end

sa = Sample.new
sa.instance_eval do
    def sample_method
        p @x
    end
end
# 特異クラスにのみ作成するからsaの特異クラスにしかsample_methodは存在しない
p sa.singleton_class.instance_methods
p Sample.instance_methods


# オブジェクトの特異クラスのスーパークラスは、オブジェクトのクラスである。
# クラスの特異クラスのスーパークラスはクラスのスーパークラスの特異クラスである。


module M3
    # def self.m_hell #=> これだとインクルード先ではクラスメソッドとしては扱えない
    #     p 'm_hello'
    # end    

    def m_hell
        p "#{self}さんhello"
    end
end

class C3
    class << self
        def say_hello
            p 'hello'
        end
    end
end
class C4 < C3
    class << self
        include M3 #=> モジュールはインスタンスメソッドを提供する。つまり、クラス側でクラスメソッドにしてしまえばいい。
    end
end
C4.say_hello
# C4.m_hell #=> includeしたモジュールのクラスメソッドは手に入らない
C4.m_hell
# C4.new.m_hell #=> 逆にモジュールはクラスメソッドとして取り込まれているから、オブジェクトからの呼び出しはできない。

c4 = C4.new
def c4.only
    p 'c4の特異メソッド'
end
# class << c4
#     include M3 #=> この3行を簡単に行ってくれるメソッドがObject#extendである。
# end
c4.extend M3

c4.only
c4.m_hell


module Mod
    def self.foo
        p "Mod"
    end
end
class Cls2
    include Mod
end






