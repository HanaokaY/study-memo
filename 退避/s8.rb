# module M1; end
# module M2; end
# class C1; include M1; end
# class C2
#     def foo
#         p self.ancestors
#     end
#     include M2
# end

# C2.new.foo
# インスタンスに対してancestorsメソッドは使えない。NoMethodError

module ModuleA
    def foo
        puts "modaleA"
        super
    end
end
class ClassB
    class << ClassB
        def foo
            p 'クラスメソッド'
        end
    end

    def foo
        puts 'classB'
    end
end
class ClassA < ClassB
    prepend ModuleA
end
# [ModuleA, ClassA, ClassB, Object, Kernel, BasicObject]
p ClassA.new.respond_to? :foo 
#=> prependによってfooメソッドが取り込まれていることがわかる。
#=> モジュールを取り込まない場合は、クラスBを継承しているため、どのみちfooメソッドは存在する。
ClassA.new.foo #=> インスタンスメソッドだからnewしないと実行できない。
cb = ClassB.new
class << cb
    def test
        p 'これは特異メソッド'
    end 
end
cb.test

# f = Fiber.new{
#     p "A"
#     Fiber.yield "B"
#     p "C"
#     Fiber.yield "ここまでが２回目"
#     p "さんかいめ"
# }
# p "D"
# p f.resume
# p "E"
# p f.resume
# f.resume

# マーシャリングとは？

# require 'json'
# h = {"a" => 1, "b" => 2}

# t1 = Thread.start{
#     raise ThreadError
# }
# sleep
# p t1.status


