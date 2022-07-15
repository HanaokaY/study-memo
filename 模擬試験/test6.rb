# class C
# end

# p C.singleton_class.singleton_class.singleton_class.singleton_class
# 単純に特異クラスの特異クラスが存在するものらしい


# def hoge(*args, &block)
#     block.call(*args) #=> 引数に渡すときにアスタリスクがないと配列全体を一つの要素として渡す。
# end

# hoge(1,2,3,4) do |*args|
#     p args.length < 0 ? "hello" : args
# end


# class Human
#     attr_reader :name
  
#     def name
#       "Mr. " + super #=> 親クラスはObjectクラス。親にnameメソッドなんてない。
#     end
  
#     def initialize(name)
#       @name = name
#     end
#   end
  
#   human = Human.new("Andrew")
#   puts human.name

# class Human
#     attr_reader :name
  
#     def name
#       "Mr. " + @name
#     end
  
#     def initialize(name)
#       @name = name
#     end
#   end
  
#   human = Human.new("Andrew")
#   puts human.name
  

class Human
    attr_reader :name
  
    def name
      "Mr. " + name #=> nameメソッドの中で同名のメソッドを呼び出していますので、再帰呼出しになっています。終了せず、例外が発生します
    end
  
    def initialize(name)
      @name = name
    end
  end
  
  human = Human.new("Andrew")
  puts human.name