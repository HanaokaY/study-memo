# # Rubyの定数探索は主に二つの観点から行われます。

# # 一つ目がレキシカルスコープで、Rubyはクラスやモジュールをネストすると、
# # Ruby内部のnd_nextポインタを一つ外側のクラスに設定します。
# # そして、定数探索の時はそのnd_nextポインタを辿って定数探索の解決をします。

# # 二つ目はスーパークラスチェーンです。各スーパークラスのチェーンを辿って定数解決を行います。

# # 重要な優先順位は、
# # レキシカルスコープが優先され、その後に、スーパークラスが探索されることになります。
# # class A
# #     HOGE = 'A' #=> レキシカルスコープに定数が定義されていなければ、親クラスであるコレが参照される。
# # end
# # module B
# #     HOGE ='B' #=> レキシカルスコープが優先されるためコレが参照される。
# #     class C < A
# #         def hoge
# #             p HOGE
# #         end
# #     end
# # end
# # B::C.new.hoge


# # HOGE = 'TOP' #=> 継承チェーン
# # class A
# #   HOGE = 'A' #=> 継承チェーン
# # end
# # class B < A
# #     HOGE = 'B' #=> レキシカルスコープ
# #     def hoge
# #         p HOGE
# #     end
# # end
# # B.new.hoge

# # トップレベルの定数はレキシカルスコープではないのか？
# # るりま記載↓
# # トップレベルの定数定義はネストの外側とはみなされません。
# # したがってトップレベルの定数は、継承関係を探索した結果で参照されるので優先順位は低い と言えます。
# # B < A < Object


# # スーパークラスでサブクラスのメソッドを呼び出すことは可能
# # class A
# #     def hoge #=> このメソッドはBクラスのインスタンスからは呼び出しが可能。Bにはfugaメソッドが存在するため。
# #         fuga
# #     end
# # end

# # class B < A
# #     def fuga
# #         p 'fuga'
# #     end
# # end

# class A
#     HOGE = 'A'
#     def hoge
#         p HOGE
#     end
# end

# class B < A
#     HOGE = 'B' #=> この定数は探索の対象にはならない。
# end

# B.new.hoge


CONST = 'top'

module ModuleParent
    CONST = 'module'
end

class Parent
    prepend ModuleParent
    # CONST = 'parent' #=> なんでコレを消すと、initializeでmoduleが参照されるのか？

    def initialize
        p CONST
    end
end

class Child < Parent
    # CONST = 'child'
end

Child.new #=> initializeを継承していて、Childでp CONSTを実行するため、継承チェーン探索的にChild -> Module -> Parentとなっていたんだ。
# この結果を見て、やはり探索順はレキシカル -> 継承チェーンということが分かった。

# p Child::CONST
# p Parent::CONST

# 疑問
# なぜ、prependしてもParent::CONSTでparentが参照されるのか => レキシカルには当然なくて、次に継承チェーンに写ったときにChildの次はModuleのはずなのに...







# レキシカル > 継承チェーン
# prependには気をつける


