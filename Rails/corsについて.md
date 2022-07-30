# corsとは

CORSとはCross-origin Resource Sharingの略称<br>
このCORSの役割は「同一オリジンポリシー（Same-Origin Policy）」というルールによって設けられた制限を緩めるもの<br>

オリジンとは、URIのスキーム、ホスト、ポート番号の組み合わせのことを指す。<br>
例えば、http://localhost:8080というURIがあったときに、オリジンは以下のように分解できる。<br>
```
http: スキーム
localhost: ホスト
8080: ポート番号
```
まり、同一オリジンポリシーとは、異なるオリジン間でリソースにアクセスしようとした時に、ウェブブラウザが制限をかけてくれる仕組みのこと<br>

```
例)
vue => localhots:8080
rails => localhost:3000
お互いにリソースにアクセスしようとすること

```

# corsを設定して特定のURLからしかリクエストを受け付けない

CORSの設定をすることでフロント側のURLからしかリクエストを受け付けないように設定。

```
gem 'rack-cors' このコメントを外し、

$ bundle install 実行
```

下記のようにcors.rbの編集も必要

```
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV["API_DOMAIN"] || 'localhost:8080' 左記のどちらかからしか受け付けない

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end

```