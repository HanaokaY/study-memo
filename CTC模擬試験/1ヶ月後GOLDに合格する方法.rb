# Rubyの主なコマンドラインプション
# h,v,c,e,w系,I,r,d

# 環境変数ENV
# ENV[:PATH] = "user/..." # => キーがシンボルなので指定不可
# ENV['PATH'] = 1234 # => 代入する値が文字列ではないので指定不可
ENV['PATH'] = 'user/local...' # => どちらも文字列なので指定可
ENV['NAME'] = 'RUBY GOLD'
# p ENV


# NULLはObjectに標準で定義されていない


# 特殊変数 正規表現

# 以下のコードについて正しいものを選択しなさい(２つ選択)
# /(https://www(\.)(.*)/)/ =~ "https://www.qiita.com/"

# 1. $0の値は、ruby.rbである
# 2. $1の値は、https://www.qiita.com/である
# 3. $2の値は、.qiitaである
# 4. $3の値は、https://www.qiitaである

# 答え1, 2


# Rdoc マークダウン

# 見出し   = <h1>
        # == <h2>
        # === <h3>
        # ==== <h4>
        # ===== <h5>
        # ====== <h6>
# ボールド体(太字)	*text*
# イタリック体(斜体) _text_
# タイプライター体(均等) +text+
# リスト	*または-
# 番号付きリスト	数字.(ドット)
# ラベル付きリスト	[]で囲む または :で区切る


# 各変数を初期化していないときに参照した場合
# ローカル変数 => 例外発生(参照より前に代入文がある場合はnil)
# グローバル変数 => nil
# クラス変数 => 例外発生
# インスタンス変数 => nil
# 定数 = 例外発生


# 定数

CONST = "Top"

module Mod
  puts CONST # => Top
  puts ::CONST # => Top
  # モジュール内定数定義
  CONST = "Mod"
  puts CONST # => Mod まず自クラスから探索
  puts ::CONST # => Top
end

class Cls1
  puts CONST # => Top

  # クラス内定数
  CONST = "Cls1"
  puts CONST # => Cls1

  def func
    puts CONST
    puts ::CONST
    puts Mod::CONST
    #メソッド内で定数初期化
    # CONST = "func" # => dynamic constant assignment メソッド内で定数定義できない
  end

  include Mod
  puts CONST # => Cls1
  puts Mod::CONST # => Mod
end

# メソッドから参照
Cls1.new.func
# => Cls1
# => Top
# => Mod

class Cls2 < Cls1
  puts CONST # => Cls1

  CONST = "Cls2"
  puts CONST # => Cls2
  puts Cls1::CONST # => Cls1
  puts Mod::CONST # => Mod
end

p Cls1.ancestors # => [Cls1, Mod, Object, Kernel, BasicObject]
p Cls2.ancestors # => [Cls2, Cls1, Mod, Object, Kernel, BasicObject]

# 自クラスから探索開始。範囲演算子「::」を使用し探索開始経路を変更できる

::CONST # => トップレベルのCONSTを探す
Cls1::CONST # => Cls1クラス内のCONSTを探す
Mod::CONST # => Modモジュール内のCONSTを探す




# 定数の初期化

# CONST = "a"
# def foo1; p CONST; end
# def foo2; p CONST = "b"; end # => dynamic constant assignment
# def foo3; p CONST += "c"; end # => dynamic constant assignment
# def foo4; p CONST << "d"; end #=> コレに関しては、破壊的メソッドではないため可能らしい。


# <=>演算子(メソッド)
# 自作したクラスのインスタンスにはsortメソッドなどがデフォルトでは使用できない。
# 自作クラス内で<=>メソッドを定義することでsortすることが可能になる。
def <=>(other)
    # self.id <=> other.id
end


# 制御構文とメソッドのスコープ
for var in [0, 1, 2] do
    num = var
end

# 参照できる
p num # => 2

[1, 2, 3].each do |n|
    num = n
end

# 参照できない
p num # => undefined local variable or method `num'


