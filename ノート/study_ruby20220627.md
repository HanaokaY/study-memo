# lambdaを学ぶ

proc関連らしい。<br>
lambdaメソッドはprocインスタンスを生成する。<br>
でも、procとは異なる動きをするらしい。
```
lmd = lambda{|x| p x }
lmd = -> (x){ p x } #=> ruby1.9からはコッチの記述方法も出来るようになったらしい。
lmd.call(1)
#=> 1
```
procとlambdaは似ているが、lambdaの方が関数に近い動きをする。<br>
例えば、lambdaの方で引数の数が合わないとArgumentErrorが発生するが、procの場合は、数が合わない引数に関しては、nilが代入されるらしい。

