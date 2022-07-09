# ブロックについて

# def a_method(a,b)
#     p block_given? ? 'block true' : 'No Block'
#     p a + yield(a,b)
# end

# a_method(1,2){|a,b|(a+b)*3}

def my_method
    x = "Goodbye"
    yield("cruel")
end

x = "Hello"
my_method{|y| "#{x},#{y}world" } #=> "Hello,cruelworld"
# 束縛
# ブロックは定義した時点での変数情報を格納するらしい。
# ブロックを受け取ったメソッド内にも同盟変数が定義されていたとしても、ブロックはメソッド内の変数は見ることができない。
# これを束縛という



# class,module,defのキーワードを使わなければスコープのフラット化が可能
# javaと同じくローカル変数を扱うことが出来る
my_var = "トップレベルのローカル変数"

MyClass = Class.new{
    # puts my_var

    define_method :my_method do
        puts my_var
    end
}

# MyClass.new.my_method


def d_method
    shared = 0

    Kernel.send :define_method, :counter do
        p shared
    end

    Kernel.send :define_method, :inc do |x|
        shared += x
    end
end

# d_method

# counter
# inc(4)
# counter

def methodb greeting
    p "#{greeting}"
    p yield + "さん"
end

my_proc = proc{"Bill"}
methodb("hello",&my_proc)