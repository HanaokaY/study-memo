# def内でdef式の呼び出し

class C1
    def method1
        def method2
        end
    end
end

# p C1.instance_methods(false)
# C1.new.method1
# p C1.instance_methods(false) # 結果が変わる

# メソッドは普段、クラス内で定義しているからクラスに属していることが明らか
# 今回のような場合、method2の定義先はどこになるのか
# それは、method1のselfとなる。
# つまり、結局C2(クラス)

# includeとprependの違い

module M1
    def method1; "m1"; end
end

class C2
    prepend M1
    def method1; "c2"; end
end

class C3
    include M1
    def method1; "c3"; end
end

# p C2.new.method1
# p C3.new.method1

# C2のprependメソッドの方は、ancestorsメソッドで継承チェーンを
# 確認すればわかるけど、モジュールに対応する特異クラスを先頭に追加するため
# 先にモジュール内のメソッドから呼ばれる。


# クラスメソッドの定義
# Classクラスにメソッドを追加することでクラスメソッドになる。
class Class
    def c_method1
        "Classクラスのメソッド"
    end
    p self.ancestors
end

# p C3.c_method1
# p Class.ancestors

p self.class
p :Kernel.methods











