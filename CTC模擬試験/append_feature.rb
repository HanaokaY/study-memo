module M
    def self.append_features(include_class_name)
        puts "append_features"
        super # このsuperを書かないと、includeしたはずのクラス(インスタンス)側でNoMethodError
    end
    
    def func
        p "Hello World"
    end
end

class C
    include M
end

C.new.func
