# Procオブジェクトを理解する

rubyGOLDの学習をすすめる中で、proc、ブロック、yieldというワードが出てくる。よくわからずにもやもやしていたため、一度しっかり向き合ってみる。

## ブロック

ブロックは```do-end```や```{}```の範囲のこと。<br>
これはもともとわかっている。<br>
このブロックは**オブジェクト**ではない。<br>

## Proc

Procというのは、「ブロックをオブジェクト化」したもの<br>
```
sample = Proc.new{ |n| n * n }

```
procは上記のように生成して、
```
sample.call(2) #=> 4
```
こんな感じで呼び出して実行できる。<br>

少しややこしいが、こんな事もできる。
```
def sample(&sample_proc)
	puts sample_proc.call(2)
end

sample { |n| n ** 4 } #=> 16
```
メソッドにブロックを渡す時に引数として「&引数名」とすると、Procオブジェクトになりメソッドの中でブロックを使うことができる。<br>
メソッド内で、「引数名.call」とするとProcオブジェクトが呼ばれ実行することができる。

## yield

yieldはメソッドの中で使われる時、メソッドの呼び出しと一緒に定義されたブロックをProcオブジェクトにしてProcを実行することができるもの?<br>

難しい。。。<br>

```
def sample
	puts yield(2)
end

sample { |n| n ** 5 }
```
yieldがない場合は、ブロック内で.callで実行される。<br>
yieldがある場合は、callなしで実行される且つ引数に```&sample_proc```みたいに、procを渡していることを明示的にしなくて良くなる。<br>
yieldが記述されているから暗黙の了解らしい。

## ちょっとつかってみた

```
proc = Proc.new{|x| x.map{|y|p y.concat('さん')}}
proc.call(['はなおか','さいとう','こうさか'])

```

procを生成して、callで配列を渡しながら読んでみた。<br>
最初のprocのブロック変数xには```['はなおか','さいとう','こうさか']```この状態で入ってくる。そのため、配列の要素それぞれになにかしたい場合は、map等のメソッドをチェーンして使用する。

## ブロックへの変換
```
def func x
    x + yield
end

proc = Proc.new{2}
func(1,&proc)
#=> 3
```
※procを変数として渡す際には&をつけるっぽい<br>
上記のような使い方もできる。

https://qiita.com/kidach1/items/15cfee9ec66804c3afd2
この記事めっちゃ良い
```
#メソッド定義
def give_me_block( &block )
  block.call
end

#実行
give_me_block do
  p "Hello, block!"
end
=> "Hello, block!"
```
