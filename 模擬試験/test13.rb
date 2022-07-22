# # # module Pre
    
# # # end

# # # module Inc
    
# # # end

# # # class C
# # #     # include Inc
# # #     # # prepend Pre
# # #     # extend Pre
# # #     require Inc
# # # end

# # # p C.singleton_class.ancestors
# # # # includeとprependだと特異クラスの継承チェーンにはでてこない。つまり、クラスメソッドは取り込めていない。
# # # # extendだと特異クラスの継承チェーンに出てくる。つまり、クラスメソッドとして取り込んでいる


# # def method
# #     p '元メソッド'
# # end


# # # alias old_method method
# # # alias :old_method :method
# # # alias "old_method" "method" #=> 文字列はだめ

# # # alias_method :old_method, :method
# # # alias_method "old_method", "method" #=> 文字列かシンボルでの指定

# # # def method
# # #     old_method
# # #     p '変更後メソッド'
# # # end

# # method



# # # マーシャリング
# # # マーシャリングできるのはユーザーが作成したオブジェクトなど
# # # コレさえ覚えておけば１問は解ける。



# # class C
# #     def m1(value)
# #         p "引数は#{value}"
# #         100 + value
# #     end
# # end

# # module R1
# #     refine C do
# #         def m1
# #             super 50000
# #         end
# #     end
# # end

# # module R2
# #     refine C do
# #         def m1
# #             super 100
# #         end
# #     end
# # end

# # using R1
# # using R2 #=> R1で同盟のメソッドに対して上書きしているなら、後にusingしたR2の内容が上書きされる。
# # # R1の内容はsuperでは呼ばれない。

# # puts C.new.m1












# # 試したい問題

# # module M
# #     def foo
# #       super
# #       puts "M#foo"
# #     end
# #   end
  
# #   class C2
# #     def foo
# #       puts "C2#foo"
# #     end
# #   end
  
# #   class C < C2
# #     def foo
# #       super
# #       puts "C#foo"
# #     end
# #     load M
# #   end
  
# #   C.new.foo





# #   class Base
# #     CONST = "Hello, world"
# #   end
  
# #   class C < Base
# #   end
  
# #   module P
# #     CONST = "Good, night"
# #   end
  
# #   class Base
# #     prepend P
# #   end
  
# #   module M
# #     class C
# #       CONST = "Good, evening"
# #     end
# #   end
  
# #   module M
# #     class ::C
# #       def greet
# #         CONST
# #       end
# #     end
# #   end
  
# #   p C.new.greet
# #   p C.ancestors


# class Base
#     CONST = "Hello, world"
# end

# class C < Base
#     def serch
#         CONST
#     end
# end

# module P
#     CONST = "Good, night"
# end

# Base.class_eval(<<-EOS)
#     prepend P
# EOS


# p C.ancestors
# p C.new.serch
# # 解説
# # 定数の探索優先順位について
# # レキシカルスコープ -> 継承チェーン これは当然だけど、スーパークラスの前にモジュールがprependで挟まれていた場合は、
# # モジュールをまず飛ばしてスーパークラスから探索される。スーパークラスに定義されていない場合は最終的にモジュールに探索が来るようになっている。
# # ※注意
# # ancestorsで出力される継承チェーンについては、あくまでメソッド探索の際にしか参考にならない。
# # 実際のクラスの継承チェーンをたどる時は、classで定義されたオブジェクト(クラス)のみのつながりを継承チェーンと呼ぶ。



# # 


# class ClassNameA
#     $a = self
#     def hoge
#         $b = self
#     end
# end
# a = ClassNameA.new
# # p ClassNameA == $a, ClassNameA.new == $b #=> $bはhogeがインスタンスによって実行されない限りnil

# # p ClassNameA.new.hoge

# p 4/5r



class C
    CONST = 'Good, night'
end

module M
    CONST = 'Good, evening'
end

module M
    class C
        CONST = 'Hello, world'
    end
end

module M #=> ②トップレベルのクラスCで定数が定義されていなければモジュールMに探索が来る。
    class ::C #=> ①レキシカルに探索していくから、トップレベルのクラスCを見に行く。
        p CONST
    end
end