class Err1 < StandardError; end
class Err2 < Err1; end

begin
    raise Err2
rescue ArgumentError => e
    # puts e.class
rescue => ex
    # puts "ここです"
end


def hoge *args
    # p *args
end

hoge [1,2,3]


def hoge2(x:,y:2,**params)
    # puts params[:hanaoka]
    # puts "#{x},#{y},#{params[:z]}"
end

hoge2 x:1, z:3,hanaoka: 5

# Ruby1.9から導入されたLambda記法 =>  ->(x){puts x}
hi = ->(x){puts x}
hi.call("hello")
class Hana; end
# hana = Hana.new
# hana = ->(x){puts x ** 2}
# hana.call(5)
# Hana = ->(x){puts x ** 2} # まじか、クラスでもLambdaできた。クラスも定数だからかな？
# Hana.call(3)


[1,2,3].inject([]){|x,y| #=> injectの引数に渡っているものがxとなる。つまり、[]
    p "#{x}と#{y}"
    x << y ** 2
}

p "windows,haaaows".match(/.*ows/)[0]

module M
    def foo
        super
        puts "M#foo"
    end
end

class C2
    def foo
        puts "C2#foo"
    end
end

class C < C2
    def foo
        super
        puts "C#foo"
    end
    prepend M
end

C.new.foo

str = "abcdefghijk"
p str[2,4]

