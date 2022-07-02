module MyModule
    def my_method; "#{__method__} called!!"; end
end

class MyClass
    extend MyModule
    #=> extendで継承したメソッドはクラスメソッドのようにしか扱えない認識
end

MyClass.new.my_method  #=> NoMethodError: undefined method `my_method' for #<MyClass:0x007fd32104f280>
MyClass.singleton_methods  #=> [:my_method]
MyClass.my_method  #=> "my_method called!!"