# スコープを作る(メソッド)
# loop
# upto
# downto
# times
# each
# each_with_index

# スコープを作らない(メソッドではない。文法)
# if
# unless
# for
# while
# case

# スコープを作るかどうかの違いは、mapなどのメソッドのブロックはスコープを作ってしまう。


# Proc
p '----------------------------Proc'
block = Proc.new{|x, y| p x + y }

# block.call(1, 2) # => 3
block[1,2] # => 3
# Procオブジェクトはcallか[]メソッドで実行することが出来る


# yield

# def method(arg)
#     yield
#     p block_given?
# end

# method(1) { p "Hello" }

# &block
p '---------------------------------------&block'
def method(arg,&block)
    block[]
    p block_given?
end

method(1) { p "Hello" }

p '--------------------------------lambda'
class Cls1;end
def method_a(obj,&block)
    block.call(obj)    
end
lam = ->(obj){p obj.class}
method_a(Cls1.new,&lam)



# 例外処理

# ensure節がある時の評価値(戻り値的な)
def method
  begin
    "a"
  rescue
    "b"
  else
    "c"
  ensure
    "d"
  end
end

p method # => "c"  -> dじゃない理由↓
# 最後に評価されたrescure節、else節の値がそのbegin式の評価値になるらしい。
# ensure節は必ず通るから、評価値は"d"と思いきや、ensure節は実行はされるけど、評価値としては無視される。



# 大域脱出

# catch/throw
# throwからcatchまでジャンプする。ということだけ覚えておけばいい。

a, b = catch :exit do #=> ここに飛んでくる。その際にthrowの引数をcathchの戻り地とすることが出来る。
    for x in 1..10
        for y in 1..10
            throw :exit, [x, y] if x + y == 10 #=> ここから↑
        end
    end
end
puts a, b

  # => 1
  # => 9


# 実際に出題された脱出
# 下記、すべて動作する。

# c, d = catch :exit do
#     for x in 1..10
#         for y in 1..10
#             break [x, y] if x + y == 10
#         end
#     end
# end
# p c,d
# p '================break'
# e, f = catch :exit do
#     for x in 1..10
#         for y in 1..10
#             next [x, y] if x + y == 10
#         end
#     end
# end
# p e,f
# p '================next'
# g, h = catch :exit do
#     for x in 1..10
#         for y in 1..10
#             throw :exit, [x, y] if x + y == 10
#         end
#     end
# end
# p g,h
# p '================catch/throw'
# a, b = catch :exit do
#     for x in 1..10
#         for y in 1..10
#             return [x, y] if x + y == 10
#         end
#     end
# end
# p a,b
# p '================return'

# throw含め「このうち正常に動作するコードを選択しなさい(複数)」という形で出題されるらしい

# return	メソッドから抜ける
# break	ループから抜ける
# next	処理を中断し次の処理を実行する


def methodb
    p 'メソッドスタート'
    return
    p 'メソッドエンド'
end

# methodb

def methodd
    lam = ->(x){p x == 2 ? next : x} 
    p 'メソッドスタート'
    [1,2,3].each(&lam)
    p 'メソッドエンド'
end
methodd
# ちょっとひらめいたLambdaの使い時
# 必要なブロックオブジェクトだけ生成しておいて、必要なときに動的にeachなどに渡すブロックを変更することが出来るれば、
# 例えばeachで二種類の処理を実装しないといけな場合に、eachを重複して書く必要がなくなる。渡すブロックを条件によって変更すればいいだけだから。

# 例えばこんな感じ

class SampleLambda
    attr_accessor :print_block, :add_print_block
    def initialize
        @print_block = lambda{|x|p x}
        @add_print_block = lambda{|x| p x + 1}
    end

    def go_lambda(arg,&block)
        arg.each(&block)
    end
end
lam1 = lambda{|x|p x}
lam2 = lambda{|x| p x + 1}
lam = SampleLambda.new
ary = [1,2,3,4,5]
if ary.size > 5
    block = lam1
