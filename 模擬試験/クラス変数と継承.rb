class A
    @value = 100
    @@value = 1  
    VAL = 10
    def self.value
        @@value
    end  
    def self.val
        # const_get(:VAL) 
        # const_getは、selfに定義された定数を探索します 
        VAL
    end
    def self.class_val
        @value
    end
end  
A.value # 1

class B < A
    VAL = 20
    @@value = 2
end
p A.value # 2
p B.value # 2
p "Aのクラスインスタンス変数は#{A.class_val}"
p A.val
p B.val
p "Bのクラスインスタンス変数は#{B.class_val}" #=> クラスインスタンス変数はサブクラスであっても何も関係がない。
class C < A
    @@value = 3
end
# すべての値が変わる
A.value # 3
B.value # 3
C.value # 3


# クラス変数は継承っぽいことが行われる。(厳密には継承ではないらしい)
# サブクラス側にも同じ値

# クラスインスタンス変数はそのクラスでしか値は保持してない。