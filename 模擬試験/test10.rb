# val = 100

# def method(val)
#   yield(15 + val)
# end

# _proc = Proc.new{|arg| val + arg }

# # p method(val, &_proc)

# # Procオブジェクトをメソッドで実行するにはブロックに変換する必要があります。
# # &を付ける必要がある。
# # to_procは正直意味はないがついていてもエラーにはならない。

# class C
#     @@val = 10 #=> 特異クラスにも参照されている
#     def self.val(num)
#         @@val = num
#     end
# end

# module B
#     @@val = 30
# end

# module M
#     include B
#     @@val = 20 #=> レキシカルに決定されるから、このスコープではこの情報がすべて

#     class << C
#         p @@val
#     end
#     # p C.class_variable_get(:@@val) #=> 実際にクラス位に定義されているクラス変数は10だけど、
#     # このスコープではレキシカルに決定されるから、20となる。
#     p C.class_variable_get(:@@val)
#     C.val(@@val)
#     p C.class_variable_get(:@@val)
# end

# # p C.singleton_class.class_variable_get(:@@val) #=> 特異クラスにもクラスと同じクラス変数が共有されている。
# # クラス変数はレキシカルに決定されるらしい

# # class C
# #     class << self
# #       @@val = 10
# #     end
# #   end
  
# #   p C.class_variable_get(:@@val) # 10が表示される
# # クラス変数はクラスに所属するあらゆるもので情報を共有する為にあり、
# # 特異クラス定義の中でクラス変数を定義してもレキシカルに決定されます。


# (1..100).each.lazy.chunk(&:even?) #=> 先頭から5つの値を取り出すなら、
# # .first(5)
# # .take(5).force



# class S
#     def initialize
#         puts "S#initialize"
#     end
# end

# class C < S
#     def initialize(*args)
#         super() #=> superと呼び出した場合は、現在のメソッドと同じ引数が引き継がれます。
#         # 引数を渡さずにオーバーライドしたメソッドを呼び出す際はsuper()とします。
#         puts "C#initialize"
#     end
# end

# C.new(1,2,3,4,5)


# 親のメソッドが引数なしで定義しているのに、サブクラス側で引数ありでオーバーライドして、superで呼び出す際にはsuper()としなければならない。


class AAA
    def method_a
        p 'hello'
    end
end
class BBB < AAA
    def method_a(a)
        p "#{super()} #{a}"
    end
end
# BBB.new.method_a("はなおか")


# class Human
#     NAME = "Unknown"
  
#     def self.name
#         p self
#       const_get(:NAME)
#     end
#   end
  
#   class Fukuzawa < Human
#     NAME = "Yukichi"
#   end
  
#   puts Fukuzawa.name

# class C
#     CONST = "Hello, world"
# end

# $c = C.new

# class D
#     class << $c
#         def say
#             CONST
#         end
#     end
# end

# p $c.say


module M
    @@val = 75

    class Parent
        @@val = 100
    end

    class Child < Parent
        p @@val #=> Parentのクラス変数を継承している
        @@val += 50
    end

    if Child < Parent
        @@val += 25
    else
        @@val += 30
    end
end

p M::Child.class_variable_get(:@@val)
p "モジュールMのクラス変数は#{M.class_variable_get(:@@val)}"



class Human
    NAME = "Unknown"
  
    def self.name
    #   const_get(:NAME) #=> const_getメソッドを使っているから、そのクラスで定義している定数(Unknown)が取得される。
      NAME #=> もし、定数だけを返すメソッドなら、定数の探索はレキシカルに行われるから、メソッドを定義しているこのクラス内から探索
    end
  end
  
  class Fukuzawa < Human
    NAME = "Yukichi"
  end
  
  puts Fukuzawa.name

#   通常的な考え方として、定数の探索はメソッドが定義されているレキシカルスコープから開始される。

# もし、サブクラスから定数探索が必要なメソッドを呼び出したとしても、定数探索はスーパークラスから開始されて、
# 次にその親クラスといった順番で探索をするため、サブクラスに定数の探索が入ることはない。


# 31

10.times{|d| p "#{d} < 2...#{d} > 5の結果は#{d < 2...d > 5 ? "O" : "X"}" }
# 以下、実行結果
# "0 < 2...0 > 5の結果はO"
# "1 < 2...1 > 5の結果はO"
# "2 < 2...2 > 5の結果はO"
# "3 < 2...3 > 5の結果はO"
# "4 < 2...4 > 5の結果はO"
# "5 < 2...5 > 5の結果はO"
# "6 < 2...6 > 5の結果はO" #=> 2...6は、2以上6未満。だからここまでがtrue
# "7 < 2...7 > 5の結果はX"
# "8 < 2...8 > 5の結果はX"
# "9 < 2...9 > 5の結果はX"
# 左辺がtrueの間は実行され続け、右辺がtrueになったときに範囲式としての結果がfalseになる。

# 下記問題なく実行できる例
p 1 < 2...6 > 7 ? 'ok' : 'bad'
p 1 < 2..6 > 7 ? 'ok' : 'bad'
p 1 < 1 and 5 > 7 ? 'ok' : 'bad'
p 1 < 1 or 5 > 7 ? 'ok' : 'bad'
p 1 < 3 or 4 or 5 > 7 ? 'ok' : 'bad'
p 1 < 3 or 4 or 5 > 7 ? 'ok' : 'bad'
p 1 < 1,8 > 7 ? 'ok' : 'bad' #=> これは趣旨が変わる。

# Range.new(1, 5) # 1 以上 5 以下 #=> これは範囲式オブジェクトの生成になるから、上の式ではつかえない。
# 1..5            # 同上
# 1...5           # 1 以上 5 未満



# Kernelモジュールに定義されているメソッド
p Array("Awesome Array") #=> ["Awesome Array"]
p Hash(awesome_key: :value) #=> {:awesome_key=>:value}
p String('0123456789') #=> "0123456789"


# 40

class C
    def self._singleton
      class << C
        self
      end
    end
  end
  
  p C._singleton
# メソッド内でただ単にselfを返すだけだと、実行しているクラスが返ってしまう。
# 特異クラスを返すのであれば、メソッド内でclass << Cといった形で、特異クラスのselfというのを明示的に示す必要がある。

# class C
# end
# p C.singleton_class

# class C
# end

# class << C
#   def _singleton
#     self
#   end
# end

# p C._singleton

# class C
# end

# def C._singleton
#   self
# end

# p C._singleton