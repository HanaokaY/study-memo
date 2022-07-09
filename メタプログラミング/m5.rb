# method_missingの活用例
# ゴーストメソッド
# 上記例のような、未定義だがmethod_missing()で拾うことを前提
# としたメソッドをゴーストメソッドと呼びます。


# method_missingを活用する上で注意しなければいけない例 -> 無限ループの後StackOverFlowが発生する
class Roulette
    def method_missing(name, *args)
        person = name.to_s.upcase
        3.times do
            number = rand(10) + 1
            puts "#{number}..."
        end
        "#{person} got a #{number}" #=> ここがよくない。ブロックローカル変数であるnumber
    end
end
# ブロック内で定義したブロックローカル変数は外部から参照できない
# そのため、「"#{person} got a #{number}"」のタイミングで Rubyはそれ（number）を「メソッド」だと認識し、探しにいく
# しかし継承チェーン内に見つからないためmethod_missing()が呼ばれる
# だが、そもそも今回の問題は（オーバーライドした）method_missing()自体で起きている
# よってバグは無限ループし続ける


class ClassName
    def foo
        p 'hello'
    end
end

class ClassName2
    def initialize(data)
        @data = data
    end
    def method_missing(name)
        !@data.respond_to?("#{name}") ? super : @data.send("#{name}")
    end
end

c2 = ClassName2.new(ClassName.new)
c2.foo


class Class2
    class << Class2
        def method_name
            p 'hello'
        end
    end
    method_name #=> 同スコープ内ならクラスメソッドもレシーバ指定なしで実行できる
end
