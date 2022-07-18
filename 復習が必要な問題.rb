v1 = 1 / 2 == 0
v2 = !!v1 or raise RuntimeError
puts v2 and false

# 


class Array
    def succ_each(step = 1)
        return __(1)__(__method__, step) unless block_given?

        each do |int|
            yield int + step
        end
    end
end

[97, 98, 99].succ_each.map {|int|
    p int.chr
}


# 


class C
    @val = 3 #=> これはインスタンスメソッドからは参照できない。
    attr_accessor :val #=> これはインスタンスメソッドが生成される。つまり、クラスインスタンス変数のためのアクセサではない。
    class << self
        @val = 10 #=> 特異クラスのクラスインスタンス変数だから、無視される。
    end
    def initialize
        if val
            p 'そもそもtrueじゃない'
        end
        @val *= 2 if val #=> valで参照できるインスタンス変数がない。つまり、この処理は実行されない。
    end
end

c = C.new
c.val += 10 #=> そもそもアクセサで参照できるインスタンス変数は生成されていない。

p c.val



# 



class Company
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
    end
  end
  
  companies = []
  companies << Company.new(2, 'Liberyfish')
  companies << Company.new(3, 'Freefish')
  companies << Company.new(1, 'Freedomfish')
  
  companies.sort
  
  companies.each do |e|
    puts e
  end


#   


class C
    include M1, M2 #=> 左からC>M1>M2となる
end

class C
    include M1
    include M2 #=> 後のほうがC近い C>M2>M1
end

# C.ancestorsしたときに違いがあるのか


# 

# 仕組みをもっと理解する必要がある。
# 解説は7/18の96点だったテストの39問目

class Array
    def succ_each(step = 1)
        unless block_given? #=> ブロックを渡していなかったら、このスコープでブロックを生成してる感じ
            Enumerator.new do |yielder|
                each do |int|
                    yielder << int + step
                    # チェーンした先で渡されたブロックを評価するためにはEnumerator::Yielderのオブジェクトを利用します。
                    # オブジェクトに対して、<<を実行することでブロック内で評価した結果を受け取ることが出来ます。
                end
            end
        else
            each do |int|
                yield int + step
            end
        end
    end
end

p [98, 99, 100].succ_each(2).map {|succ_chr| succ_chr.chr}

[101, 102, 103].succ_each(5) do |succ_chr|
  p succ_chr.chr
end