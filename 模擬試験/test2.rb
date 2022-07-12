module Parent
    def method_1
        __method__
    end
end

module Child
    include Parent
    extend self
end

p Child::method_1
# extend selfすることによって、その時点でのモジュールを特異メソッドにするって感じ。
# だからインクルードした他モジュールのメソッドも特異メソッドの呼び出し方で実行できる。
