module M
    def class_m
        "class_m"
    end
end

class C
    include M
end

# p C.methods.include? :class_m
# Kernelモジュールのmethodsメソッドは、特異メソッドの一覧を取得するメソッド
# extendは特異メソッドとして追加する



# requireとloadの違い

# requireは同じファイルは1度のみロードする、loadは無条件にロードする。
# requireは.rbや.soを自動補完する、loadは補完は行わない。
# requireはライブラリのロード、=> 1回でいい
# loadは設定ファイルの読み込みに用いる。 => 都度読み込みたい


module SuperMod
    module BaseMod
        p Module.nesting # [SuperMod::BaseMod, SuperMod]
    end
end

module SuperMod::BaseMod
    p Module.nesting # [SuperMod::BaseMod]
end

# 記述方法が変わると結果が変わる点に注意


p "Matis my tEacher"[/[J-P]\w+[^ ]/] #=> [^ ]により空白手前まで
# 正規表現の[]は囲まれた文字1つ1つにマッチします。
# J-Pは大文字のJからPの1文字にマッチします。
# \wは大文字、小文字、数字とアンダーバー(_)にマッチします。
# +は直前の文字が、1回以上の繰り返しにマッチします。
# [^ ]は空白以外にマッチします。

# p "HANAOKAyudai"[/[A-Z]+\w/]

module M
    def class_m
        "class_m"
    end
end

class C
    include M
end

# p C.methods.include? :class_m #=> methodsメソッドは特異メソッドのみを取得するからincludeだとインスタンスメソッドとなるからfalse


# a = (1..5).partition(&:even?)
# odd?が奇数、even?が偶数

local = 0

p1 = Proc.new { |arg1, arg2| #=> lambdaだと引数に厳しいから、この問題ではエラーになる
  arg1, arg2 = arg1.to_i, arg2.to_i
  local += [arg1, arg2].max
}

p1.call("1", "2")
p1.call("7", "5")
p1.call("9") #=> lambdaだとArgumentError

# p local

# module M
#     CONST = "Hello, world"
#   end
  
#   class M::C
#     def awesome_method
#       CONST
#     end
#   end
  
#   p M::C.const_defined?(:CONST) #=> 定数がレキシカルスコープ内に定義されていないからfalse。でも、継承チェーンをたどるから参照可能。
#   p M.const_defined?(:CONST)


module M
    CONST = "Hello, world"
  
    class C
      def awesome_method
        CONST
      end
    end
  end
  
  