else
    block = lam2
end    
lam.go_lambda(ary,&block)




# Proc.newとlambdaの違い
# Proc.newは引数が一致しなくてもnilを代入してくれて、returnの動作は生成元のスコープ(メソッド)を脱出する
# lambdaは引数が一致しないとArgumentErrorとなる。returnは呼び出し元に復帰する。

# Procの場合
def proc_test
    proc = Proc.new{return "生成元のスコープ(メソッド)から脱出"}
    proc.call
    2 # ここは実行されない
end

# p proc_test # => "生成元のスコープ(メソッド)から脱出"


# lambdaの場合
def lambda_test
    lambda = -> {return "呼び出し元へ復帰"}
    lambda.call
    2 # ここは実行される
end

# p lambda_test # => 2

# lambda記法
# lambda{ |a| p a }
# ->(x){p x}
# どちらもcallメソッドで呼ぶことが出来る。Procのインスタンスを生成する。




BasicObject.class_eval do
    def method_missing(name)
        "#{name}なんてメソッドはありません。"
    end
end

# no_method


class ClassName2;end
cls2 = ClassName2.new
cls2.instance_eval do
    def method_missing(name)
        p "親のmethod_missing呼んでます -> #{super}"
    end
end
# cls2.dummy_method




# freeze

# 凍結されたオブジェクトの変更はVer2.1.0ではRumtimeErrorが発生
# Ver2.6.0ではFrozenErrorが発生

# 凍結されるのはオブジェクトであり、変数ではない
    # ★代入などで変数の指すオブジェクトが変化するのはfreezeメソッドでは防げない 
    # freezeメソッドが防ぐのは破壊的な操作のみ。例えばreplaceメソッドやgsubメソッドで変数の中身を変更しようとした場合

var1 = "".freeze
var1 = "foo" # 代入は防げない
p var1 #=> "foo"

var1.replace("bar") # 凍結後、再代入すると破壊的メソッドで変更可能でした
p var1 # => "bar"

var1.freeze # 再度凍結
# var1.replace("bar")# can't modify frozen string (RuntimeError)



# dupとclone

# dup
# ・ 特異メソッド、凍結状態はコピーしない

# clone
# ・ 特異メソッド、凍結状態もコピーする



# Rubyではdeep copyの標準機能は用意されていない


# マーシャリングとは
# 異なる２つのシステム間で、データを交換できるようにデータを操作する処理。
# 例えば、JavaとC言語のデータ型の違いを吸収するために、データの型を変換するなどの処理のこと

# マーシャリングできないもの

    # 無名クラス/モジュール ArgumentErrorが発生
    # システムがオブジェクトの状態を持つもの -> Dir, File, IO, Socket等
    # 特異メソッドを定義したオブジェクト

# マーシャリングできるもの

    # ユーザーが作成したオブジェクトなど。
    # マーシャリングできないものとして定義しているもの以外のもの
    # たぶん「マーシャリングできるのはユーザーが作成したオブジェクトなど」ということだけ覚えていれば1問解ける。


p '======================refine'
class Class3;end
class Class3
    def foo
        p 'hello'
    end
end
module Module3
    refine Class3 do
        def foo
            p 'refined'
        end
    end
end
class Class3
    using Module3
end

# using Module3
class Class4
    using Module3
    Class3.new.foo
end
Class3.new.foo


p '==============================================フックメソッド'
# ★★★フックメソッド
# append_features 実際に出た問題らしい

# 特定のイベントをキャッチしてその時の動作を実行するメソッド。
# append_features(include)やinherited(継承)がそうらしい

# サンプル
class Parent
    class << self
        def inherited(subclass)
            p "#{subclass}は#{self}を遺伝しました。"
        end
    end
end
class Child < Parent;end #=> ここが読み込まれると、親のinheritedメソッドが実行される


module M
    def self.append_features(klass)
        p klass.ancestors
        p "#{self}は#{klass}に取り込まれました。"
        super
    end
