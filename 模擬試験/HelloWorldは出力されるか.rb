# 次のプログラムは"Hello, world"と表示します。
# 同じ結果になる選択肢はどれですか（複数選択）

# module M
#   CONST = "Hello, world"
#   def self.say
#     CONST
#   end
# end

# p M::say

# *************************************************************
# *************************************************************
# まず、この手の問題は定数を呼び出している部分にModule.nestingを実行して、ネストの関係をはっきりさせるとわかりやすい。
# Module.nestingの結果で出されるクラスとモジュールが定数の探索対象なのだから。
# *************************************************************

# module M
#     CONST = "Hello, world"
# end

# module M
#     def self.say
#         CONST
#     end
# end

# p M::say
# 解説
# 定数が定義されているスコープとメソッドが定義されているスコープがバラバラでも同じモジュールなら一つのレキシカルスコープとして探索されるようだ。

# *************************************************************

# module M
#     CONST = "Hello, world"
# end

# M.instance_eval(<<-CODE)
#     p Module.nesting #=> [#<Class:M>]
#     def say
#         CONST
#     end
# CODE

# p M::say
# 解説
# nestingの結果を見れば分かる通り、ネストはモジュールMの特異クラスのみ。
# さらに、クラスと特異クラスは定数を共有しないため、instance_evalで特異クラスをオープンしてそこで定数を呼び出しても、
# レキシカルスコープに定数は存在しない。

# *************************************************************

# module M
#     CONST = "Hello, world"
# end

# class << M
#     def say
#         CONST
#     end
# end

# M.instance_eval do
#     CONST = 'モジュールMの特異クラスに定数を定義'
# end

# p M::say
# p M.constants #=> [:CONST]
# p M.singleton_class.instance_methods #=> [:say.......

# 解説
# class << Mでは、モジュールMの特異クラスをオープンしているわけで、特異クラスには定数が定義されていなければ、
# 当然NameErrorになる。
# モジュールMで定義している定数はclass_evalとかでメソッドを定義して呼ぶ分には可能

# *************************************************************

module M
    CONST = "Hello, world"
end
CONST = "Objectの定数"
# M.module_eval(<<-CODE)
#     def self.say
#         CONST
#     end
# CODE
M.module_eval do
    p Module.nesting #=> [] これは、からだけど実際にはObjectにネストされているという状態。
    def self.say
        CONST
    end
end

p M::say
# 解説
# 当然Hello,worldは出力される。
# module_eval(class_eval)にテキストを渡すとモジュールMにコンテキストがいく。
# Mには定数が定義されているから、それが呼ばれるわけだ。

# evalにブロックを渡したら
# トップレベルでevalにブロックを渡してしまうとObjectにネストされることになる。
# モジュールMはねストの関係には入らないため、探索対象から外れてしまうのだ。
# 仮にトップレベルに定数が定義されているならそれが見つかってNameErrorにはならない。

# *************************************************************