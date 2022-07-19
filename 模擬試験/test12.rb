
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