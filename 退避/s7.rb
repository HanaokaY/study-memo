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

# p C.class_variable_get(:@@val)

# x = [3,5,3,6,7,2]
# p x.sort{|a,b| a <=> b}

class CC
    MSG = "msg1"
    MSG2 = "msg2"
    class C2
        MSG = "C2::msg1"
        puts MSG
        puts MSG2
    end
    puts MSG
    puts MSG2
end
# 定数の探索はまず自クラス、その次に外側のクラスを探索する。

# C2::msg1
# msg2
# msg1
# msg2
# p CC::C2.constants
# p CC.constants
# p C2.class #=> uninitialized constant C2 (NameError)

# class ClassA
#     def greet
#         p "hello from ClassA"
#     end
# end

# 下記3つとも同じ意味
# ClassA.new.greet
# ::ClassA.new.greet
# Object::ClassA.new.greet

class ClassA
    def greet
        p "Hello from ClassA"
    end
    MSG = 'hello'

    class ClassB
        def greet
          p  "Hello from ClassA::ClassB"
        end

        class ClassA
            def greet
               p "Hello from ClassA::ClassB::ClassA"
            end
        end

        class ClassC
            def relative
                ClassA.new.greet
            end

            def absolute_by_double_colon
                ::ClassA.new.greet
            end

            def absolute_by_object
                Object::ClassA.new.greet
            end

            def sample
                p MSG
            end
        end
    end
end

# ClassA::ClassB::ClassC.new.relative                  #=> "Hello from ClassA::ClassB::ClassA"
# ClassA::ClassB::ClassC.new.absolute_by_double_colon  #=> "Hello from ClassA"
# ClassA::ClassB::ClassC.new.absolute_by_object        #=> "Hello from ClassA"
# ClassA::ClassB::ClassC.new.sample



class Object
    private
    def foo
        puts 'hello'
    end
end
def foo
    puts 'hello'
end
# トップレベルはオブジェクトクラス。
# トップレベルで定義されたメソッドはprivate。

# /(\d+)/ =~ "abcd12defgh"
# puts $1

ary = [1,2,3].freeze
# ary[1] = 3 #=> can't modify frozen Array: [1, 2, 3] (FrozenError)
# p ary.object_id #=> 60
# ary += [4,5]
# p ary.object_id #=> 80
# p ary

class Err1 < StandardError; end
class Err2 < Err1; end

begin
    Err2
rescue Err1 => e #=> ここで指定されている例外クラスのサブクラスまでしかレスキューされないらしい。
    # つまり、StandardErrorでレスキューするならどのエラーが発生してもレスキューされる。
    puts "Error"
end

