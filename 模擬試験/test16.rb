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

# module E
#     CONST = '010'
# end

# module M
#     include E
#     def refer_const
#         CONST
#     end
# end


# class D
#     CONST = "001"
# end

# class C < D
#     include E
#     include M
#     CONST = '100'
# end

# c = C.new
# p c.refer_const

# クラスCにモジュールが２つincludeしている状況で、C.ancestorsをすると一見モジュールM内に定数が定義されていないと継承チェーン的には、
# モジュールEを探しに行くかと思ってしまう。
# M.ancestorsをすれば理解できるが、別にancestorsはメソッド探索ルートを出しているだけで、定数の探索ルートではないことがわかる。
# で、定数の探索は特殊で、methodの定義しているスコープをレキシカルスコープとして、そのスコープから継承チェーンを探索する。
# 今回はMに定義されていないからエラー


# # =====================================

# m = Module.new
# # CONST = "Constant in Toplevel"

# _proc = Proc.new do
#     CONST = "Constant in Proc"
# end

# # m.module_eval(<<-EOS)
# #   CONST = "Constant in Module instance"

# #   def const #=> クラスメソッドは定義していない
# #     CONST
# #   end
# # EOS
# m.module_eval(&_proc) #=> ブロックを渡しているからトップレベルに定義していることになる。
# p Module.constants #=> [Module, Object, Kernel, BasicObject]

# m.instance_eval(<<-CODE)
#     # CONST = "Constant in Module instance"

#     def const #=> クラスメソッドは定義していない
#         CONST
#     end
# CODE


# p m.const


# # これってinstance_evalだったら、結果はConstant in Toplevel？
# Constant in Toplevelだった。やはり、特異メソッドが定義してあるのは、特異クラスだからだと思われる。

# 解説
# instance_evalにテキストを渡して、その特異クラスのスコープ内では定数を定義していない。外ではトップレベルに定数を定義している。
# そんな状況で、特異クラス内で定数を参照しようとすると、トップレベルつまりオブジェクトの定数が参照される。
# 理由は、mがModuleクラスのインスタンスであり、ModuleクラスはObjectクラスを継承していて、定数を継承しているから。

# [m>>#m>>#object>>#BasicObject>>Class>>Module>>Object]、少し複雑だけど、実際は左記のような継承チェーンとなっている。

# # =====================================

# class C
#     def self._singleton
#       class << C
#         $val = self
#       end
#       $val
#     end
#   end
  
#   p C._singleton #=> #<Class:C>

# #   これって、ローカル変数じゃなければ、特異クラスとれる？
# とれる。確認済み

# # =====================================

# class C
#     def m1
#         400
#     end
# end

# module M
#     refine C do
#         def m1
#             100
#         end
#     end
# end

# class C
#     using M
#     def call_refine_m1
#         p "usingを使ったスコープでm1実行 => #{m1}"
#     end
# end

# class C
# # ここでm1を使うと結果は400のまま？
#     def call_m1
#         p "call m1メソッド => #{m1}"
#     end
# end

# C.new.call_refine_m1 #=> "usingを使ったスコープでm1実行 => 100"
# C.new.call_m1 #=> "call m1メソッド => 400"

# 解説
# usingを記述しいるブロック内でしかメソッドの内容は変更されない。


# # =====================================

# val = 100

# def method(val)
#   yield(15 + val)
# end

# _proc = Proc.new{|arg| val + arg }

# p method(val, __(1)__)
# &_proc
# # &_proc.to_proc

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

#   sortメソッドに注目。
# <=>メソッドをどんなに昇順か降順に設定しても、sort!じゃないとcompanies自体が変更されないから出力結果が変わる。

# # =====================================


# mod.module_eval do
#   EVAL_CONST = 100
# end


# Module.module_eval(<<-CODE)
# EVAL_CONST = 200 #=> 定数はインスタンスには共有されない
# CODE
# mod = Module.new

# mod.module_eval(<<-CODE)
# EVAL_CONST = 200
# CODE

# p mod.constants

# puts "EVAL_CONST is defined? #{mod.const_defined?(:EVAL_CONST, false)}"
# puts "EVAL_CONST is defined? #{Object.const_defined?(:EVAL_CONST, false)}"


