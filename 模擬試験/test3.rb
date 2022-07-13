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