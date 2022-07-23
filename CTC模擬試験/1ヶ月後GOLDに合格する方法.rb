# Rubyの主なコマンドラインプション
# h,v,c,e,w系,I,r,d

# 環境変数ENV
# ENV[:PATH] = "user/..." # => キーがシンボルなので指定不可
# ENV['PATH'] = 1234 # => 代入する値が文字列ではないので指定不可
ENV['PATH'] = 'user/local...' # => どちらも文字列なので指定可
ENV['NAME'] = 'RUBY GOLD'
# p ENV


# NULLはObjectに標準で定義されていない


# 特殊変数 正規表現

# 以下のコードについて正しいものを選択しなさい(２つ選択)
# /(https://www(\.)(.*)/)/ =~ "https://www.qiita.com/"

# 1. $0の値は、ruby.rbである
# 2. $1の値は、https://www.qiita.com/である
# 3. $2の値は、.qiitaである
# 4. $3の値は、https://www.qiitaである

# 答え1, 2


# Rdoc マークダウン

# 見出し   = <h1>
        # == <h2>
        # === <h3>
        # ==== <h4>
        # ===== <h5>
        # ====== <h6>
# ボールド体(太字)	*text*
# イタリック体(斜体) _text_
# タイプライター体(均等) +text+
# リスト	*または-
# 番号付きリスト	数字.(ドット)
# ラベル付きリスト	[]で囲む または :で区切る


# 各変数を初期化していないときに参照した場合
# ローカル変数 => 例外発生(参照より前に代入文がある場合はnil)
# グローバル変数 => nil
# クラス変数 => 例外発生
# インスタンス変数 => nil
# 定数 = 例外発生


# 定数

CONST = "Top"

module Mod
  puts CONST # => Top
  puts ::CONST # => Top
  # モジュール内定数定義
  CONST = "Mod"
  puts CONST # => Mod まず自クラスから探索
  puts ::CONST # => Top
end

class Cls1
  puts CONST # => Top

  # クラス内定数
  CONST = "Cls1"
  puts CONST # => Cls1

  def func
    puts CONST
    puts ::CONST
    puts Mod::CONST
    #メソッド内で定数初期化
    # CONST = "func" # => dynamic constant assignment メソッド内で定数定義できない
  end

  include Mod
  puts CONST # => Cls1
  puts Mod::CONST # => Mod
end

# メソッドから参照
Cls1.new.func
# => Cls1
# => Top
# => Mod

class Cls2 < Cls1
  puts CONST # => Cls1

  CONST = "Cls2"
  puts CONST # => Cls2
  puts Cls1::CONST # => Cls1
  puts Mod::CONST # => Mod
end

p Cls1.ancestors # => [Cls1, Mod, Object, Kernel, BasicObject]
p Cls2.ancestors # => [Cls2, Cls1, Mod, Object, Kernel, BasicObject]

# 自クラスから探索開始。範囲演算子「::」を使用し探索開始経路を変更できる

::CONST # => トップレベルのCONSTを探す
Cls1::CONST # => Cls1クラス内のCONSTを探す
Mod::CONST # => Modモジュール内のCONSTを探す