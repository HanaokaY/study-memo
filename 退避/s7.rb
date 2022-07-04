# ary = Array.new(3,"a")
# # ary[0].next!
# # p ary
# ary.map{|a| puts a.object_id}

# a = [1,"hello",false]

# a.map{|a|
#     if String === a
#         p "#{a}はString"
#     end
# }

# while DATA.gets
#     puts $_ if $_ =~ /Ruby/
# end
# p DATA.gets

# __END__
# java programing
# Ruby programing
# C programing

# Ruby で__END__と書くと、それ以降のコードはプログラムではなくデータとして読み込まれる
# そのデータは、DATA という定数を使ってアクセスできる
# __END__と DATA はセットで使われることが多い


class A
    @@x = 0
    # class << self
    #     @@x = 1
    #     def x
    #         @@x
    #     end
    # end
    @@x = 4
    def x
        @@x
    end
end
class B < A
    # p @@x
    @@x = 3
    # p @@x
end
# クラス変数は最終的に上書きされた値が返ってくるっぽい
# クラス変数はスーパークラスとサブクラス間で共有されて最終定義が結果となる

# p A.new.x

module M
    def foo
        p 'M'
    end
end
class A2
    extend M
    class << self
        def foo
            super
            p 'A2'
        end
    end
end
A2.foo
# includeとprependと違って、extendはモジュールをクラス・メソッドとしてこむ。
# ancestorsメソッドで継承チェーンを確認しても、extendした場合はMがでない。


# class A
#     $a = self
#     def hoge
#         $b = self
#     end
# end
# a = A.new

# p A == $a
# p A.new.hoge == $b

# class Class1
#     def hello
#         "hello"
#     end
#     undef hello
# end

# obj1 = Class1.new
# p obj1.hello

class S
    @@val = 0
    def initialize
        @@val += 1
    end
end

class C < S
    def initialize #=> 改めて書くと、initializeは継承されてこんな感じになってる
        super
    end
    class << C
        @@val += 1
    end
end

C.new
C.new
S.new
S.new

p C.class_variable_get(:@@val)