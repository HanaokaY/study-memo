class S
    @@val = 0
    def initialize
        p 'Sクラスの初期化'
      @@val += 1
      p "現在#{@@val}"
    end
  end
  
  class C < S
    class << C
      p '特異クラス内。一度のみ読み込まれる'
      @@val += 1
      p "だから、この時点では#{@@val}"
    end
  end
  
#=> ここの時点で既に1
p 'Cクラスのインスタンス化でSのinit'
C.new
#=> Cのinitで2、superで3
p 'Cクラスのインスタンス化でSのinit'
C.new
#=> Cのinitで4、superで5
S.new
#=> Sのinitで6
S.new
#=> Sのinitで7
p '-----------------------'
p C.class_variable_get(:@@val)