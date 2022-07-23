
# # # # [コード]
# # # class Foo
# # #     def initialize(obj)
# # #         # obj.fof #=> undefined method `fof' for #<Bar:0x00007fd230125200> (NoMethodError)
# # #         obj.foo
# # #     end

# # #     def foo
# # #         puts "foofoofoo"
# # #     end
# # # end

# # # class Bar
# # #     def foo
# # #         puts "barbarbar"
# # #     end
# # # end

# # # Foo.new(Bar.new) #=> barbarbar


# # # # [コード]
# # # class Bar
# # #     def foo
# # #         puts "barbarbar"
# # #     end
# # # end

# # # class Foo < Bar
# # #     def initialize(obj)
# # #         obj.foo
# # #     end

# # #     def foo
# # #         puts "foofoofoo"
# # #     end
# # # end

# # # Foo.new(Foo.new(Bar.new))



# # # 感想

# # # 引数にオブジェクトを渡して、オブジェクトの特異メソッドを実行することってできたんだな〜って感じ。



# # class Foo
# #     def foo
# #         "foo"
# #     end
# # end


# # class Bar < Foo
# #     def foo
# #         super + "bar"
# #     end
# #     alias bar foo
# #     # undef foo
# #     undef_method :foo
# # end

# # puts Bar.new.bar
# # p Foo.new.foo #=> undefより前の定義に影響があるとはいえ、Fooではundefの影響はない。
# # # p Bar.new.foo #=> 当然、NoMethodErrorになる。
# # # 解説
# # # たとえ、undefで古い名前の方を使えなくしても、新しい方で呼べば影響がない。


# # # undef_methodとremove_methodの違い
# # # remove_methodは現在のクラスからメソッドを削除しますが、
# # # 継承元にメソッドが定義されてあれば継承元のメソッドが呼ばれます。

# # # undef_methodはメソッド呼び出しへのレスポンスを止めます。
# # # remove_methodと違い、継承元のクラスにメソッドが定義されていてもエラーとなります。



# # # p => inspect
# # # print => to_s


# # p String("hello").inspect #=> "\"hello\""
# # p String("hello").to_s #=> "hello"
# # # 解説
# # # to_sがただ単に文字列を返しているのに対して、inspectはオブジェクトを可視化した感じ。

# # # pとinspectの関係
# # # pメソッドはputsとinspectを合体させた機能を持つメソッド
# # # つまり、p "hello"とputs "hello".inspectは同じ意味

# # class ClassName
# #     @@x = 'hellp'
# # end
# # puts (ClassName.new).to_s

# # # 備考
# # # to_sとto_strはちょっと違う仕様になっている



# def m
#     begin
#         puts "begin:1"
#         'hello'
#         p "beginのhello"
#     ensure
#         puts "ensure:1"
#         puts "ensure:2"
#         2 #=> ここは呼ばれない
#         "ensureのhello"
#     end
# end

# p m

# # 解説
# # beginもensurenも各スコープ内でp,puts,print等の出力メソッドを使えば、出力は実行されるが
# # 値については挙動が変わる

# # begin節の値に関してはensureまでの出力が終わったら、最後に戻り値として返されるけど、
# # ensureに関しては値が無視される。(メソッドの戻り値として返される。)

# def foo
#     begin
#         true        
#     ensure
#         false #=> ensure節では簡単な例外処理を実装する程度が望ましい
#         # 実際にこの節の値は戻り値とはならない
#     end
# end

# p foo


CONST = 'top' #=> topが出るということは、レキシカルスコープを探索したが、定数が見つからずに継承チェーンの探索に移り、最終的にObjectを探しに来たということ。
Object.class_eval(<<-CODE)
    CONST = 'eval#top'
CODE
Object.class_eval do
    CONST = 'eval#do-end#top' #=> Objectの場合はdoendだとしても、外側とか特になさそうだ。
end
class C
    # CONST = 'aaa'
end
module M
    # CONST = 'bbb'
end
module M
    class C
        CONST = 'ccc'
    end
end
module M
    class ::C
        p CONST
    end
end