
# class Base
#     CONST = "Hello, world"
# end

# class C < Base
# end

# module P
#     CONST = "Good, night"
# end

# class Base #=> CONST = "Hello, world"
#     prepend P
# end

# module M
#     class C
#         CONST = "Good, evening"
#     end
# end

# module M
#     class ::C #=> モジュールMにあるクラスCはトップレベルにあるものを指します。 => :演算子
#         def greet
#             CONST
#         end
#     end
# end

# p C.new.greet

# ::演算子が先頭にあるとトップレベルから定数の探索を行います。
# 定数の探索順位はクラス内 -> スーパークラス -> クラス探索順に行われます。
# つまり、Cクラスには定数は存在しないが、スーパークラスのBaseにはCONST = "Hello, world"があるため呼ばれる。




# module MathConstant
#     PI = 3.14
# end

# class Area
#     include MathConstant

#     def circle(r)
#         r * r * PI
#     end
# end

# area = Area.new
# p area.circle 10



MyConst = 'TOPLEVEL'

class GrandParent
  # 定義しない
end

class Parent < GrandParent
  MyConst = 'Parent'
end

module NameSpace
  MyConst = 'NameSpace'
end

module MonkeyPatch
  MyConst = 'MonkeyPatch'
end


module NameSpace
    class Child < Parent
        prepend MonkeyPatch
        
        def put_myconst_at_base
            puts ::MyConst #=> これは単純にトップレベルのこと
        end

        def put_myconst
            puts Child::MyConst #=> まずはレキシカルで探す。なければ親クラス。今回はレキシカルに存在する。
        end

        def put_myconst_with_child
            puts ::NameSpace::Child::MyConst #=> ただのMyConstとどう違うのか。
        end

        def put_anything(arg)
            puts arg
        end

        def put_const_with_grandparent
            puts GrandParent::MyConst
        end

    end
end

# あるクラスまたはモジュールで定義された定数を外部から参照するためには、::演算子を用います。
# またObjectクラスで定義されている定数(トップレベルの定数と言う)を確実に参照するためには、
# 左辺無しの::演算子が使えます。

# NameSpace::Child.new.put_myconst_at_base #=> TOPLEVEL
NameSpace::Child.new.put_myconst #=> NameSpace
# NameSpace::Child.new.put_myconst_with_child #=> MonkeyPatch
# NameSpace::Child.new.put_anything(MyConst) #=> TOPLEVEL
# NameSpace::Child.class_eval { puts MyConst } #=> TOPLEVEL
# NameSpace::Child.new.put_const_with_grandparent #=> NameError


# Rubyは::NameSpace::LittleBrother::MyConstという定数を、それぞれにパーツに分離して計3回の探索をします。
# 発見されたオブジェクトは､次の探索の開始点として渡されますが、探索はあらためて行われます。



# module NameSpace
#     class LittleBrother < Parent
#     end
# end

# puts ::NameSpace::LittleBrother::MyConst



# class A
#     NAME = "CONST_A" #=> classA内に定数が定義されていない場合、NameErrorとなる。
#     # メソッドが定義されているスコープがレキシカルとなり、探索はスーパークラスにいく。
#     def self.name
#       NAME
#     end
#   end
  
#   class B < A
#     NAME = "CONST_B" #=> classB内にnameメソッドが定義されているなら、この変数が参照される。
#   end
  
# #   p B.new.name
# p A.singleton_class.constants #=> 定数の探索では継承チェーンと言うよりは、スコープを気にするのかな？
# クラスAに定数を定義していて、それを特異クラスに定義されているクラスメソッド経由でreadしようとすると、もしかしたら
# 特異クラス側には定数は存在しないから、参照できないんじゃないかって思ったけど、結果的には参照できているから関係ないらしい。




