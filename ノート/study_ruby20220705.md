# 特異メソッド

## 特異メソッドは特定のインスタンスにのみ定義されたメソッドで、そのインスタンスをレシーバにして呼び出すことができます。

```
class C1
end

c1 = C1.new

#特異メソッド の定義
def c1.test_singleton_method
  p 'これはc1の特異メソッド'
end

#メソッドを定義したインスタンスをレシーバとして呼び出し
c1.test_singleton_method
```
# クラスメソッドは特異メソッド

クラス名もインスタンスであるから、クラスメソッドはそのクラスに定義された特異メソッドである

# クラスの継承チェーン

Classクラスのインスタンスであるクラスは、自動的にObjectクラスを継承している。<br>
例えば、Class MyClass; endで定義するとスーパークラスはObjectである。<br>
頭がこんがらがって、ちょっと疑問に思っていたのは、MyClassはClassクラスのインスタンスだから、スーパークラスには
Classクラスが来るかなとか思ったけど、あくまでオブジェクトとクラスの関係であるということ。