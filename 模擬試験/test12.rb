
module E
    CONST = '010'
end

module M
    include E #=> インクルードすることでやっとモジュールは継承関係が生まれて、定数探索を行う。
    def refer_const
        CONST
    end
end

class D
    CONST = '001'
end

class C < D
    attr_reader :var
    @var = 'クラスCのクラスインスタンス変数です。'
    def self.var
        @var
    end
    # include E
    include M
    CONST = '100'
    def initialize
        @var = 'クラスCのインスタンス変数です。'
    end
end

c = C.new
# p c.refer_const
# p C.ancestors

p c.methods.include?(:var)
p C.methods.include?(:var)
p C.var



p '---------'
class Example
    def hoge
        self.piyo
    end
private #=> Ruby2.7からprivateメソッドもselfで呼び出せるようになった。でも、Ruby2.1ではエラーになるからGOLDの試験では注意が必要。
    def piyo
        p "piyo"
    end
end

Example.new.hoge


%r|(http://www(\.)(.*)/)| =~ "http://www.abc.com/"
p $1 #=> http://www.abc.com/
p $2 #=> .
p $3 #=> abc.com



p (2.0).class
p (1/2r).class
p (2.0 + 1/2r).class #=> floatとrationalの結果はfloat

p '============='

a = 1.0 + 1
p a.class #=> Float と Integerの結果はFloat
a = a + (1/2r)
p a.class #=> Float と Rationalの結果はFloat
a = a + (1 + 2i)
p a.class #=> Float と Complexの結果はComplex


p '-------------------'

begin
    "cat".narrow
rescue NameError => e
    p "#{e.class}" #=> NoMethodError => NameErrorのサブクラスだから、NoMethodErrorも拾われる。
end




class String 
    alias :hoge :reverse #=> alias式はメソッドやグローバル変数に別名を付けることができます。
    # alias hoge reverse
end
  
# p "12345".hoge

# aliasは,を使ってはいけない
# alias_methodは文字列とシンボルのどちらもオッケーだけど、カンマが必要

class String
    alias_method "hoge", "reverse"
end
  
p "12345".hoge

# alias => 文字列とシンボル、カンマ使えない
# alias_method => 文字列とシンボル、カンマ必要


class A
    @@x = 0
    class << self
        @@x = 1
        def x
            @@x
        end
    end

    def x
        @@x = 2
    end

end

class B < A
    @@x = 3 #=> 継承を利用している場合、クラス変数を普通に使うと親クラスやサブクラスに伝搬してしまう。
end


p A.x
# 一番最後のサブクラスがクラス変数の最終定義をしているって感じ。



