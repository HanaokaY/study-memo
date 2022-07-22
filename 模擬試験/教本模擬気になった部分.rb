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
