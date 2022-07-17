val = 100

def method(val)
  yield(15 + val)
end

_proc = Proc.new{|arg| val + arg }

# p method(val, &_proc)

# Procオブジェクトをメソッドで実行するにはブロックに変換する必要があります。
# &を付ける必要がある。
# to_procは正直意味はないがついていてもエラーにはならない。

class C
    @@val = 10 #=> 特異クラスにも参照されている
end

module B
    @@val = 30
end

module M
    include B
    @@val = 20

    class << C
        # p @@val
    end
    p C.class_variable_get(:@@val)
end

p C.singleton_class.class_variable_get(:@@val) #=> 特異クラスにもクラスと同じクラス変数が共有されている。


# class C
#     class << self
#       @@val = 10
#     end
#   end
  
#   p C.class_variable_get(:@@val) # 10が表示される
# クラス変数はクラスに所属するあらゆるもので情報を共有する為にあり、
# 特異クラス定義の中でクラス変数を定義してもレキシカルに決定されます。