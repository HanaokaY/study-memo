パイザのシュタゲコラボの問題(性能解析のタイプセーフ)に挑戦してみたところ、
ネット上で自分のコードよりも見るからにスマートでかっこいいコードを見つけたので解析してみた。

```
n,k,*a=$<.read.tr('.','').split.map &:to_i
p (a.sum+k-1)/k
```
上記が今回解析するコード。

### n,k,*a
複数変数に代入する記述
この記事を参考にした。
[Rubyで複数の変数に別々の値を代入するイディオム](Rubyで複数の変数に別々の値を代入するイディオム)

### $<
>すべての引数または標準入力で構成される仮想ファイルです。定数 Object::ARGF の別名です。
この変数はグローバルスコープ、読み取り専用です。

[こちら参照](https://docs.ruby-lang.org/ja/latest/class/Kernel.html#V_--3C)
[特殊変数](https://gist.github.com/kwatch/2814940)ってやつの１つ。ARGFと同じ意味らしい。
つまり、コードの```$<```の部分は```ARGF```に変更しても同じ結果になる。
ちなみに、```$<.methods```で調べるとこんなにある。
```
[:puts, :readline, :readlines, :path, :lineno, :getbyte, :getc, :readchar, :readbyte, :inspect, :seek, :tell, :write, :rewind, :pos, :pos=, :eof, :eof?, :gets, :close, :each, :closed?, :binmode?, :external_encoding, :internal_encoding, :lineno=, :to_io, :to_a, :to_s, :to_i, :argv, :to_write_io, :read_nonblock, :filename, :file, :skip, :inplace_mode, :inplace_mode=, :each_line, :each_byte, :each_char, :each_codepoint, :read, :binmode, :readpartial, :set_encoding, :fileno, :printf, :print, :putc, :drop_while, :cycle, :chunk, :slice_before, :slice_after, :slice_when, :chunk_while, :sum, :uniq, :compact, :lazy, :to_h, :include?, :max, :min, :find, :chain, :entries, :sort, :sort_by, :grep, :grep_v, :count, :detect, :find_index, :find_all, :select, :filter, :filter_map, :reject, :collect, :map, :flat_map, :collect_concat, :inject, :reduce, :partition, :group_by, :tally, :first, :all?, :any?, :one?, :none?, :minmax, :min_by, :max_by, :minmax_by, :member?, :each_with_index, :reverse_each, :each_entry, :each_slice, :each_cons, :each_with_object, :zip, :take, :take_while, :drop, :singleton_class, :dup, :itself, :taint, :tainted?, :untaint, :untrust, :untrusted?, :trust, :methods, :singleton_methods, :protected_methods, :private_methods, :public_methods, :instance_variables, :instance_variable_get, :instance_variable_set, :instance_variable_defined?, :remove_instance_variable, :instance_of?, :kind_of?, :is_a?, :display, :hash, :public_send, :class, :frozen?, :tap, :then, :yield_self, :extend, :clone, :method, :public_method, :singleton_method, :<=>, :define_singleton_method, :===, :=~, :!~, :nil?, :eql?, :respond_to?, :freeze, :object_id, :send, :to_enum, :enum_for, :__send__, :!, :__id__, :instance_eval, :==, :instance_exec, :!=, :equal?]
```

### tr()
文字列 String クラスの置換メソッド。
文字列から指定の文字を変換したあとの文字列を返す。
gsubと同じだが、ただ単に単一文字(一文字)の置換ならtrメソッドのほうが高速らしい。
[テックアカデミー参考記事](https://techacademy.jp/magazine/30510)
gsubは文字列の置換に使う。

### map &:to_i
普段はmap{|tmp| tmp.to_i}なんて書き方をしているが、```&```を使うことでスッキリさせることが出来る。
こちらの記事が大変参考になりました。
[参考記事](https://qiita.com/snyt45/items/7beb719ab0c4a25aa585)


### p (a.sum+k-1)/k

なぜ此の式なのか、[ヤフー知恵袋で質問してみた。](https://detail.chiebukuro.yahoo.co.jp/qa/question_detail/q11263395856)
>この問題は余りが１でもあれば、正解が商＋１になるのがポイント。
例えば「各プレイヤーの必要な経験値の合計」が１２５だったら、２５で割れば５で「式の結果＝正解」だけど、今回は１０１だから、２５で割れば４になって「式の結果＝正解」にならない。
そのため「２５－１」を足すことで、余りが１でもあれば、商が＋１されて「式の結果＝正解」となるようにしている。

ってことらしい。
**そのため「２５－１」を足すことで、余りが１でもあれば、商が＋１されて「式の結果＝正解」となるようにしている**
高等テクニックだわ。


