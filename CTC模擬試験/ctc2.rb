
[コード]
class Foo
    def initialize(obj)
        obj.foo
    end

    def foo
        puts "foofoofoo"
    end
end

class Bar
    def foo
        puts "barbarbar"
    end
end

Foo.new(Bar.new)


[コード]
class Bar
    def foo
        puts "barbarbar"
    end
end

class Foo < Bar
    def initialize(obj)
        obj.foo
    end

    def foo
        puts "foofoofoo"
    end
end

Foo.new(Foo.new(Bar.new))
