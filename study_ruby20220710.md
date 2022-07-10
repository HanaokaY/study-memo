# 例外処理 begin-rescue

```
begin 
  # エラーを発生させる可能性のあるコード。
rescue => e # 例外オブジェクトを代入した変数。
  # begin~rescueの間でエラーが発生した場合に実行されるコード。
end
```

```
begin 
  raise # エラーを発生させます。
rescue => e
  p e #=> RuntimeError
end
```


