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