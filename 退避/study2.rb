# retry

# a = 0
# begin
#     b = 1 / a
# rescue ZeroDivisionError
#     a += 1
#     retry
# ensure
#     p b
# end


# catchとthrow
# def bar
#     catch(:calc) do 
#         throw :calc, "コレは元はthrowの引数"
#     end
# end

# p bar
# :calcはラベルと言って、catchとthrowをペアとして認識させる。
# throwにはラベルの他にも引数をもたせることができて、それは
# catchの戻り値となる。


# class C1
#     v1 = 'クラスで定義されたローカル変数です。'
#     def m1
#         v1 #=> Rubyはスコープをまたいだローカル変数は参照できない。
#     end
#     p v1 #=> 実行可能
#     p m1 #=> undefined local variable
# end


# インスタンス変数
# インスタンス変数はインスタンスごと

class Qux4
    attr_accessor :v3
    def method1; @v3; end
end

# q = Qux4.new
# x = Qux4.new
# q.v3 = 3
# x.v3 = 5
# p q.v3
# p x.v3

