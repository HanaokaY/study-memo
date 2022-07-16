# # # # class C
# # # #     # protected
# # # #     # def initialize
# # # #     # end
# # # #     def method_name_aaaaaaaaaaaaaaaaaaaaaaaaaaa
        
# # # #     end
# # # # end
# # # # class B < C
# # # #     def initialize
        
# # # #     end
# # # # end

# # # # p B.new.methods.include? :initialize #=> ver2.1ではバグらしくて、これがtrueになる。RExではtreuだが、今のバージョンではfalse
# # # # # C.new.methods.include? :initialize
# # # # B.new.methods.include? :method_name_aaaaaaaaaaaaaaaaaaaaaaaaaaa
# # # # B.new.methods
# # # # # Rubyでは、サブクラスでinitializeメソッド（C++やJavaでのコンストラクタに相当するメソッド）を定義しなかった場合、
# # # # # スーパークラスのinitializeメソッドが自動的に継承されます。
# # # # p Object.instance_methods


# # # # # initializeはpublicやprotecdの配下であってもprivateメソッドのままになる。
# # # # # ただし、ruby2.1ではバグのため、protecdになってしまう


# # # module M
# # #     @@val = 75
  
# # #     class Parent
# # #       @@val = 100
# # #     end
  
# # #     class Child < Parent
# # #       @@val += 50
# # #     end
  
# # #     if Child < Parent
# # #         p 'Child < Parent' #=> true
# # #       @@val += 25
# # #     else
# # #         p 'Child > Parent'
# # #       @@val += 30
# # #     end

# # #     if Child < Object
# # #         p 'ChildよりObjectが右だから'
# # #     end
# # #     unless Object < Parent
# # #         p 'ObjectのほうがParentよりも右'
# # #     end
    


# # #   end
  
# # #   p M::Child.class_variable_get(:@@val)
  



# # #   def hoge(*args, &block)
# # #     block.call(*args)
# # #   end
  
# # #   hoge(1,2,3,4) do |*args|
# # #     p args
# # #     p args.length > 0 ? "hello" : args
# # #   end


# # mod = Module.new

# # mod.module_eval do #=> ブロックはネストの状態を変更しないので、module_evalのブロックで定義した定数はこの問題ではトップレベルで定義したことになります。
# #   EVAL_CONST = 100
# # end

# # puts "EVAL_CONST is defined? #{mod.const_defined?(:EVAL_CONST)}" #=> 定数は継承されるため、Objectには存在するのでtrueとなる。
# # puts "EVAL_CONST is defined? #{Object.const_defined?(:EVAL_CONST)}"





# # class Parent
# #     @@val = '@@クラス変数'
# #     @val = '@クラスインスタンス変数'
# #     VAL = '定数'
# #     def initialize
# #         @val = 'initialize内で定義したインスタンス変数'
# #     end
# #     def get_instance_val
# #         # @val = 'インスタンス変数' #=> initializeの変数を上書き
# #         @val
# #     end
# #     class << self

# #         def get_class_val
# #             @val
# #         end

# #         def teisu
# #             VAL
# #         end
# #     end
# # end

# # class Child < Parent
# #     # @@val = '@@子供のクラス変数'
# # end

# # p Child.new.get_instance_val #=> インスタンス変数は継承される。
# # p Child.class_variable_get(:@@val) #=> クラス変数は継承される。
# # p Child.get_class_val #=> クラスインスタンス変数は継承されない。
# # p Child.teisu #=> 定数は継承される。




# # class C
# #     def m1
# #       200
# #     end
# #   end
  
# #   module R
# #     refine C do
# #       def m1
# #         300
# #       end
# #     end
# #   end
  
# #   using R
  
# #   class C
# #     def m1
# #       100
# #     end
# #   end
  
# #   puts C.new.m1
# # #   Refinement -> prependしたモジュール -> クラスC -> includeしたモジュール -> クラスCの親（クラスB）
# # # Refinementは非常に探索の優先度が高いため、Refinementの後にクラスをオープンして上書きしてもRefinementが優先される。




# # module M1
# # end

# # module M2
# # end

# # class C
# #   include M1
# #   include M2 #=> 後の方がCに近くなる
# # end

# # # p C.ancestors

# p Class.method_defined? :new
# p String.method_defined? :new
# p Class.singleton_class.method_defined? :new
# p String.singleton_class.method_defined? :new
# # 上記でtrueとなる場合は、instance_methodsメソッドで一覧取得した結果に:newが含まれている。



# class C
#     @val = 3 #=> これはインスタンスメソッドからは参照できない。
#     attr_accessor :val #=> これはインスタンスメソッドが生成される。つまり、クラスインスタンス変数のためのアクセサではない。
#     class << self
#         @val = 10 #=> 特異クラスのクラスインスタンス変数だから、無視される。
#     end
#     def initialize
#         if val
#             p 'そもそもtrueじゃない'
#         end
#         @val *= 2 if val #=> valで参照できるインスタンス変数がない。つまり、この処理は実行されない。
#     end
# end

# c = C.new
# c.val += 10 #=> そもそもアクセサで参照できるインスタンス変数は生成されていない。

# p c.val




class C
end

module M
  refine C do
    def m1(value)
        p "refineC#m1#{value}"
      super value - 100
    end
  end
end

class C
  def m1(value)
    p "C#m1#{value}"
    value - 100
  end
end

using M

class K < C
  def m1(value)
    p "K#m1#{value}"
    super value - 100 #=> 単純にsuperの横にあるから引数扱いだった
  end
end

p K.new.m1 400