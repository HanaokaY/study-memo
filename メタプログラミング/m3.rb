# 動的ディスパッチを使ってみる。
# 基本的にはsendメソッドで実現するっぽい

class C1
    def method1
        p 'hello'
    end

    def method2
        p 'hello2'
    end

    def method3
        p 'hello3'
    end

    def method4
        p 'hello4'
    end
private
    def method5
        p 'hello5'
    end
end

attributers = [:method1,:method2,:method3,:method4,:method5]
c1 = C1.new
attributers.each do |a|
    c1.send(a)
    # 仮にここがドットaでメソッドを呼び出すとNoMethodErrorとなる
    # sendメソッドはprivateメソッドまで呼び出せてしまう
end