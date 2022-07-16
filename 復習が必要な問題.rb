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



