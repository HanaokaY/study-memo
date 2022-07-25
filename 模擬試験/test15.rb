module M
    def foo
        self.class #=> メソッド内のselfはレシーバーとなる
    end
end
class C
    # include M
    extend M
end
# p C.new.foo
p C.foo
# 解説
# 定数探索を学習した後にメソッド探索を考えると混同してしまうが、
# 単純にメソッド探索は定数探索みたいなことはしない。
# メソッドは常にselfで実行されていると考えればいい。レキシカルとかそんなものは考えない。

# ただ、メソッド内で定数を呼び出している場合は、定数探索がレキシカルスコープから順に行われる。


class Cls2

    def call_foo
        self.foo
    end

    protected #=> protectedならself付きで同じメソッド内で実行することが出来る。
    # private #=> Ruby2.1ではselfレシーバー指定で実行することが不可だった。今はできるから注意が必要。
    def foo
        p 'プロテクトされてます'
    end
end

Cls2.new.call_foo


p [1,2,3].inject([]){|x,y| x << y ** 2}



