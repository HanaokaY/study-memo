# # # characters = ["a", "b", "c"]

# # # # characters.each do |chr|
# # # #   chr.freeze
# # # # end
# # # # characters.map &:freeze
# # # upcased = (characters.map &:freeze).map &:upcase
# # # # upcased = characters.map do |chr|
# # # #   chr.upcase #=> これは単純にupcaseは非破壊的メソッドでupcase!は破壊的メソッドだかららしい
# # # # end

# # # # p upcased


# # # # Procはcallまたは[]で呼び出すことができる



# # # class Ca
# # #     CONST = "001"
# # # end

# # # class Cb
# # #     CONST = "010"
# # # end

# # # class Cc
# # #     CONST = "011"
# # # end

# # # class Cd
# # #     CONST = "100"
# # # end

# # # module M1
# # #     class C0 < Ca
# # #         class C1 < Cc
# # #             class C2 < Cd
# # #                 p CONST #=> まずはレキシカルを探索、なければ継承チェーンを探索。

# # #                 class C2 < Cb
# # #                 end
# # #             end
# # #         end
# # #     end
# # # end
# # # # Rubyは定数の参照はレキシカルに決定されますが、この問題ではレキシカルスコープに定数はありません。
# # # # レキシカルスコープに定数がない場合は、スーパークラスの探索を行います。








# # module B
# #     @@val = 30
# # end

# # class AAA #=> レキシカルにもなくて、Cクラスにもない場合は、レキシカル->継承チェーンをたどるルールに基づいてこのスーパークラス(このクラス)に探索が来る
# #     # @@val = 15
# # end
# # class C < AAA #=> トップレベルに存在しなければ、まずこのクラスに探索が来る。このクラスに定義されていれば、このクラスで探索は終わる。
# #     include B
# #     # @@val = 10
# # end

# # # Object.class_eval(<<-EVAL)
# # #     @@val = 666
# # # EVAL


# # # module M
# # #     include B
# # #     @@val = 20

# # #     # class << C
# # #     #     @@val = 55
# # #     #     p @@val #=> クラス変数はレキシアkるに決定される。つまり、モジュール内で低ンカイされているなら、モジュール内で定義されているクラス変数となる。
# # #     # end
# # # end
# # class << C
# #     # @@val = 10
# #     def method_singleton_c
# #         p @@val
# #     end
# #     # C.class_eval do #=> evalにブロック渡して評価するとコンテキストが一つ外側になることにより、TOPLEVELのクラス変数を上書きすることになる
# #     #     @@val = 222
# #     # end
# #     # C.class_eval(<<-EVAL) #=> evalに文字列渡してクラスオープンしてクラス変数を上書き出来る。
# #     #     @@val = 111
# #     # EVAL
# #     # @@val = 55 #=> ここで特異クラス側のクラス変数の値を決定すると、クラス側のクラス変数の内容も変更されるようだ。
# #     # p @@val #=> クラス変数はレキシアkるに決定される。つまり、モジュール内で低ンカイされているなら、モジュール内で定義されているクラス変数となる。
# # end
# # # @@val = 777

# # p "Cのクラス変数は#{C.class_variable_get(:@@val)}" 
# # #=> クラス変数はレキシカルスコープから探索する。つまり、まずはこの処理が書いてあるスコープ(トップクラス)から探索が始まる。
# # # つぎにクラス内を探して、継承チェーンをたどる。



# # # やはり、探索はレキシカル->スーパークラス->includeしたモジュール


# # class String
# #     alias hoge reverse
# # end
  
# # p "12345".hoge




# # module M
# #     CONST = "Hello, world"
# #   end
  
# #   class M::C
# #     def awesome_method #=> レキシカルにCONSTが存在しない
# #       CONST
# #     end
# #   end
  
# #   p M::C.new.awesome_method

# # module M
# #     CONST = "Hello, world"
  
# #     class C
# #       def awesome_method
# #         CONST
# #       end
# #     end
# #   end
  
# #   p M::C.new.awesome_method

# # class C
# # end

# # module M
# #   CONST = "Hello, world"

# #   C.class_eval do #=> evalにブロックを渡しているから、コンテキストが外になるから、そこにはCONSTが定義されている。
# #     # 仮に文字列を渡していても、結局
# #     def awesome_method
# #       CONST
# #     end
# #   end
# # end

# # p C.new.awesome_method



# # class C
# #     # CONST = "Hello, world"
# #   end
  
# #   module M
# #     CONST = "Hello, worldM"
# #     C.class_eval(<<-CODE) #=> 外側にクラスが定義されている時はevalに文字列を渡していると、コンテキストがクラスに移るから上手くいくのかな？
# #       def awesome_method
# #         CONST
# #       end
# #     CODE
# #   end
  
# #   p C.new.awesome_method


# # class C
# #     CONST = "Hello, world"
# #   end
  
# #   module M
# #     C.class_eval do
# #       def awesome_method
# #         CONST
# #       end
# #     end
# #   end
  
# #   p C.new.awesome_method\


# f = Fiber.new do
#     2
#     Fiber.yield 15 #=> この行以前の処理は無視される。
#     5
#   end
  
# #   p f.resume
# #   p f.resume
# #   p f.resume


