# # class C
# # end

# # p C.singleton_class.singleton_class.singleton_class.singleton_class
# # 単純に特異クラスの特異クラスが存在するものらしい


# # def hoge(*args, &block)
# #     block.call(*args) #=> 引数に渡すときにアスタリスクがないと配列全体を一つの要素として渡す。
# # end

# # hoge(1,2,3,4) do |*args|
# #     p args.length < 0 ? "hello" : args
# # end


# # class Human
# #     attr_reader :name
  
# #     def name
# #       "Mr. " + super #=> 親クラスはObjectクラス。親にnameメソッドなんてない。
# #     end
  
# #     def initialize(name)
# #       @name = name
# #     end
# #   end
  
# #   human = Human.new("Andrew")
# #   puts human.name

# # class Human
# #     attr_reader :name
  
# #     def name
# #       "Mr. " + @name
# #     end
  
# #     def initialize(name)
# #       @name = name
# #     end
# #   end
  
# #   human = Human.new("Andrew")
# #   puts human.name
  

# # class Human
# #     attr_reader :name
  
# #     def name
# #       "Mr. " + name #=> nameメソッドの中で同名のメソッドを呼び出していますので、再帰呼出しになっています。終了せず、例外が発生します
# #     end
  
# #     def initialize(name)
# #       @name = name
# #     end
# #   end
  
# #   human = Human.new("Andrew")
# #   puts human.name


# # Rubyオプション
# # -l: 各行の最後に String#chop!を実行します。
# # -p: -nと同じだが$_を出力
# # -n: 同上



# # class C
# #     def m1(value)
# #       100 + value
# #     end
# #   end
  
# #   module R1
# #     refine C do
# #       def m1
# #         super 50
# #       end
# #     end
# #   end
  
# #   module R2
# #     refine C do
# #       def m1
# #         super 100 #=> superはクラスCにあるm1を呼び出す。
# #       end
# #     end
# #   end
  
# #   using R1
# #   using R2 #=> 最後に書いたusingから優先される。
  
# #   puts C.new.m1



# # prepend M1 m2 #=> 複数モジュールを指定した場合は、左側が先にメソッド探索されます。



# module M
#     def foo
#       super
#       puts "M#foo"
#     end

#   end
  
#   class C2
#     def foo
#       puts "C2#foo"
#     end
#   end
  
#   class C < C2
#     def foo
#       super
#       puts "C#foo"
#     end
#     prepend M
#     # 継承チェイン上で、self のモジュール/クラスよりも「手前」に追加されるため、
#     # 結果として self で定義されたメソッドは override されます。
#     # この継承チェーンが手前になることでオーバーライドされることを忘れがち
#   end
  
# #   C.new.foo

# #   prependすることでself の継承チェインの先頭に「追加する」ため、Cのオブジェクトに直接紐付いているのがMモジュールになるイメージ



# v1 = 1 / 2 == 0
# v2 = !!v1 or raise RuntimeError
# puts v2 and false

# # def foo(arg1:100, arg2:200)
# #     puts arg1
# #     puts arg2
# #   end
  
# #   option = {arg2: 900}
  
# #   foo arg1: 200, **option

# # def bar(&block) #=> 実行してもエラーにならない
# #     block.call
# #   end
  
# #   bar do
# #     puts "hello, world"
# #   end


# # def bar(n, &block) #=> 実行してもエラーにならない
# #     block.call
# #   end
  
# #   bar(5) {
# #     puts "hello, world"
# #   }


# # def bar(&block) #=> 実行してもエラーにならない
# #     block.yield
# #   end
  
# #   bar do
# #     puts "hello, world"
# #   end

# # ブロックを引数で受け取って処理を呼び出す方法
# # block.call
# # block.yield



# # module M
# #     def a
# #       100
# #     end
  
# #     module_function :a #=> モジュール関数とは、プライベートメソッドであると同時にモジュールの特異メソッドでもあるようなメソッドです。
# #   end
  
# #   p M.a

# # module M
# #     class << self
# #       def a
# #         100
# #       end
# #     end
# #   end
  
# #   p M.a

# proc = lambda { |n|
#     n.to_s
# }

# # p Object.methods
# p [1,2,3,4].map(&proc)