end

class C
    include M #=> [C, M, Object, Kernel, BasicObject]
    # prepend M #=> なにも出力されない
end
# 解説
# append_featuresはModule#includeの実態
# つまり、includeのときにしかappend_featuresは呼ばれないという認識
# 
# appned_featuresを上書くことで、
# includeされる際の挙動に影響が出ることになります。

# append_featuresにおいて重要なことは、super
# superがあれば、既存のappend_featuresが継承され、
# モジュールがincludeされますが、
# ない場合は、includeされません。





# exit,exit!

# def proc_exit!
#     begin
#         exit! #=> exit!だとrescueもensureも無視される。というか、ここでRubyの処理自体が終わる。
#     rescue SystemExit
#         puts "processing_exit"
#     ensure
#         puts "確保する"
#     end
# end

# proc_exit! # =>処理を強制終了し、rescue節、ensure節の処理は通らない


# Enumerableクラス
# map
p [1,2,3,3].map{|i| i % 2 == 0} #=> 結果を返す
# reject
p [1,2,3,3].reject{|i| i % 2 == 0} #=> rejectはfalseの要素を集める
# select
p [1,2,3,3].select{|i| i % 2 == 0} #=> 2


# lazyは、それ自体がmapのように結果を出すわけではなくて、Enumeratorを返す。そして、それをmap等の遅延評価メソッドに提供する事ができる。
p ([1, 2, 3, 4, 5].lazy.select { |e| e % 2 == 0 }).map{|e| e * 2}.take(3).inject(0,&:+)




# RationalとComplexの演算

a = 1 + "(1/2r)".to_r
p a.class # => Rational

a = a + 1.0
p a.class # => Float

a = a + "(1/2r)".to_r
p a.class # => Float

a = a + "(1 + 2i)".to_c
p a.class # => Complex



# 正規表現

# 正規表現オブジェクト
/Ruby Gold/             # => /Ruby Gold/
%r|Ruby Gold|           # => /Ruby Gold/
Regexp.new("Ruby Gold") # => /Ruby Gold/

# 実際に出題された!!!!
# ()内にマッチした部分がグローバル変数に代入されるらしいです。って教本に書いているけどこれ覚えてたら点取れます。
# $0はファイル名
# $1〜nはn番目の()にマッチする文字列

# %r|(https://www(\.)(.*)/)| =~ "https://www.qiita.com/"
%r|(https://www(.*)/)| =~ "https://www.qiita.com/"

p $1 # => "https://www.qiita.com/"
p $2 #=> ".qiita.com"

# 後方参照
# 「マッチした文字列の前後」と「マッチした文字」を参照する、正規表現の後方参照と呼ぶものらしいです。


%r|Ruby| =~ "u"

p $` # => "R"
p $& # => "u"
p $' # => "b"

# 正規表現記号

# .	改行以外の文字。mオプション指定の場合は改行にもマッチする
# \d	数字
# \D	数字以外
# \w	英数字とアンダースコア
# \W	英数字とアンダースコア以外
# \s	空白文字(\t, \n, \r, \f)
# \S	空白以外
# \A	先頭の文字(改行無視)
# \z	末尾の文字(改行無視)
# \Z	末尾の文字(改行にもマッチ)
# *	直前の文字の0回以上の繰り返し
# +	直前の文字の1回以上の繰り返し
# {m}	直前の文字のm回の繰り返し
# {m,}	直前の文字の最低m回の繰り返し
# {m, n}	直前の文字の最低m回、最高n回の繰り返し

%r|(\d+\w{3})| =~ "ifehifhe122_ie_fie"
p $1 #=> "122_ie"




# JSON
# 読み込み => load,parse
# 書き込み => dump

# YAML
# 読み込み => load
# 書き込み => dump




# Socket

# 教本とCTCの問題を解いていれば、とりあえず良いらしい
# 以下、体験談
# クラス名にserverと付くものは「TCPS」「UNIX」ということを覚えておくだけで点が取れました。

