# module Parent
#     def method_1
#         __method__
#     end
# end

# module Child
#     include Parent
#     extend self
# end

# p Child::method_1
# extend selfすることによって、その時点でのモジュールを特異メソッドにするって感じ。
# だからインクルードした他モジュールのメソッドも特異メソッドの呼び出し方で実行できる。


# require 'yaml'

# yaml = <<YAML
#   sum: 510,
#   orders:
#     - 260
#     - 250
# YAML

# object = YAML.load yaml

# p object


# class Object
#     CONST = "1"
#     def const_succ
#         CONST.succ!
#     end
# end

# class Child1
#     const_succ
#     class << self
#         const_succ
#         p Object::CONST #=> 特異クラスも最初の読み込み時に実行される
#     end
# end

# class Child2
#     const_succ
#     def initialize
#         const_succ
#     end
# end

# Child1.new
# Child2.new
# p Object::CONST


class Array
    def succ_each(step = 1)
        p block_given?
        return to_enum(__method__, step) unless block_given?
       p block_given? #=> 一度目にブロック無しで呼ばれたら、次はブロックある状態で実行されている事がわかる。
        each do |int| #=> ここのeachはselfの配列を省略して記述してるっぽい
            yield int + step
        end

    end
end

[97, 98, 99].succ_each.map {|int|
    p int.chr
}

# to_enumかenum_forでEnumeratorオブジェクトを作成することが出来る。
# 第一引数にはメソッド名をシンボルで入れる。
# とりあえずこの手の問題はEnumeratorオブジェクトを作っているんだという認識でいく。
