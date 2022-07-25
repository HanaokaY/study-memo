# MyConst = 'TOPLEVEL'

# class GrandParent
#   # 定義しない
# end

# class Parent < GrandParent
#   MyConst = 'Parent'
# end

# module NameSpace
#   MyConst = 'NameSpace'
# end

# module MonkeyPatch
#   MyConst = 'MonkeyPatch'
# end

# module NameSpace
#     class Child < Parent
#         prepend MonkeyPatch

#         def put_myconst_at_base
#             puts ::MyConst
#         end

#         def put_myconst
#             puts MyConst
#         end

#         def put_myconst_with_child
#             puts ::NameSpace::Child::MyConst
#         end

#         def put_anything(arg)
#             puts arg
#         end

#         def put_const_with_grandparent
#             puts GrandParent::MyConst
#         end
#     end
# end

# module NameSpace
#     class LittleBrother < Parent
#         prepend MonkeyPatch
#         # p MyConst
#         def look
#             MyConst
#         end
#     end

#   end
  
# #   下記２つで定数の探索の仕方が違う。
# #   puts ::NameSpace::LittleBrother.new.look
#   puts ::NameSpace::LittleBrother::MyConst

# # 定数を参照しようとしているのが、クラスまたはモジュールの内側の場合
# # レキシカル>>includeまたはprependしているモジュール>>継承チェーン(Objectまで)
# # クラスやモジュールの外側から、定数を呼び出している場合。
# # 絶対参照の形で呼び出している場合、そのクラス内のレキシカル>>取り込んだモジュール>>継承チェーン

# # どちらもレキシカル >> 取り込んだモジュール >> 継承チェーンの流れで探索していることは同じ。





# # 問題1
# # NameSpace::Child.new.put_myconst_at_base
# #=> TOPLEVEL

# # 問題2
# # NameSpace::Child.new.put_myconst
# #=> NameSpace

# # 問題3
# # NameSpace::Child.new.put_myconst_with_child
# #=> Parent ✗
# #=> 正解はMonkeyPatch #includeかprependされれば定数はメソッド探索経路と関係なしに取り込まれるようだ。

# # # 問題4
# # NameSpace::Child.new.put_anything(MyConst)
# #=> TOPLEVEL

# # # 問題5
# # NameSpace::Child.class_eval { puts MyConst }
# #=> NameSpace ✗
# #=> 正解はTOPLEVEL

# # 問題6
# # NameSpace::Child.new.put_const_with_grandparent
# #=> TOPLEVEL (注意)これはRubyGOLDでは正解だけど、Ruby2.5以降ではNameErrorとなる。


# p '---------------------'

# class M
    
# end
# class A
#     CONST = "Hello, world"
# end

# module D
#     CONST = "D hello"
# end

# M.instance_eval(<<-CODE)
#     CONST = 'singleton world'
# CODE

# # module NameSpace; CONST = 'NameSpace'; end

# module NameSpace
#     class M < A
#         # include D

#         def self.say #=> これだけでは特異クラスをオープンしたことにはならない。

#             # class << self #=> メソッド内で特異クラスをオープンすることでレキシカルが特異クラスになる
#             #     self
#             #     CONST
#             # end

#             # M.instance_eval(<<-CODE) #=> これもclass << selfと同義
#             #     self
#             #     CONST
#             # CODE

#             M.instance_eval do #=> これはブロックだから、特異クラスにはネストしてない
#                 CONST
#             end

#         end
#     end
# end

# p NameSpace::M.say # "Helo,world"

# # レキシカル>>取込モジュール>>継承チェーン



MyConst = 'TOPLEVEL'

class GrandParent
  # 定義しない
end

class Parent < GrandParent
  MyConst = 'Parent'
end

module NameSpace
  MyConst = 'NameSpace'
end

module MonkeyPatch
  MyConst = 'MonkeyPatch'
end

module NameSpace
    class Child < Parent
        prepend MonkeyPatch

        def put_myconst_at_base
             ::MyConst
        end

        def put_myconst
             MyConst
        end

        def put_myconst_with_child
             ::NameSpace::Child::MyConst
        end

        def put_anything(arg)
             arg
        end

        def put_const_with_grandparent
             GrandParent::MyConst
        end
    end
end

# 問題1
p "問題1の答えは#{NameSpace::Child.new.put_myconst_at_base}"
#=> TOPLEVEL

# 問題2
p "問題2の答えは#{NameSpace::Child.new.put_myconst}" #=> NameSpaceではなくChild２定数が定義されていたらどちらが先に探索される？
#=> NameSpace

# 問題3
p "問題3の答えは#{NameSpace::Child.new.put_myconst_with_child}"
#=> MonkeyPatch

# # 問題4
p "問題4の答えは#{NameSpace::Child.new.put_anything(MyConst)}" 
# 引数に渡している定数が単純にトップレベルの定数だから、
# "TOPLEVEL"が渡される
#=> TOPLEVEL

# # 問題5
p "問題5の答えは#{NameSpace::Child.class_eval { MyConst }}"
# ちょっとわかりにくいけど、
# evalにブロックを渡しているわけだから、ネストはObjectとなって、トップレベルの定数が参照される。
#=> TOPLEVEL

# 問題5の補足だが、下の問題6はテキストを渡したパターン
# これは普通に、Childクラスをオープンしたような振る舞いをするから理解しやすい。
p "問題6の答えは#{
    NameSpace::Child.class_eval(<<-CODE)
        MyConst
    CODE
}"


# 問題6
# p "問題6の答えは#{NameSpace::Child.new.put_const_with_grandparent}"
#=> TOPLEVEL (注意)この問題はTOPLEVELで正解。Ruby2.⑤以降はNameErrorとなるが、試験のバージョンではこれで正解。

