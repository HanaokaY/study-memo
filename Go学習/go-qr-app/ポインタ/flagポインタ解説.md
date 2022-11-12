## flag パッケージの挙動

ところで、なぜ、flag.String()は、stringのポインターを返すのでしょうか？
また、flag.Parse()が呼ばれるまでコマンドライン引数の値は取得されないにも関わらず、flag.Parse()に特に引数や返り値を持たせずに、後から変数outputPathにコマンドライン引数の値が入るのでしょうか？
この点について、flagパッケージの挙動の理解しながら答えを探りたいと思います。
また、それを理解しながら、ポインターとグローバル変数の使い方を再度理解したいと思います。
(やや発展的な話になるので、読み飛ばして次のパートに進んでも構いません。)

まず、flagパッケージの内部実装を除くと、下記のようにCommandLineというグローバル変数を定義していることがわかります。
```
go
var CommandLine = NewFlagSet(os.Args[0], ExitOnError)\
```
CommandLineに実際に代入している値は、今回のためには理解する必要はありません。
このようなグローバル変数があることを確認すれば大丈夫です。

次に、flag.Stringの内部実装も見てみましょう。
```
go
func String(name string, value string, usage string) *string {
	return CommandLine.String(name, value, usage)
}
```
ご覧のように、このCommandLine変数に対してメソッドを実行しています。

次に、flag.Parseの内部実装も見てみましょう。
```
go
func Parse() {
	CommandLine.Parse(os.Args[1:])
}
```
こちらもCommandLine変数に対してメソッドを実行しています。
これらも、これ以上の内部実装を追いかける必要はここではありません。

ここまでで、今回の問いの答えを出す材料が揃いました。
具体的には、下記の２つが材料となります

flagパッケージにはCommandLineというグローバル変数があり、flag.Stringもflag.Parseもこの共通の変数にアクセスしている

String関数は、ポインターを返す

この二つをヒントに、このパートで作成したコードを実行した際の挙動を考えてみましょう。

まず、先に実行したflag.Stringは、メインメモリ上にstringの値を作成します(まだこの時点ではデフォルトの空文字)。そして、その値を参照するポインタをCommandLine変数内のフィールドの一部に登録します。
さらに、同じポインタを返り値として返して、それをmain.go内でoutputPathという変数に代入していました。こうすることで、CommandLineとoutputPathは、同じ値へのポインタ参照を持ちます。
この時点の状態を図にすると、下記のようになります。

[image.png](https://techpit-market-prod.s3.amazonaws.com/uploads/part_attachment/file/29892/3fca9545-8596-4f26-94e8-32c7e4c2db52.png)

そして、flag.Parse関数は、コマンドライン引数で受け取った値を、グローバル変数であるCommandLine変数にアクセスして登録します。そして、CommandLine変数はポインタ参照を持っているので、メインメモリ上にある値が更新されます。
そのため、下記のように、同じ値ポインタを参照しているoutputPath変数が参照するstringの値も更新されます。

[Image from Gyazo](https://techpit-market-prod.s3.amazonaws.com/uploads/part_attachment/file/29893/1420197d-53ff-4c35-bf7a-506230e93e9f.png)

以上が、ざっくりとしたflagパッケージを利用した値の更新方法でした。
このように、グローバル変数やポインタをうまく使うと、同じ値に別々の場所からアクセスして更新することができます。もちろん、これらは意図せず値を更新してしまうリスクもあるので、安易に利用するべきではないですが、発展的な手法として覚えておいても良いかもしれません。