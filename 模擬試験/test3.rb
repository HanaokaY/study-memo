module M
    def class_m
        "class_m"
    end
end

class C
    include M
end

# p C.methods.include? :class_m
# Kernelモジュールのmethodsメソッドは、特異メソッドの一覧を取得するメソッド
# extendは特異メソッドとして追加する



# requireとloadの違い

# requireは同じファイルは1度のみロードする、loadは無条件にロードする。
# requireは.rbや.soを自動補完する、loadは補完は行わない。
# requireはライブラリのロード、=> 1回でいい
# loadは設定ファイルの読み込みに用いる。 => 都度読み込みたい


module SuperMod
    module BaseMod
        p Module.nesting # [SuperMod::BaseMod, SuperMod]
    end
end

module SuperMod::BaseMod
    p Module.nesting # [SuperMod::BaseMod]
end

# 記述方法が変わると結果が変わる点に注意


p "Matis my tEacher"[/[J-P]\w+[^ ]/] #=> [^ ]により空白手前まで
# 正規表現の[]は囲まれた文字1つ1つにマッチします。
# J-Pは大文字のJからPの1文字にマッチします。
# \wは大文字、小文字、数字とアンダーバー(_)にマッチします。
# +は直前の文字が、1回以上の繰り返しにマッチします。
# [^ ]は空白以外にマッチします。

# p "HANAOKAyudai"[/[A-Z]+\w/]

module M
    def class_m
        "class_m"
    end
end

class C
    include M
end

# p C.methods.include? :class_m #=> methodsメソッドは特異メソッドのみを取得するからincludeだとインスタンスメソッドとなるからfalse


# a = (1..5).partition(&:even?)
# odd?が奇数、even?が偶数

local = 0

p1 = Proc.new { |arg1, arg2| #=> lambdaだと引数に厳しいから、この問題ではエラーになる
  arg1, arg2 = arg1.to_i, arg2.to_i
  local += [arg1, arg2].max
}

p1.call("1", "2")
p1.call("7", "5")
p1.call("9") #=> lambdaだとArgumentError

# p local

#   module M
#     CONST = "Hello, world"
#   end
  
#   class M::C
#     def awesome_method
#       CONST
#     end
#   end
  
#   p M::C.const_defined?(:CONST) #=> 定数がレキシカルスコープ内に定義されていないからfalse。でも、継承チェーンをたどるから参照可能。
#   p M.const_defined?(:CONST)

# 定数の参照はレキシカルに行われる。

# module M #=> この状態なら定数をたどることが可能。
#     CONST = "Hello, world"
#     class C
#         def awesome_method; CONST; end
#     end
# end
  

# class C
#     CONST = "Hello, world"
# end

# module M
#     C.class_eval{
#         def awesome_method
#             CONST
#         end
#     }
# end

# p C.const_defined?(:CONST)

# class C
# end

# module M
#   CONST = "Hello, world"
#   C.class_eval do
#     p Module.nesting #=> ブロックを渡しているため、ネストの状態はM
#     def awesome_method
#       CONST
#     end
#   end
# end

# p C.new.awesome_method


# クラスのコンテキストでブロック(文字列)を評価する。
# インスタンスメソッドやクラスメソッドを定義したりできる。
# module_evalはclass_evalの別名。

# class_evalで注意しなくてはいけないことは、引数がブロックか文字列かで定数やクラス変数のスコープが変わること。
# ブロックの場合スコープはclass_evalの外側になる。
# 文字列の場合スコープはclass_evalで評価したclass

# class C
#     CONST = "Hello, world"
# end
# module M
#     C.class_eval(<<-CODE)
#     p Module.nesting
#         def awesome_method
#             CONST
#         end
#     CODE
# end
# p C.new.awesome_method


# class C
#     # CONST = "ブロックを渡しているから、外側のスコープがコンテキストになる。これは無視される。"
#   end
#   module M
#     # CONST = "ネストの状態は#{Module.nesting}"
#     C.class_eval do
#         CONST = "ネストの状態は#{Module.nesting}"
#       def awesome_method
#         CONST
#       end
#     end
#   end
  
#   p C.new.awesome_method


# begin
#     print "liberty" + :fish.to_s
#   rescue TypeError
#     print "TypeError."
#   rescue
#     print "Error."
#   else
#     print "Else." #=> エラーが発生しなかった場合の処理を行うにはelseを用います。
#   ensure
#     print "Ensure."
#   end
  


mod = Module.new
mod.module_eval do
  EVAL_CONST = 100
end
p "EVAL_CONST is defined? #{mod.const_defined?(:EVAL_CONST, false)}"
p "EVAL_CONST is defined? #{Object.const_defined?(:EVAL_CONST, false)}"



# TOPCONST = 'トップレベルの定数だよ'
# class C
#     # CCONST = 'Cの定数だよ'
#   end
  
#   # ブロックの場合スコープはclass_evalの外側になる。この場合トップレベル
#   C.class_eval do
#     p Module.nesting # ネストの状態はトップレベル
#     # => []
#     p TOPCONST
#     CCONST = 'Cの定数だよ'
#     # => "トップレベルの定数だよ"
#     # p CCONST # クラスCはスコープ外
#     # => NameError
#   end


#   p Object.const_defined?(:CCONST, false)
#   p C.const_defined?(:CCONST, false)

# --------------------------------------------------------------------------------
# ブロックを渡した場合は、
# eval内で定数を定義しても、評価しているクラス内に定義されるわけではなく、
# 外側のスコープ内で定義されることになる。
# --------------------------------------------------------------------------------






# class C
# end

# module M
#   refine C do
#     def m1(value)
#       p "define m1 using Refinement"
#       super value - 100 # 300 - 100
#     end
#   end
# end

# class C
#   def m1(value)
#     p "define m1 in C"
#     value - 100 # 200 - 100
#   end
# end

# using M # ここからRefinementが有効になる

# class K < C
#   def m1(value)
#     p "define m1 in K"
#     super value - 100 # 400 - 100
#     # Refinementが有効なのでsuperはモジュールMにあるm1を参照する
#   end
# end

# p K.new.m1 400



class Human
    NAME = "Unknown"
    # 定数の探索順位はクラス内 -> スーパークラス -> クラス探索順に行われます。
    # よって、Human#nameのクラス内定数であるNAME = "Unknown"が返されます。

    def name
        NAME
    end
end

class Noguchi < Human
    NAME = "Hideyo"
end

# p Noguchi.new.name

