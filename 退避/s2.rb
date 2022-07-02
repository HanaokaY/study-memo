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
    #=> prependは継承チェーンがincludeとは違って、継承しているクラスの手前になる
    #=> つまり、継承しているクラス内に同盟メソッドが定義されている場合には、オーバーライドする。
end

C.new.foo