# # =====================================


# ===============================================第二回目の復習


# module M
#     CONST = "Hello, world"
#   end

#   M.instance_eval(<<-CODE)
#     CONST = 'singleton world'
#   CODE
  
#   M.module_eval(<<-CODE)
#     def self.say #=> このままだと、特異メソッドとはいえ参照しているのはMのまま
#         p Module.nesting #=> [M]
#         class << self #=> class << selfを追加することで特異クラスを参照するメソッドになる
#             p Module.nesting #=> [#<Class:M>, M]
#             p self
#             CONST
#         end
#     end
#   CODE
  
#   p M::say

#   これって、

# def self.say
#     CONST
#   end
#   の中でclass << selfがあれば特異クラスの定数を参照だけど、
# 今のままだと、selfはモジュールMのままだよね？ ==> 正解、確認した

# メソッド内でnestingしてみるとわかりやすいが、module_evalでオープンして、特異メソッドを定義して、その中で得意クラスの定数を参照してみて、。
# もし、特異クラスに定数が定義されていない場合、NameErrorかなと思ったが、nestingしてみたところ、[#<Class:M>, M]だから、
# 特異クラスの次にモジュールに探索が移るらしい。

# ====================================

# class C
#     @@val = 10
#   end
  
#   module B
#     @@val = 30
#   end
  
#   module M
#     include B
#     @@val = 20
#     @@val = 40
#     class << C
#         C.instance_eval(<<-CODE)
#             p @@val
#             def foo
#                 @@val
#             end
#         CODE
#     @@val = 60
#     #   p @@val #=> これも上の問題と同じで、この中にclass << selfがあると、参照するのは特異クラス？
#     end
#   end
#   p C.foo
#   解説
# クラス変数はレキシカルに決定される。
# つまり、モジュールMでCの特異クラスのクラス変数をいじろうとすると、そのレキシカルスコープ内のクラス変数の値はすべて一緒になる。

#  ==================================

# def bar(&block)
#     # yield
#     # block.yield
#     # block.call
#     block.[]
#     # この4種類の呼び出し方がある。

#   end
  
#   bar do
#     puts "hello, world"
#   end
#   blockってcallか[]だけかと思ってたけど、yieldでも呼べるのか


# ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

# class Foo
#     def initialize(num)
#       @hoge = num
#     end
#   end
  
#   num = (1..99).to_a.shuffle.first
#   foo = Foo.new(num)
  
#   p foo
# puts foo.inspect
# この２つでhogeに入っている値が確認できるらしい
# あと、inspectとto_sの関係も再確認

# ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

# class C
#     CONST = "Hello, world"
#   end
  
#   $c = C.new
  
#   class D
#     class << $c
#         p self.superclass #=> インスタンスの特異クラスの親は、インスタンスのクラスである。
#       def say
#         CONST
#       end
#     end
#   end

#   p $c.say
  
# インスタンスの特異クラスのクラスは、インスタンスのクラス。

# =======================================

# module P
#   CONST = "Good, night"
# end
# class A
#    prepend P 
# end

# class Base < A
#     # CONST = "Hello, world"
# end

#   class C < Base
#   end
  
  
  
#   module M
#     class C
#       CONST = "Good, evening"
#     end
#   end
  
#   module M
#     class ::C
#       def greet
#         CONST
#       end

#     end
#   end
  
#   p C.new.greet

# 検証してみて
# 今回悩んでいる部分は、::Cのメソッドから定数を参照すると、Cには定義されていないから、Baseに探索が移るまでは理解できる。
# しかし、prepend PによりBaseで定義されている定数よりも、Pの定数のほうが先に探索で発見されるかと思っていた。
# 実際は下記のような流れで探索が行われているようだ。

# 探索 >> C >> Cで取り込んでいるモジュール >> Base >> Baseで取り込んでいるモジュール >> ....... >> トップレベル



# require 'socket'
# p TCPSocket.ancestors.member?(IO)
# 解説
# TCPSocketはIOクラスを継承しており、Fileクラスなどと同様な操作でソケットを扱うことができます。