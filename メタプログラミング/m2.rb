# class Array
#     def replace(original, replacement)
#         self.map{|e| e == original ? replacement : e}
#     end
# end
# p ["hello","hello2","hello3"].replace("hello3","置換")


# class MyClass
#     def initialize
#         @v = 1
#     end

#     def set=(val)
#         @v = val
#     end

#     def get
#         p self
#         p @v
#     end
# end

# m = MyClass
# => クラスはオブジェクトだけど、クラス名はあくまで定数。
# => だから、変更は不可だけど変数に代入することは可能。
# m_obj = m.new
# m_obj.get

# p m.ancestors
# p Class.ancestors


# ここは明示せずともObjectクラスを継承してBarクラスを生成
class Bar 
    def initialize(greet)
        @greet = greet
    end
end

# Fooという定数に、引数のBarクラスをスーパークラスとして
# Classクラスからクラス生成
Foo = Class.new(Bar) do
    def initialize(greet, name)
        @name = name
        super(greet)
    end

    def f_method(msg)
        @greet + @name + msg
    end
end

# インスタンスメソッドなので、クラスのインスタンスを生成しておくこと
foo = Foo.new("hello", " kuma")
# 生成インスタンスをレシーバに、メソッドを呼び出す
# p foo.f_method(" welcome!")
#=> "hello kuma welcome!"

# p Bar.ancestors
# p Foo.ancestors
# p Class.ancestors


module M
    tmp = 'Mのtmp' #=> ローカル変数はスコープを超えて参照できない
    TMP = 'Mのtmp定数'
    class C
        module M2
            # TMP = 'Mのtmp定数'
            p Module.nesting #=> [M::C::M2, M::C, M]
            p TMP
        end
    end
end

# オブジェクトとは、
# インスタンス変数の集まりにクラスへのリンクが付いたもの。
# クラスとは、
# オブジェクトにインスタンス一覧とスーパークラスへのリンクが付いたもの
# そんなClassクラスはModuleクラスのサブクラス。
# つまりクラスもModuleである。


# よくわかっていない点
# newメソッドはClassクラスのインスタンスメソッドだが、Class.newのように使うことも出来る。
# リファレンスを見ると、Classクラスにはインスタンスメソッドのnewと特異メソッドのnewがある。
# ただ、特異メソッドってインスタンス固有のメソッドっていう認識だったから、使えるとすればClassクラスのインスタンスで特異メソッドを定義して、
# ようやく使えるのかなって思っていた。


# そもそも特異メソッドとは
# 単一のオブジェクトに特化したメソッド。
# クラスメソッドとかはよく見る。
# クラスメソッドはそのクラスの特異メソッド(Singleton Method)。

# メソッドはクラスに属しますが、それでは特異メソッドはどこに定義されるのでしょうか？
# 正解は特異クラス（Singleton Class）
