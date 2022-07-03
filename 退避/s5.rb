class C
    def foo
        puts "C#fooです"
    end
end

module M
    refine(C){
        def foo
            puts "MのC#fooです"
        end
    }
end

C.new.foo #=> using前だからrefine内での変更が適応されていない
using M
C.new.foo #=> using以降では変更後が適応される