# オブジェクト指向

class Foo
    def initialize(a)
        @a = a
    end
end

class Foo2 < Foo
    def initialize(a,b)
        super a
        @b = b    
    end
    def foov
        puts @a
        puts @b
    end
end

# foo2 = Foo2.new(1,2)
# p Foo2.ancestors

# method_missing

class Hoge
    def huga1; end
    def huga2; end
    alias :huga3 :huga1
    undef :huga2
end

# この場合、Hoge.new.huga2を実行してもNoMethodErrorとなる。
# 厳密にはBasicObjectクラスのmethod_missingが呼ばれている。
# 理由は、実行しようとしているメソッドがクラスに存在しない場合は、
# 継承元のクラスに該当メソッドがあるか探しに行く。
# 最後まで存在しない場合はBasicObjectまで行って、method_missingの
# 引数として指定される。


# オープンクラス
# ひとつ上で定義済みのクラスでも、再定義することができる
# 此のようなクラスをオープンクラスという

class Hoge
    alias :hugahuga :huga3
end

# Stringなどの標準クラスも再オープンすることが出来る。

# Mix-in(多重継承)

# 本来Ruby自体はjavaと同じで多重継承を許していない。
# しかし、モジュールを使えば複数クラスで機能を共有することが出来る。

# クラスがモジュールをインクルードしている状態で、ancestorsメソッドで
# 継承チェーンを調べるとモジュールクラスも含まれて入るが、Superclassメソッドでは、
# 存在しないことになっている。