# # p [1,2,3,4].map do |num|
# #     :to_s.to_proc.call(num)
# # end


# # usingはメソッドの中で呼び出すことは出来ない


# m = Module.new

# m.instance_eval do #=> ブロックでオープンした場合は、一つ外側にネストのコンテキスト？があたる。
#   m.instance_variable_set :@block, Module.nesting #=> [] -> オブジェクトが入ってる場合は空になる。
# end

# m.instance_eval(<<-EVAL) #=> 文字列をevalに渡した場合は、コンテキストは内部から始まる。つまりnestingで自身も含まれる。
#   m.instance_variable_set :@eval,  Module.nesting
# EVAL
# #=> [m]
# block = m.instance_variable_get :@block
# _eval = m.instance_variable_get :@eval

# puts block.size
# puts _eval.size
# # それぞれの配列の中は0と1になる。
# # 実際には実態はないがObjectも含まれている。

# def foo(arg:) #=> キーワード引数 : 省略不可の引数らしい
#     puts arg
#   end
# #   foo 100 #=> つまり、コレはエラー arg:100とするべき



# class Foo
#     attr_reader :var #=> 特異メソッドもインスタンスメソッドもどちらも生成されるっぽい

#     @var = "1"

#     def initialize
#         @var = "2"
#     end
# end

# class Baz < Foo
#     def self.var
#         @var
#     end
# end

# def Foo.var
#     @var
# end

# arr = [
#     Foo.new.var, #=> 2
#     Foo.var, #=> 1
#     Baz.new.var, #=> 2
#     Baz.var #=> nil
# ]
# # クラスインスタンス変数
# # そのクラスのみでしか参照できない
# # そのクラスを継承したクラスではその変数にアクセスできない

# p arr


# begin
#     p "liberty" + :fish.to_s
#   rescue TypeError
#     p "TypeError."
#   rescue
#     p "Error."
#   else
#     p "Else."
#   end
  

  

CONST = "Object hello"
class Base
    attr_accessor :CONST
  CONST = "Hello, world" #=> Cのレキシカルにないから、prepend Pに行く前にこのクラスのレキシカルに定数があるから、ここがヒットする。
end

class C < Base
end

module P
  CONST = "Good, night"
end

class Base
  prepend P #=> この時点で C > P(Good, night) > Base(Hello, world) > Object
end

module M
  class C #=> これはM::Cクラスだから上のCクラスとは別物
    CONST = "Good, evening"
  end
end

module M
  class ::C #=> これはモジュール内で記述しているが::で始まる定数はトップクラスをさしている。つまり、291行目のCクラス。
    def greet
      CONST #=> prepend Pで継承チェーンがC > Baseだから、CにCONSTがないからHello, world
    #   Pはモジュールだから、継承チェーン的にはPと思いがちだが、最初に探索されるのは親クラスかららしい。
    #   BaseにCONSTが定義されていなければ、Pモジュールを探索しに行っているみたいだ。
    end
  end
end

p C.new.greet
# p ::C.ancestors


module NN
    NAME = 'NN'
end

module N
    prepend NN
    NAME = 'N'
end

class D
    prepend N
    # NAME = 'D'
end

class A < D
    # NAME = 'A'
end

p A.const_get(:NAME)
p A.ancestors

# 結論
# まずはレキシカルスコープを探索 >> 次に継承しているクラスのレキシカル >> prependしているモジュールのレキシカル
# この順番で定数の探索をしているっぽい

module MM
    def self.method_m
        p 'MM_hello'
    end
end
class AA
    class << self
        def method_a
            p 'AA_hell'
        end
    end
end

class BB < AA
    include MM
end

BB.method_a #=> これはAA特異クラスに定義されているクラスメソッドをBB > 特異BBクラス > 特異AAクラスの探索して実行されている。
# さて、モジュール内のクラスメソッドはインクルードすれば使えるのか？
# 慶長チェーン的には使えるように見えるが、
p BB.ancestors #=> [BB, MM, AA, Object, Kernel, BasicObject]
# BB.method_m #=> 実際は使えない。なぜなら、チェーン上には映るが、スーパークラスで調べても出ない。特異クラスの継承チェーンにはいないから、探索ルートにいない。


