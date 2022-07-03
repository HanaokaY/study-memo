# Thread.list

# コンテキストとは、現在のselfのこと
require 'date'
require 'stringio'
# StringIOのインスタンス作成
sio = StringIO.open("Hello StringIO"){ |io|
    io.read
}
p sio


Date.parse("2022-07-03")
#=> date添付ライブラリをrequireしてないと文字列からparseできない。








