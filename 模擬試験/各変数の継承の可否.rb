class Parent
    @@val = '@@クラス変数'
    @val = '@クラスインスタンス変数'
    VAL = '定数'
    def initialize
        @val = 'initialize内で定義したインスタンス変数'
    end
    def get_instance_val
        # @val = 'インスタンス変数' #=> initializeの変数を上書き
        @val
    end
    class << self

        def get_class_val
            @val
        end

        def teisu
            VAL
        end
    end
end

class Child < Parent
    # @@val = '@@子供のクラス変数'
end

p Child.new.get_instance_val #=> インスタンス変数は継承される。
p Child.class_variable_get(:@@val) #=> クラス変数は継承される。
p Child.get_class_val #=> クラスインスタンス変数は継承されない。
p Child.teisu #=> 定数は継承される。





# 継承ではないが、コレもクラスインスタンス変数とインスタンス変数の復習


class C
    @val = 3 #=> これはインスタンスメソッドからは参照できない。
    attr_accessor :val #=> これはインスタンスメソッドが生成される。つまり、クラスインスタンス変数のためのアクセサではない。
    class << self
        @val = 10 #=> 特異クラスのクラスインスタンス変数だから、無視される。
    end
    def initialize
        if val
            p 'そもそもtrueじゃない'
        end
        @val *= 2 if val #=> valで参照できるインスタンス変数がない。つまり、この処理は実行されない。
    end
end

c = C.new
c.val += 10 #=> そもそもアクセサで参照できるインスタンス変数は生成されていない。

p c.val

