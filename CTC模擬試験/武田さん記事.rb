# 環境変数 ENV は「文字列」がキー。
# p ENV['sample'] #=> キーは文字列じゃないとだめっぽい

# -Iオプション
# 引数で指定したディレクトリを$LOAD_PATH変数に追加する。
# 引数でしてしたディレクトリ($LOAD_PATH)はrequireやloadメソッドが呼ばれた時のファイル探索の際に使用される。

# 結合順
# 3.downto(0) {|i| puts i}
# 3.downto(0) do |i| puts i end
# 3.downto 0 do |i| puts i end
# 3.downto 0 {|i| puts i} #=> {}は()を省略することができないため文法エラーとなる。


# pメソッドとinspectメソッドの関係
# inspectメソッドはpメソッドでオブジェクトそのものを出力した際の文字列表現を指定するメソッドです。


# ensureの値は無視される
# 解説
# beginもensurenも各スコープ内でp,puts,print等の出力メソッドを使えば、出力は実行されるが
# 値については挙動が変わる

# begin節の値に関してはensureまでの出力が終わったら、最後に戻り値として返されるけど、
# ensureに関しては値が無視される。(メソッドの戻り値として返される。)

def foo
    begin
        true        
    ensure
        false #=> ensure節では簡単な例外処理を実装する程度が望ましい
        # 実際にこの節の値は戻り値とはならない
    end
end

# p foo


# 定数をメソッド内で更新、定義することはできない

class Cls1
    COSNT = 'HELLO' #=> 当然、問題なく定義できる
    def foo
        # COSNT = 'Class in HELLO'  #=> メソッドを定義した時点でエラーとなる
    end
    def fee(xxx)
        # COSNT = xxx #=> こちらもエラーになる
    end
    # しかし、<<(concat)を使用することは問題がない
    def faa
        CONST << 'hello' #=> <<は+=ではないから、なんの問題もないらしい
    end
end



# privateとprotected

class ClassName1
    def foo
        p 'パブリックです'
    end
    private
    def private_method
        p 'プライベートです'
    end
    protected
    def protected_method
        p 'プロテクトされてます'        
    end
end

class ClassName2 < ClassName1
    def initialize
        foo #=> 呼べる
        private_method #=> 呼べる
        protected_method #=> 呼べる
    end
end

class ClassName3 < ClassName2
    def initialize
        foo #=> 呼べる
        private_method #=> 呼べる
        protected_method #=> 呼べる
    end
end

# ClassName2.new
# ClassName3.new


# private レシーバ経由で呼べない、関数形式のみ許容
# ・protected レシーバ経由でも呼べる。ただし仲間に限る
# ・どっちもサブクラスからも呼べる
# ・どっちも他人からは呼べない


