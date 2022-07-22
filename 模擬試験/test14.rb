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
M.singleton_class.class_eval(<<-CODE)
    CONST = 'Good,night'
CODE

# M.instance_eval(<<-CODE) #=> instance_evalは特異クラスのオープン。
#     def self.say
#         CONST
#     end
# CODE

# p M::say #=> NameError
# 解説
# instance_evalにテキストを渡しているから、特異クラスの内部にネストする。
# でも、特異クラスには定数が定義されてもいないし、継承チェーンたどってもCONSTなんて定数は定義されていないから、
# NameErrorとなってしまう。

# module M::MM
#     class C
#         def serch
#             p Module.nesting 
#             #=> [M::MM::C, M::MM] 定数探索はnesting基準で考えるべき。つまり、レキシカルで探索するルートは<M::MM::C>と<M::MM>だけ
#             # つまり、一番外側のMには定数が定義されているから探索で見つかると思いきや、Mは探索の対象になっていない。

#             CONST
#         end
#     end
# end

# p M::MM::C.new.serch

# module M
#     module MM
#         class C
#             def serch
#                 p Module.nesting 
#                 #=> [M::MM::C, M::MM, M]
#                 # このネスト記法の場合なら、Mも探索対象になる。
                
#                 CONST
#             end
#         end
#     end
# end
# p M::MM::C.new.serch


# p M.singleton_class.constants #=> [:CONST]

module M
    module MM
        class C
            def serch
                # p Module.nesting 
                #=> [M::MM::C, M::MM, M]
                # このネスト記法の場合なら、Mも探索対象になる。
                
                CONST
            end
            class << self
                def singleton_serch
                    # p Module.nesting 
                    #=> [#<Class:M::MM::C>, M::MM::C, M::MM, M]
                    CONST
                end
            end
        end
    end
end
# p M::MM::C.new.serch
M::MM::C.instance_eval(<<-CODE)
    CONST = 'Good,evening'
CODE


p M::MM::C.singleton_serch





# Rubyオプション

# -ll
# ファイルをロードするパスを指定するオプション
# 指定したディレクトリは$LOAD_PATH変数($:)に格納される。
# 環境変数RUBYLIBも関係ある。

# -l
# ファイルをロードするパスを指定するオプション
# 指定したディレクトリは$LOAD_PATH変数($:)に格納される。
# 環境変数RUBYLIBは関係ない。 この点が-llと違うポイント

# -r
# 引数で指定したフィアルを読み込むオプション


# def tag(name)
#     p "<#{name}>#{yield}<#{name}>"
# end

# def tag(name)
#     p "<#{name}>#{yield.call}<#{name}>" #=> yieldにcallはつかわない
# end

# def tag(name,&block)
#     p "<#{name}>#{block}<#{name}>" #=> blockだけだと出力結果がなんか違う
# end

# def tag(name,&block)
#     p "<#{name}>#{block.call}<#{name}>"
# end

# def tag(name, &block)
#     p "<#{name}>#{yield}<#{name}>" #=> 引数で渡しいてもyieldだけで実行できる。
# end

def tag(name,&block)
    p "<#{name}>#{block[]}<#{name}>"
end

tag(:p){"hello,world."}
# 解説
# ブロックを実行するには、
    # yieldを使う
    # ブロック引数を渡して、Proc#callを使う。
    # []でもblockは実行できる。






