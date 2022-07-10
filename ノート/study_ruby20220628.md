# Ruby

## 主な例外クラス

| 例外クラス名 | 発生場面 |
| --- | --- |
| SyntaxError | 文法エラー |
| SignalException | 補足してないシグナルを受けたら |
| ArgumentError | 引数の数合わない |
| RuntimeError | 特定の例外クラスに該当しない場合 |
| NameError | 未定義の変数等の呼び出し |
| NoMethodError | 未定義のメソッドの呼び出し |
| ZeroDivisionError | 整数に対して0で除算したら |


# オブジェクト指向

Rubyではクラス名は大文字で始める。理由は、**クラス名が定数**だから。<br>
Rubyでは、クラス名で定数を作成して、その定数にクラスを格納する。クラスはオブジェクトという扱いとなっている。<br>
```
def Foo
end

a = Foo
a.new
Foo = 2 # コレは定数だから再代入は不可
```

# モジュール

1. モジュールは単独ではインスタンス化できない(newできない)
1. モジュールは、継承できない。
2. モジュールは、クラスや他のモジュールに取り込むことが出来る。

要は多重継承っぽいことが出来る。


# 特異クラス、特異メソッド

特異メソッドはインスタンスに直接メソッドを定義することが出来る。
つまり、Fooクラスのインスタンスであるfoo1に対して本来Fooクラス内部で定義するメソッドを定義できるのだ。
```
def Foo
    def method1
    end
    # =>これが本来のメソッドの定義方法
end

foo1 = Foo.new
def foo1.method2
    p 'これが特異メソッドの定義方法！'
end

```

# クラスメソッドの定義方法

### Classクラスに定義
Classクラスに定義することで、Classクラスを継承している子クラスは、Classクラスに定義されているメソッドをクラス名.クラスメソッドで使用できる。

```
class Class
    def c_method
        1
    end
end

Sample.c_method #=> 1
```

その他にも3種類の方法がある

```
# 1
def self.c_method; 1; end
# 2
def Sample.c_method; 1; end
# 3
class << self
    def c_method; 1; end
end
```

# メソッドの可視性
|||
| --- | --- |
|public|どのインスタンスからも実行可能|
|protected|自分自身、サブクラスのインスタンスから実行可能|
|private|レシーバをつけた実行は不可|

デフォルトではpublicだから、どのインスタンスからも実行可能になってる。

# トップレベルにおけるselfの参照先
## 〜Kernelメソッドの呼び出し方〜

Kernelモジュールのメソッドをレシーバ.メソッド名で実行するとNoMethodErrorになってしまう理由は、Kernelモジュールのメソッドの殆どがprivateが指定されているから。
では、なぜクラスではないKernelモジュールのメソッドが簡単に呼び出すことが出来るのか。例えば、pという出力メソッドなんかは、クラス内外で単体で実行できるように見える。これを理解するにはクラス外でself.classをしてみるとわかってくる。
class Class 
   p self.class
end
上記なら当然、#=>Class
でも、このclass外でself.classを実行するとObjectが返ってくる。
つまり、クラス定義の外側(トップクラス)はObjectのインスタンスが返るようになっている。
そして、ObjectクラスはKernelモジュールをincludeしているため、レシーバ指定なしでKernelのメソッドを実行できるというわけだ。



