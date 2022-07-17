# class C
#     def self.m1
#       200
#     end
#   end
  
#   module R
#     refine C do #=> クラスメソッドをrefineしたいなら、C.singleton_classとしないといけない
#         p self #=> これは無名クラスとなる
#       def self.m1
#         100
#       end
#     end
#   end
  
#   using R

# #   puts C.m1



class Company
    include Comparable
    # extendはモジュールのインスタンスメソッドを特異メソッドとして追加します。
    # インスタンス変数からメソッドを参照することができなくなるので、エラーになります。
    attr_reader :id
    attr_accessor :name
    def initialize id, name
        @id = id
        @name = name
    end
    def to_s
        "#{id}:#{name}"
    end
    def <=> other
        self.id <=> other.id
        # other.id <=> self.id
    end
end

c1 = Company.new(3, 'Liberyfish').object_id
c2 = Company.new(2, 'Freefish').object_id
c3 = Company.new(1, 'Freedomfish').object_id
# p c1
# p c2
# p c3
# p c1.between?(c2, c3)
# p c2.between?(c3, c1)


# 16

#   module M #=> モジュールは別レキシカルスコープだと探索に来ないらしい
#     CONST = "Hello, world"
#   end
# #   class A
# #     CONST = 'hello ClassA'
# #   end
#   class M::C
#     def awesome_method
#       CONST #=> このレキシカルスコープに定義がない&&スーパークラスにも定義されていないならエラー
#     end
#   end
  
#   p M::C.new.awesome_method

# class C
#     CONST = "Hello, world"
#   end
  
#   module M
#     C.class_eval(<<-CODE) #=> class_evalに文字列を渡した場合のネストの状態はクラスC。
#       def awesome_method
#         CONST
#       end
#     CODE
#   end
  
#   p C.new.awesome_method
  
# 文字列 => クラスにコンテキスト
# ブロック => 一つ外にコンテキスト

class C
    CONST = "Hello, world"
  end
  
  module M
    C.class_eval do #=> class_evalにブロックを渡した場合は、ブロック内のネストはモジュールM
      def awesome_method
        CONST
      end
    end
  end
  
#   p C.new.awesome_method

# class String 
#     alias :hoge :reverse #=> alias式はメソッドやグローバル変数に別名を付けることができます。
#   end
  
#   p "12345".hoge

# aliasは,を使ってはいけない
# alias_methodは文字列とシンボルのどちらもオッケーだけど、カンマが必要

class String
    alias_method "hoge", "reverse"
  end
  
#   p "12345".hoge



# 34


class Class
    def method_missing(id, *args)
        puts "Class#method_missing"
    end
end
class A
    def method_missing(id, *args)
        puts "A#method_missing"
    end
end
class B < A
    def method_missing(id, *args)
        puts "B#method_missing"
    end
end

B.dummy_method #=> Classクラスのインスタンスメソッドということになる。BはClassクラスのインスタンスだから、Cのインスタンスメソッドを使っている。
B.new.dummy_method #=> これはBのインスタンスメソッドを呼んでいるから、Bのmethod_missingが呼ばれる。