class C
    @val = 3 #=> これはクラスインスタンス変数
    attr_accessor :val
    class << self #=> これは特異クラスをオープンしている状態
      @val = 10 #=> これは特異クラスのクラスインスタンス変数
    end
    def initialize #=> インスタンス変数にアクセスできるのは、initializeメソッドとオブジェクトのインスタンスメソッドだけ
      @val *= 2 if val
    end
  end
  
  c = C.new  
#   c.val += 10
  p c.val || "なにもない"