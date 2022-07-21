# 問題
# 次のプログラムは"Hello, world"と表示します。
# 同じ結果になる選択肢はどれですか（複数選択）

# module M
#   CONST = "Hello, world"

#   class C
#     def awesome_method
#       CONST
#     end
#   end
# end

# p M::C.new.awesome_method

# '****************************************************************************************************************'
# '****************************************************************************************************************'

# module M
#     CONST = "Hello, world"
# end

# class M::C #=> これはただのクラスC。M::がついているけど、このレキシカルスコープはクラスc。だからモジュールMに探索は行かない。
#     p Module.nesting #=> [M::C]
#     def awesome_method
#         CONST
#     end
# end

# module M
#     class C #=> このネスト記法なら、別に定義されたモジュールMの定数も同じレキシカルスコープとして扱う。
#         p Module.nesting #=> [M::C, M]
#         def awesome_method
#             CONST
#         end
#     end
# end

# p M::C.new.awesome_method
# 解説
# class,moduleを再オープンして定数とメソッドを定義しているスコープが別々に存在していても、探索の際には同じスコープとして扱うことになる。

# ネストの記述方法が違うと結果も変わる
    # class M::C; end => コンパクト記法
    # module M; class C; end end => ネスト記法
# 上記２つでは定数を定義する際に違いが生まれる。




# '****************************************************************************************************************'

# class C
#     CONST = "クラスC"
# end
# module M
#     CONST = "Hello, world"
# end

# module M
#   CONST = "Hello, world"

    # C.class_eval do
    #     p Module.nesting #=> [M]
    #     def awesome_method
    #         CONST
    #     end
    # end
    # C.class_eval(<<-TEXT)
    #     p Module.nesting #=> [C,M]つまり、やはりテキストを渡した場合はクラス内にネストするのか。。
    #     def awesome_method
    #         CONST
    #     end
    # TEXT
    # C.instance_eval(<<-TEXT)
    #     p Module.nesting #=> [#<Class:C>, M]
    #     def awesome_method
    #         CONST
    #     end
    # TEXT
    # C.instance_eval do
    #     p Module.nesting #=> [M]
    #     def awesome_method
    #         CONST
    #     end
    # end
# end
# p C.singleton_class.constants #=> 定数は特異クラスとは共有されない。
# p C.new.awesome_method #=> class_eval
# p C.awesome_method #=> instance_eval

# 解説
# 4パターンいずれも"Hello,world"が出力される。 
# それぞれのModule.nestingでネストの状態を見てみると理解しやすい。

    # class_eval ブロック
    # [M] => ブロックはコンテキストが外側に移るという使用のため、モジュールMにコンテキストが行く。

    # class_eval テキスト
    # [C,M] => テキストを渡したら、ネストがクラスの中に入ってクラス内がまずコンテキストになる。その後、モジュールMにコンテキストが移るっぽい。

    # instance_eval ブロック
    # [M] => class_evalと同様にブロックを渡した場合は、最初からコンテキストはモジュールMとなる。

    # instance_eval テキスト
    # [#<Class:C>, M] => instance_evalは特異クラスのオープン。クラスと特異クラスでは定数は共有されていないため、特異クラス内では見つからず、モジュールMにコンテキストが移る。

# class_evalはクラスをオープン
# instance_evalは特異クラスをオープン

# '****************************************************************************************************************'

# class C
#     CONST = "Hello, world"
# end

# module M
    # C.class_eval(<<-CODE)
    #     p Module.nesting #=> [C, M]
    #     def awesome_method
    #         CONST
    #     end
    # CODE
#     C.class_eval do
#         p Module.nesting #=> [M]
#         def awesome_method
#             CONST
#         end
#     end
# end

# p C.new.awesome_method

# 解説
# Hello,worldは出力される。
# evalを渡してクラスをオープンしている。Module.nestingの結果は[C,M]。
# 文字列を渡している場合、コンテキストはクラス内部に入る。

# ブロックを渡している場合は、コンテキストはCには行かないから、定数を定義していないMした探索を行わないためNameErrorとなる。

# '****************************************************************************************************************'

# class C
#     CONST = "Hello, world"
# end

# module M
    # C.instance_eval do
    #     p Module.nesting #=> [M]
    #     def awesome_method
    #         CONST
    #     end
    # end
#     C.instance_eval(<<-TEXT)
#         p Module.nesting #=> [#<Class:C>, M]
#         def awesome_method
#             CONST
#         end
#     TEXT
# end

# p C.awesome_method
# 解説
# **クラスと特異クラスでは定数は共有されていない**

# instace_eval ブロック
# ブロックを渡しているため、コンテキストはモジュールMとなる。Mにはレキシカルスコープに定数は定義されていないためNameErrorとなる。

# instance_eval テキスト
# テキストを渡しているからコンテキストは特異クラスとなり、モジュールMとネストの関係になる。でも、特異クラスにも定数は定義されていない。
# クラスと特異クラスは定数を共有していない。特異クラスを探索した後、モジュールを探索している。

# '****************************************************************************************************************'

# '****************************************************************************************************************'
