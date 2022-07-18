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

# while not DATA.eof?
#     lines = DATA.readlines
#     p lines
#     lines.map(&:chomp!)
#     p lines
#     lines.reverse #=> 破壊的メソッドじゃないから、次の行のlinesには影響してないのかな？
#     lines.map &:succ! #=> やっぱりそうだ。破壊的メソッドにすると、次のp linesの結果も変わる。無意識だったことだ。
#     p lines
# end
# __END__
# 1
# 2
# 3
# 4


# class String
#     alias :hoge :reverse    
#     # alias hoge reverse    
# end
  
# p "12345".hoge





module M1
    def method_1
        __method__
    end
end

class C
    include M1
end

p C.new.method_1

module M2
    def method_2
        __method__
    end
end

module M1
    include M2 #=> サブモジュールを含めるには、クラスにインクルードする前にサブモジュールを継承ツリーに追加する必要があります。
end

# p C.new.method_2

# RExの問題で上記のコードを実行した結果を選択する問題
# 答えは例外が発生。
# でも、実際にはmethod_1は表示もされた上で、二回目のpで例外が発生する。
# 自分は、method_1も出力されるし、例外も発生すると解答したが、それだとだめなんだろうか。。。


# def foo(arg1:100, arg2:200)
#     puts arg1
#     puts arg2
#   end
  
#   option = {arg2: 900}
  
#   foo arg1: 200, **{arg2: 900}

# class Array
#     def succ_each(step = 1)
#         unless block_given? #=> ブロックを渡していなかったら、このスコープでブロックを生成してる感じ
#             Enumerator.new do |yielder|
#                 each do |int|
#                     yielder << int + step
#                     # チェーンした先で渡されたブロックを評価するためにはEnumerator::Yielderのオブジェクトを利用します。
#                     # オブジェクトに対して、<<を実行することでブロック内で評価した結果を受け取ることが出来ます。
#                 end
#             end
#         else
#             each do |int|
#                 yield int + step
#             end
#         end
#     end
# end

# p [98, 99, 100].succ_each(2).map {|succ_chr| succ_chr.chr}

# [101, 102, 103].succ_each(5) do |succ_chr|
#   p succ_chr.chr
# end




class Err1 < StandardError; end
class Err2 < Err1; end

begin
    raise ArgumentError
rescue StandardError => e #=> ここで指定されている例外クラスのサブクラスまでしかレスキューされないらしい。
    # つまり、StandardErrorでレスキューするならどのエラーが発生してもレスキューされる。
    # resucue StandardError => e ってこと。これなら大体の例外はStandardErrorのサブクラスだから、レスキューされる。
    p e.class
else
    p 'エラーは起きない'
end

