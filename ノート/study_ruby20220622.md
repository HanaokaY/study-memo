## Proc オブジェクト(クロージャ)
Ruby はブロックを Proc クラスのインスタンスとしてオブジェクト化できる。<br>
このオブジェクトに対して call メソッドを呼ぶとブロックが発動される。Proc オブジェクトを生成する方法が以下の通り。<br>
```

proc_obj = Proc.new do |name|
  puts "Hello, #{name}!"
end

proc_obj2 = proc do |name|
  puts "Hello, #{name}!"
end

proc_obj3 = lambda do |name|
  puts "Hello, #{name}!"
end

proc_obj4 = -> name do
  puts "Hello, #{name}!"
end

proc_obj.call "Ruby"    # => Hello, Ruby!
proc_obj2.call "Ruby"   # => Hello, Ruby!
proc_obj3.call "Ruby"   # => Hello, Ruby!
proc_obj4.call "Ruby"   # => Hello, Ruby!
```