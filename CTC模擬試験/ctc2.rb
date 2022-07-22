
# # [コード]
# class Foo
#     def initialize(obj)
#         # obj.fof #=> undefined method `fof' for #<Bar:0x00007fd230125200> (NoMethodError)
#         obj.foo
#     end

#     def foo
#         puts "foofoofoo"
#     end
# end

# class Bar
#     def foo
#         puts "barbarbar"
#     end
# end

# Foo.new(Bar.new) #=> barbarbar


# # [コード]
# class Bar
#     def foo
#         puts "barbarbar"
#     end
# end

# class Foo < Bar
#     def initialize(obj)
#         obj.foo
#     end

#     def foo
#         puts "foofoofoo"
#     end
# end

# Foo.new(Foo.new(Bar.new))



# 感想

# 引数にオブジェクトを渡して、オブジェクトの特異メソッドを実行することってできたんだな〜って感じ。