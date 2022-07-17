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



class S
    def initialize
        puts "S#initialize"
    end
end

class C < S
    def initialize(*args)
        super() #=> superと呼び出した場合は、現在のメソッドと同じ引数が引き継がれます。
        # 引数を渡さずにオーバーライドしたメソッドを呼び出す際はsuper()とします。
        puts "C#initialize"
    end
end

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
BBB.new.method_a("はなおか")


