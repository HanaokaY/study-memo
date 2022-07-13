# module Parent
#     def method_1
#         __method__
#     end
# end

# module Child
#     include Parent
#     extend self
# end

# p Child::method_1
# extend selfすることによって、その時点でのモジュールを特異メソッドにするって感じ。
# だからインクルードした他モジュールのメソッドも特異メソッドの呼び出し方で実行できる。


# require 'yaml'

# yaml = <<YAML
#   sum: 510,
#   orders:
#     - 260
#     - 250
# YAML

# object = YAML.load yaml

# p object


# class Object
#     CONST = "1"
#     def const_succ
#         CONST.succ!
#     end
# end

# class Child1
#     const_succ
#     class << self
#         const_succ
#         p Object::CONST #=> 特異クラスも最初の読み込み時に実行される
#     end
# end

# class Child2
#     const_succ
#     def initialize
#         const_succ
#     end
# end

# Child1.new
# Child2.new
# p Object::CONST


class Array
    def succ_each(step = 1)
        p block_given?
        return enum_for(__method__, step) unless block_given?
       p block_given? #=> 一度目にブロック無しで呼ばれたら、次はブロックある状態で実行されている事がわかる。
        each do |int| #=> ここのeachはselfの配列を省略して記述してるっぽい
            yield int + step
        end

    end
end

[97, 98, 99].succ_each.map {|int|
    p int.chr
}

# Enumeratorオブジェクトを作成するためには、
# to_enumまたは、enum_forを呼びます。
# これらの引数にメソッド名をシンボルで指定することでチェーンした先で
# ブロックを渡されたときにどのメソッドを評価すればよいかが分かります。

# メソッド名をシンボルで指定する必要があるから、
# __method__で指定してもエラーにならない


array = ["a", "b", "c"].freeze

array.each do |chr|
  chr.upcase! #=> upcase!は破壊的メソッドではないためフリーズしててもエラーにならない。
end

# p array

# inspectメソッドについて
# pメソッドにはinspectメソッドが用いられているため選択肢puts foo.inspectと同じ出力になります。

def m1(*)
    str = yield if block_given?
    p "m1 #{str}"
end

def m2(*)
    str = yield if block_given?
    p "m2 #{str}"
end

# do end
# m1 m2 do #=> m2はm1の引数となってしまうため、m2にはブロックが引数としては渡らない。
#     "hello"
# end
# {}
m1 m2 { #=> {}を使った場合はdoendと違って、ブロックはm2の引数ということになる。
    "hello"
}
# { }はdo endよりも結合度が高い為、実行結果に差が出ます。



# 正規表現
# 正規表現/[a-z][A-Z].*/を分解すると以下の意味になります。
# [a-z] : 1文字目が小文字英字
# [A-Z] : 2文字目が大文字英字
# .* : 任意の1文字が0回以上繰り返す
p "Matz is my tEacher"[/[a-z][A-Z].*/]
#=> tEacher


# module K
#     CONST = "Good, night"
#     class P
#     end
# end

# module K::P::M
#     class C
#         CONST = "Good, evening"
#     end
# end

# module M #=> K::P::M::Cとは別のモジュールのネスト
#     class C
#         CONST = "Hello, world"
#     end
# end

# class K::P #=> classは最後尾の定数の定義のためもの。別にKがmoduleだとしても問題ない。あくまでPをクラスとするという意味。
#     class M::C
#         # p CONST
#     end
# end



# class C; end

# module M
#   refine C do
#     def m1
#       100
#     end
#   end
# end

# class C
#   def m1
#     400
#   end

#   def self.using_m
#     using M #=> usingはメソッドの中で呼び出すことは出来ません。呼び出した場合はRuntimeErrorが発生します。
#   end
# end

# C.using_m

# puts C.new.m1

# f = Fiber.new do |name|
#     Fiber.yield "Hi, #{name}"
# end

# p f.resume('Matz') # 'Hi, Matz'と表示されます。
# p f.resume('Akira') # 'Akira'と表示されます。
# p f.resume('Steve') # FiberErrorが発生します。

# f = Fiber.new do
#     Fiber.yield 15
#     5
#   end
#   p f.resume
# p f.resume

fiber = Fiber.new do
    p 'Hello' 
    Fiber.yield #-> 処理を停止し親ファイバーに戻る。
    p 'Hello2'
  end
  
  fiber.resume #-> 'Hello' #ファイバーの持つブロックの実行
  fiber.resume

#   ファイバはブロック内にある処理を全部やるまでresumeで実行できる。引数がある場合は最後にプラス一回、引数の出力で多いのかも。