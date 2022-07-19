module M
    def foo
        self.class
    end
end
class P
    def self.foo
        self
    end
end
class C < P
    # include M
end
# p C.singleton_class.instance_methods.include?(:foo) #=> クラスメソッドは特異クラスのインスタンスメソッド
# p C.instance_methods.include?(:foo) #=> クラスメソッドは特異クラスに定義されるmethodのこと。特異methodという。だからクラスにはない。
# p C.methods.include?(:foo)  #=> methodsmethodは特異methodの一覧を返す。
# p C.foo #=> 何か勘違いをしていた。methodを呼び出したら、method探索をして定義から実行するから、そこでのselfは定義元のことかと勘違いしていた。

# Ruby では継承で既存のクラスを、mixin でモジュールをそれぞれクラスに取り込むことが出来る
# スーパークラスとモジュールのmethodも取り込んでいる。


class Object
    NAME = self
    @@name = self
    def method_missing(name)
        p 'ノーメソッドエラー'
        p "呼び出しているのは#{self}です"
        p "定数は#{NAME}"
        p "クラス変数は#{@@name}"
    end
end

class C
    # NAME = self
    @@name = self
end 
# 仮にCで定数を定義していた場合、method_missingの定数探索はここで止まる。。。。と、思いきや、
# 定数の探索に関しては、「methodの定義元」からレキシカルに探索して、その後継承チェーンをたどるから、ここの定数は関係がない。

C.dummy_method
# =>
# "ノーメソッドエラー"
# "呼び出しているのはCです"
# "定数はObject"
# "クラス変数はC"  ##=> この結果から、やはり継承でmethodをクラス内に取り込んでいる、つまりこのクラス内に「継承したmethod」が存在するということ。

# P.dummy_method
# =>
# "ノーメソッドエラー"
# "呼び出しているのはPです"

# これはつまり、methodが継承元のクラスからサブクラスのものとしてmethodを扱っている感じ。
# インタプリタはmethodを呼び出す際には定義元のクラスまでmethodを探索しているが、method内にselfがあっても、それは実行しているクラスになる。

p P.const_get(:NAME) #=> Object
# この場合も例外なくレキシカル(Pクラス内)を探索後、見つからない場合は軽症チェーンを上げて、Objectの定数に辿り着いたわけだ。
class P; NAME = self; end
p C.const_get(:NAME) #=> P
# Cの定数定義をコメントアウト下から、定数探索を開始して親クラスのPで発見ということだ。

