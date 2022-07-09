# method_missingの活用例 ゴーストメソッド
上記例のような、未定義だがmethod_missing()で拾うことを前提としたメソッドをゴーストメソッドと呼びます。


## method_missingを活用する上で注意しなければいけない例 -> 無限ループの後StackOverFlowが発生する
```
class Roulette
    def method_missing(name, *args)
        person = name.to_s.upcase
        3.times do
            number = rand(10) + 1
            puts "#{number}..."
        end
        "#{person} got a #{number}" #=> ここがよくない。ブロックローカル変数であるnumber
    end
end
```
1. ブロック内で定義したブロックローカル変数は外部から参照できない
1. そのため、「"#{person} got a #{number}"」のタイミングで Rubyはそれ（number）を「メソッド」だと認識し、探しにいく
1. しかし継承チェーン内に見つからないためmethod_missing()が呼ばれる
1. だが、そもそも今回の問題は（オーバーライドした）method_missing()自体で起きている
1. よってバグは無限ループし続ける

# 動的にメソッドを呼び出す 動的ディスパッチ
send

# 動的にメソッドを定義する
define_method


# ローカル変数の境界線 スコープゲート

スコープが切り替わるタイミングというのは、クラス、モジュール、メソッドのスコープに出入りするタイミングである。<br>
この境界線の目印はClass、module、defの３つである。<br>
つまり、このキーワードを使わない方法であれば、スコープを超えたローカル変数の参照というのは可能になるわけだ。<br>
例
```
var = "トップレベル変数"
MyClass = Class.new{puts var}
```

# フラットスコープにする方法
スコープゲートをフラットにするにはメソッド呼び出しで置き換えることで可能
```
# class
Class.new

# module
Module.new

# def
Module.define_method
```

# ブロックについて Proc lambda
lambdaはProcをつくる方法のひとつのこと<br>
Procはブロックを持ち運び便利なオブジェクトにしたもの<br>
結局は、普通のブロックかProcしかない。
#### Procオブジェクトの精製方法
```
1. Proc.new{} 引数を多く渡しても必要な分だけ読み取る
1. proc{}
1. lambda{} 引数を多く渡すとArgumentErrorになる
1. ->{}
```
Proc.newではreturnでメソッド自体を抜ける。<br>
lambdaはreturnした後もメソッドに処理が戻る。<br>

注意しなければいけないのは、ProcはreturnしたらProcから戻るのではなくProcが定義されたスコープから戻る。<br>
つまり、
```
def foo call_proc_obj
    call_proc_obj.call
end

p = Proc.new{return 10}
foo(p)
```
Proc.newが定義されているスコープはトップレベルだから、トップレベルのスコープは抜けることができないため、LocalJumpErrorが発生する。


