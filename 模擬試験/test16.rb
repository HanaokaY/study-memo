# module B
#     @@val = 30
# end
# class AAA
#     # @@val = 15
# end
# class C < AAA
#     include B
#     # @@val = 10
# end
# # Object.class_eval(<<-EVAL)
# #     @@val = 666
# # EVAL
# # @@val = 777
# class << C
#     # @@val = 10
#     def method_singleton_c
#         p @@val
#     end
#     @@val = 10
# end
# p "Cのクラス変数は#{C.class_variable_get(:@@val)}" 

# 解説
# クラス変数は特異クラスとクラスで共有されるし、
# どちらかで最後に更新した内容がそのクラス変数の最終決定となる。
# サブクラスまでも共有されるから、サブクラスでの最終決定のほうが優先される。


# =====================================

# class C
#     @@val = 10
#     def val
#         @@val
#     end
# end

# c1 = C.new
# c2 = C.new
# p c1.val
# p c2.val
# C.class_eval(<<-CODE)
#     @@val = 20
# CODE
# p c1.val
# p c2.val
# c1.instance_eval(<<-CODE)
#     @@val = 30
# CODE
# p c1.val
# p c2.val #=> クラス変数の最終決定は最後の更新
# # クラス変数は継承チェーン上にあるクラス間クラス変数は共有されるから、どこで更新しても全く同じクラス変数をいじっていることになる。

# module M
#     @@val = 30
# end

# C.singleton_class.class_eval(<<-CODE)
#     @@val = 40
# CODE

# module M
#     class << C
#         # p self
#         # p @@val
#     end

#     # C.singleton_class.class_eval do
#     #     p @@val
#     # end

#     # class C
#     #     p @@val
#     # end

#     # C.singleton_class.class_eval(<<-CODE)
#     # p Module.nesting
#     #     p constants
#     #     p @@val
#     # CODE
# end

# # この問題については、p @@valで参照するクラス変数はそのレキシカルスコープのクラス変数だということは暗記しているから答えられるが、
# # コレがもし、Cの特異クラスにクラス変数が定義されていた場合は結果は変わるのか？
# # 定義されているのに、モジュール側のクラス変数が参照されるなら、クラス変数の探索経路について深堀りしたほうがいい

# 結果
# 特異クラスに定義されているかどうかというよりは、最終決定はどこでされているのかっていう考え方が大事かも。
# pメソッドで参照するクラス変数はモジュールM内のクラス変数なわけだから、クラスCやその特異クラスにクラス変数が定義されているかどうかはどうでもいい。

# # =====================================

# class Object
#     CONST = "100"
# end

# class C
#     CONST = "010"
#     class << self
#         CONST = "001"
#     end
# end

# p C::CONST
# #   C::CONSTというのは絶対参照みたいなものだと思っている。
# # つまり、クラスCにCONSTがなければNameErrorとなる認識。たとえ親クラスに定義されていても継承チェーンをたどって探索はしない認識。
# # 確認が必要

# その認識で正しい 確認済み


# # =====================================

# class Company
#     attr_reader :id
#     attr_accessor :name
#     def initialize id, name
#         @id = id
#         @name = name
#     end
#     def to_s
#         "#{id}:#{name}"
#     end
#     def <=> other
#         self.id <=> other.id
#         # other.id <=> self.id
#     end
# end

# companies = []
# companies << Company.new(2, 'Liberyfish')
# companies << Company.new(3, 'Freefish')
# companies << Company.new(1, 'Freedomfish')

# companies.sort #=> sortかsort!で結果が変わる。破壊的かどうかが関係してるっぽい。
# companies.each do |e|
#     puts e
# end

# 解説
# この問題で最大の謎だった、出力結果の並び順
# other.id <=> self.idの時は、認識通りの並び順(idが大きい方から降順)だったが、self.id <=> other.idの時は、
# 何故か、sortされていない結果が出力されていた。
# その理由は、companies.sortだった。コレは破壊的メソッドではないため、companiesをeachしてるけど、sortしていない配列を
# 回してるから当然そのままの並び順が出力されていたわけだ。

# # =====================================

module E
    CONST = '010'
end

module M
    include E
    def refer_const
        CONST
    end
end


class D
    CONST = "001"
end

class C < D
    include E
    include M
    CONST = '100'
end

c = C.new
p c.refer_const

# クラスCにモジュールが２つincludeしている状況で、C.ancestorsをすると一見モジュールM内に定数が定義されていないと継承チェーン的には、
# モジュールEを探しに行くかと思ってしまう。
# M.ancestorsをすれば理解できるが、別にancestorsはメソッド探索ルートを出しているだけで、定数の探索ルートではないことがわかる。
# で、定数の探索は特殊で、methodの定義しているスコープをレキシカルスコープとして、そのスコープから継承チェーンを探索する。
# 今回はMに定義されていないからエラー


# # =====================================

# m = Module.new

# CONST = "Constant in Toplevel"

# _proc = Proc.new do
#   CONST = "Constant in Proc"
# end

# m.module_eval(<<-EOS)
#   CONST = "Constant in Module instance"

#   def const #=> クラスメソッドは定義していない
#     CONST
#   end
# EOS

# m.module_eval(&_proc)

# p m.const #=> そもそも、これエラーだった。。。

# # これってinstance_evalだったら、結果はConstant in Toplevel？
# # いや、定数は継承されるから、mとmの特異クラスは継承関係にあるから、m.constはmの特異クラスに探索がいくのかな？

# # 

# # =====================================

# class C
#     def self._singleton
#       class << C
#         val = self
#       end
#       val
#     end
#   end
  
#   p C._singleton

# #   これって、ローカル変数じゃなければ、特異クラスとれる？


# # =====================================

# class C
#     def m1
#       400
#     end
#   end

#   module M
#     refine C do
#       def m1
#         100
#       end
#     end
#   end
  
#   class C
#     using M
#   end

#   class C
#     # ここでm1を使うと結果は400のまま？
#   end


# # =====================================

# val = 100

# def method(val)
#   yield(15 + val)
# end

# _proc = Proc.new{|arg| val + arg }

# # p method(val, __(1)__)
# # &_proc
# # # &_proc.to_proc

# # =====================================

# # 間違った問題
# class Company
#     attr_reader :id
#     attr_accessor :name
#     def initialize id, name
#       @id = id
#       @name = name
#     end
#     def to_s
#       "#{id}:#{name}"
#     end
#     def <=> other
#       other.id <=> self.id
#     end
#   end
  
#   companies = []
#   companies << Company.new(2, 'Liberyfish')
#   companies << Company.new(3, 'Freefish')
#   companies << Company.new(1, 'Freedomfish')
  
#   companies.sort!
  
#   companies.each do |e|
#     puts e
#   end

# # =====================================

# mod = Module.new

# mod.module_eval do
#   EVAL_CONST = 100
# end

# puts "EVAL_CONST is defined? #{mod.const_defined?(:EVAL_CONST, false)}"
# puts "EVAL_CONST is defined? #{Object.const_defined?(:EVAL_CONST, false)}"


# # =====================================
