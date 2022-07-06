# class Array
#     def replace(original, replacement)
#         self.map{|e| e == original ? replacement : e}
#     end
# end
# p ["hello","hello2","hello3"].replace("hello3","置換")


class MyClass
    def initialize
        @v = 1
    end

    def set=(val)
        @v = val
    end

    def get
        p self
        p @v
    end
end

obj = MyClass.new
obj_clone = obj

obj.set= 3
# obj_clone.set= 5
p obj.methods