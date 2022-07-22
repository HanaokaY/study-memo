# protectedとprivateメソッドの可視性

# 基本的なルールは以下

# protected

    # レシーバーなしで参照可能
    # レシーバー(自分またはサブクラス)から参照可能
    # 自クラス、サブクラスから参照可能
    # クラス外部からは参照できない

# private

    # レシーバーなしで参照可能
    # レシーバーから参照できない ===> ここが違う
    # 自クラス、サブクラスから参照可能
    # クラス外部からは参照できない


class Sample
    def method_call(name)
        
    end
    def sample
        p 'sampleメソッド'
    end
    protected
    def foo
        p 'プロテクト'
    end
    private
    def fee
        p 'プライベート'
    end
end

# Sample.new.foo #=> クラス外部からの参照不可
Sample.new.send("fee") #=> sendメソッドを用いて動的に実行するメソッドを決める場合はprotectedもprivateも呼べてしまうようだ。

p Object.constants.include?(:NULL) #=> Objectクラスの組み込み定数にNULLなんてない



# 例外クラスの継承関係
# rescueはデフォルトではStandardErrorとなっている。
# rescueで指定された例外クラスのサブクラスまでを拾う

class Err < NameError;end
class Err1 < Err;end
class Err2 < Exception; end

# begin
#     raise Exception
# rescue => e
#     p e.class  
# # rescue NameError => ex
# #     p ex.class
# end

p '------------------------------------'


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
    # @@x = 3
end

class C < B
    @@x = 10
end
# B.instance_eval(<<-CODE)
#     @@x = 5
# CODE
B.instance_eval do
    @@x = 5
end
C.class_eval(<<-CODE)
    p Module.nesting
    @@x = 20
CODE

p A.x

p B.singleton_class.class_variables #=> [:@@x]
p B.class_variables #=> [:@@x]
# 解説
# クラス変数は特異クラスとクラスで共有されるし、
# どちらかで最後に更新した内容がそのクラス変数の最終決定となる。
# サブクラスまでも共有されるから、サブクラスでの最終決定のほうが優先される。

# 上でBとCをevalでオープンして、クラス変数を更新している
# 試したことは、Cクラスを先にオープンして@@xに20をいれて、その後にBをオープンして@@xに5を入れる。
# 期待した結果は一番継承チェーン的に若い(C<B<A)Cクラスで定義したクラス変数が最終決定となると思ったから、20が出力されると思った。
# 結果は、コード上で最後に定義したクラス変数が優先された。つまり、コード上ではBでクラス変数を最後に更新したから、Bで更新した5が結果となった。

# 考えられること
# クラス変数は継承チェーン上にあるクラス間クラス変数は共有されるから、どこで更新しても全く同じクラス変数をいじっていることになる。
# つまり、Cで更新しようが、Bで更新しようが、最初にAで定義した@@xクラス変数と全く同じものということ。