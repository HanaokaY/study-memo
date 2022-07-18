# class C
#     # CONST = "Hello, world"
# end

# module M
#     CONST = "モジュールMでの定義"
#     C.class_eval(<<-CODE) #=> 文字列を渡した場合はネストがクラスに移るから、CONSTが定義されている
#         def awesome_method
#             CONST
#         end
#     CODE
# end

# p C.new.awesome_method


# # 上記の例では、まずevalに文字列を渡しているからコンテキストがクラス内に移り、クラス内から定数の探索を開始する。
# # クラスに定義されていなければ、コンテキストはモジュールに移るということだ。


# # class C
# # CONST = "Hello, world"
# # end

# # module M
# #     C.class_eval do #=> コンテキストがモジュールMに移動して、なければ終わり。クラスには探索は行かない。
# #         def awesome_method
# #             CONST
# #         end
# #     end
# # end

# # p C.new.awesome_method

# array = ["a", "b", "c"].freeze
# # array.map! &:freeze #=> たとえfreezeメソッドであったとしても、freeze状態の配列にはmap!は使用不可
# array = array.map{|a| a + "a"} #=> これは破壊的メソッドを使用していないからオッケーらしい
# # array.each do |chr|
# #   chr.upcase!
# # end

# # p array


# # とにかく、特に注意すべきは、
# # !がついた破壊的メソッド(もちろん!がついていない破壊的メソッドもある)
# # 配列自体にfreezeをしていても要素自体には破壊的な変更は禁止していないということ。
# p '-------------------------------'


# class C
#     @@val = 10
# end

# module B
#     @@val = 30
# end

# module M
#     include B #=> レキシカルに定義されていなければ、includeしたモジュール内にコンテキストが移動する。
#     @@val = 20

#     class << C
#         # p @@val #=> 特異クラス定義の中であったとしても、クラス変数はレキシカルに決定される。
#         @@val
#     end
    
# end
# p "Cの特異クラスのクラス変数は、#{C.singleton_class.class_variable_get(:@@val)}"
# p "Cのクラス変数は、#{C.class_variable_get(:@@val)}"

# # 考え方
# # クラス変数はそのクラス内で決定される。
# # たとえ、Cクラスの特異クラスの定義の中でクラス変数を扱おうにも、モジュールMのスコープの中では、
# # クラス変数は20と決定されているから、レキシカルスコープ内では値は同じ

# p '-------------------------------'


# lines = ["4\n", "3\n", "2\n", "1\n"]
#   lines.map(&:chomp!)
#   lines.reverse
#   p lines

while not DATA.eof?
    lines = DATA.readlines
    p lines
    lines.map(&:chomp!)
    p lines
    lines.reverse #=> 破壊的メソッドじゃないから、次の行のlinesには影響してないのかな？
    lines.map &:succ! #=> やっぱりそうだ。破壊的メソッドにすると、次のp linesの結果も変わる。無意識だったことだ。
    p lines
end
__END__
1
2
3
4

