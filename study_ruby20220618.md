## Ruby Enumerableモジュールについて学んでいく

```time.map```という記述を見つけて、mapメソッドって配列かhashに使えるメソッドくらいにしか考えていなかったから、初めて見た時になんだコレってなったので、少し調べてみることした。

### Enumerable

これはモジュールである。<br>
Rubyをインストールした時についてくる組み込みのモジュール。
単語の意味は「数え上げる」。<br>
Arrayやhashは、このモジュールをインクルードしていくため、要素にイテレータでアクセスすることが出来る。<br>
モジュールはメソッドの塊みたいなファイルで、クラスがモジュールをインクルードして、そのメソッドを呼ぶことが出来るから、クラスの機能拡張的な役割。<br>
***Arrayのmapメソッドは、Enumerableモジュールで定義されているメソッドなのだ。eachやfind_allなんかもそう。***<br>
[参考リンク](https://books.google.co.jp/books?id=HOiNAwAAQBAJ&pg=PT105&lpg=PT105&dq=enumerable+%E6%84%8F%E5%91%B3&source=bl&ots=gMQ4bt6QrM&sig=ACfU3U3G-75nOw5xNgnp9y-EibaVhe5RfQ&hl=ja&sa=X&ved=2ahUKEwjzw87xp7f4AhVqUvUHHWWUC64Q6AF6BAgOEAI#v=onepage&q=enumerable%20%E6%84%8F%E5%91%B3&f=false)