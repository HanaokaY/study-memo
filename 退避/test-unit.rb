require 'test/unit'

class SampleTest < Test::Unit::TestCase
    @@i = 0

    def test_sample1 #=> test_*という名前のメソッドを作成(ルール)
        foo = '111'
        assert_equal('111', foo)
    end

    def setup
      @@i += 1
      puts "\r\nstart test #{@@i}========================================"
    end
  
    def teardown
      puts "\r\nfinish test #{@@i}========================================"
    end
  
    def test_sample1
      assert_equal('111', foo)
    end
  
    def test_sample2
      assert_equal('222', foo)
    end

end


# setupメソッドとteardownメソッドでテストの前処理と後処理を設定できます
# testメソッド1個毎に両方の処理が実行されます。

