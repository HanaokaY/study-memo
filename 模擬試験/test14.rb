# module M
#     CONST = 'Hello,world'
# end

# module M
#     def self.say
#         CONST
#     end
# end

# p M::say

#===============================================================
#===============================================================

# module M
#     CONST = 'Hello,world'
# end
# module N
#     CONST = 'Hello,N'
#     M.instance_eval(<<-CODE)
#         def say
#             CONST
#         end
#     CODE
# end
# M.instance_eval(<<-CODE)
#     def say
#         CONST
#     end
# CODE

# p M::say #=> NameError
# p M.singleton_class.constants #=> []
# p M.constants #=> [:CONST]
# 解説
# 単純に特異クラスには定数が共有されないし、instance_evalは特異クラスのオープンで、トップレベルでオープンしてるから
# ネストの関係は[#<Class:M>]と特異クラスのMのみになる。だから#<Class:M>に定数がなければそこでNameErrorがでて探索が終わり。
# 仮に別の定数が定義しているモジュール内でオープンしていたら、そこに定義されている定数は見つけることが出来る。


#===============================================================
#===============================================================

# module M
#     CONST = 'Hello,world'
# end
# # module N
# #     CONST = 'Hello,N'
# #     M.instance_eval(<<-CODE)
# #         def say
# #             CONST
# #         end
# #     CODE
# # end

# class << M #=> これも特異クラスのオープンであるから、特異クラス内で探索する。
#     def say
#         p Module.nesting #=> [#<Class:M>]
#         CONST
#     end
# end

# p M::say #=> NameError


# class C
#     CONST = 'Hello,world'
# end

# c = C.new

# c.instance_eval(<<-CODE)
#     def self.say
#         p Module.nesting
#         p CONST
#     end
# CODE
# c.instance_eval do
#     def self.say
#         p Module.nesting
        # これだと外側にネストが行ってしまって、定数探索に影響が出る。
        # 理由
        # 定数探索はレキシカルから行われるが、nestingの結果が[]から配列の場合、それはトップベレルにしかネストされていないということ。
        # つまり、Objectクラスに定数が定義されていなければNameErrorとなってしまう。
        # instance_evalにテキストを渡して、インスタンス内部にネストさせてコンテキストを移せば、定数探索は、まずインスタンスの特異クラスを探して、
        # 見つからない場合は、特異クラスの親クラス、つまりインスタンスのクラスに継承チェーンがつながっているため、探索が移る。
        # ここでもやはり、最終的に定数が見つからない場合はObjectまで探索がいくが、最終的にはNameErrorとなってしまう。
#     end
# end

# c.say



#===============================================================
#===============================================================


module M
    CONST = 'Hello,world'
end

M.instance_eval(<<-CODE)
    def self.say
        CONST
    end
CODE

# p M::say #=> NameError
# 解説
# instance_evalにテキストを渡しているから、特異クラスの内部にネストする。
# でも、特異クラスには定数が定義されてもいないし、継承チェーンたどってもCONSTなんて定数は定義されていないから、
# NameErrorとなってしまう。