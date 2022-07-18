class C
    # CONST = "Hello, world"
end

module M
    CONST = "モジュールMでの定義"
    C.class_eval(<<-CODE) #=> 文字列を渡した場合はネストがクラスに移るから、CONSTが定義されている
        def awesome_method
            CONST
        end
    CODE
end

p C.new.awesome_method


# 上記の例では、まずevalに文字列を渡しているからコンテキストがクラス内に移り、クラス内から定数の探索を開始する。
# クラスに定義されていなければ、コンテキストはモジュールに移るということだ。


# class C
# CONST = "Hello, world"
# end

# module M
#     C.class_eval do #=> コンテキストがモジュールMに移動して、なければ終わり。クラスには探索は行かない。
#         def awesome_method
#             CONST
#         end
#     end
# end

# p C.new.awesome_method

array = ["a", "b", "c"].freeze
# array.map! &:freeze #=> たとえfreezeメソッドであったとしても、freeze状態の配列にはmap!は使用不可
array = array.map{|a| a + "a"} #=> これは破壊的メソッドを使用していないからオッケーらしい
# array.each do |chr|
#   chr.upcase!
# end

p array


# とにかく、特に注意すべきは、
# !がついた破壊的メソッド(もちろん!がついていない破壊的メソッドもある)
# 配列自体にfreezeをしていても要素自体には破壊的な変更は禁止していないということ。