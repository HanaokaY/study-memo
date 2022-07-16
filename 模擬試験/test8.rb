class C
    # protected
    # def initialize
    # end
    def method_name_aaaaaaaaaaaaaaaaaaaaaaaaaaa
        
    end
end
class B < C
    
end

p B.methods.include? :initialize #=> ver2.1ではバグらしくて、これがtrueになる。RExではtreuだが、今のバージョンではfalse
# p C.new.methods.include? :initialize
p B.new.methods.include? :method_name_aaaaaaaaaaaaaaaaaaaaaaaaaaa
p B.new.methods
# Rubyでは、サブクラスでinitializeメソッド（C++やJavaでのコンストラクタに相当するメソッド）を定義しなかった場合、
# スーパークラスのinitializeメソッドが自動的に継承されます。



# initializeはpublicやprotecdの配下であってもprivateメソッドのままになる。