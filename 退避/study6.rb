class S
    @@val = 0
    p 'ここが一番最初の@@val'
    def initialize
            p 'Sクラスのinit'
        @@val += 1
            p @@val
    end
end

class C < S
    class << C
        @@val += 1
    end

    def initialize
            p 'Cクラスのinit'
        @@val += 1
            p @@val
        super
    end
    p "コンパイルが終わった時点では#{@@val}"
end
#=> ここの時点で既に1
C.new
#=> Cのinitで2、superで3
C.new
#=> Cのinitで4、superで5
S.new
#=> Sのinitで6
S.new
#=> Sのinitで7

p '-----------------------'
p C.class_variable_get(:@@val)