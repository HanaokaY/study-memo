# # module M
# #     CONST = "Hello, world"
# # end

# # module M
# #     def self.say
# #         CONST
# #     end
# # end

# # # p M::say
# # # モジュールMを別々に書いたとしてもテーブルを参照して値を取得できます。
# # class ClassName
# #     NAME = 'Ruby'
# # end

# # class ClassName
# #     def self.name
# #         NAME
# #     end
# # end
# # # p ClassName.name
# # # 上記のモジュールと同様にクラスでも別々に書いたとしても、メモリに定数が登録されるから、問題なく取得できるらしい。


# # module M2
# #     CONST = "M2 hello"
# #     class << self
# #         CONST = "M2 singleton hello"
# #     end
# # end

# # M2.instance_eval(<<-CODE) #=> evalは特異クラスだから、特異クラス側に別に定数を定義しないとエラーになる。
# #     def say
# #         CONST
# #     end
# # CODE

# # p M2::say

# # p M2.const_get(:CONST)
# # p M2.singleton_class.const_get(:CONST) #=>　M2 singleton hello 定数は特異クラスには共有されていない


# # ClassName.instance_eval do 
    
# #     def sample
# #         p '特異クラスにインスタンスメソッドを定義した'
# #         # 特異クラスにインスタンスメソッドを定義するということは、クラス側からすればクラスメソッドとして使用できるということ
# #         # 特異クラスのオブジェクトとしてクラスがいるって感じだから、インスタンスメソッドをクラスメソッドとして定義できる。
# #     end
# #     def self.singlton_sample
# #         p '特異クラスに定義したクラスメソッド'
# #     end
# # end

# # ClassName.class_eval do
    
# #     def say
# #         p 'class_evalで定義したmethod'
# #     end
# #     def self.say
# #         p 'class_evalで定義したクラスメソッド'
# #     end
# # end
# # ClassName.sample
# # ClassName.singlton_sample
# # # instance_evalでは、クラスメソッドもインスタンスメソッドもどちらを定義しても、クラス側でクラス・メソッドとして呼び出せる。
# # ClassName.say
# # ClassName.new.say
# # # class_evalはクラスで定義している内容と同じように再定義できる。






# # module M #=> これならネストはMの中になる。
# #     CONST = "Hello, world"
# #     M.instance_eval(<<-CODE)
# #       def say
# #         CONST
# #       end
# #     CODE
# #   end
  
  
# #   p M::say
  
# #   module M
# #     CONST = "Hello, world"
# #   end
  
# #   M.instance_eval(<<-CODE) #=> これだとMの特異クラスにネストしていることになるらしい。
# #     def say
# #       CONST
# #     end
# #   CODE
  
# #   p M::say
  

# module M
#     CONST = "Mクラス"
#     # M.instance_eval(<<-CODE)
#     # CONST = "Mの特異クラス"
#     #   def say
#     #     CONST
#     #   end
#     # CODE
#     M.instance_eval do
#         CONST = "Mの特異クラス" #=> これも外側のスコープに引き継がれることにより、もともとのMのCONSTが上書きされるっぽい
#       def say
#         CONST
#       end
#     end
#   end
  
  
#   p M::say
#   p M.const_get(:CONST)
  




# module M
#     CONST = "Hello, world"
#   end
  
#   M.instance_eval(<<-CODE) #=> instance_evalだからインスタンスメソッドとして定義しても、クラスメソッドとして呼び出しが可能
#     def say
#       CONST
#     end
#   CODE
  
# p M.methods.include?(:say) #=> true


module M
    
end

M.module_eval(<<-CODE) #=> moduleとclass_evalだとクラスの再オープンだから、定数を参照できるっぽい
    CONST = 'yahooooooooo'
    def yahooooooooooooooooooooooo
        CONST
    end
CODE

module M
    p CONST #=> instance_evalで上が再オープンしているなら、ここはNameErrorになる。
end

# module_evalとclass_evalはクラスの定義の再オープン
# instance_evalはホントにそのオブジェクトだけ再オープンして定義するって感じ。
# instance_evalは本来,M.newとかしたインスタンスに使われがちだったから、気づかなかったけど、クラスもClassクラスのインスタンスだから、同じことがあり得る。





