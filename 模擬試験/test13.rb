# module Pre
    
# end

# module Inc
    
# end

# class C
#     # include Inc
#     # # prepend Pre
#     # extend Pre
#     require Inc
# end

# p C.singleton_class.ancestors
# # includeとprependだと特異クラスの継承チェーンにはでてこない。つまり、クラスメソッドは取り込めていない。
# # extendだと特異クラスの継承チェーンに出てくる。つまり、クラスメソッドとして取り込んでいる


def method
    p '元メソッド'
end


# alias old_method method
# alias :old_method :method
# alias "old_method" "method" #=> 文字列はだめ

# alias_method :old_method, :method
# alias_method "old_method", "method" #=> 文字列かシンボルでの指定

# def method
#     old_method
#     p '変更後メソッド'
# end

method



# マーシャリング
# マーシャリングできるのはユーザーが作成したオブジェクトなど
# コレさえ覚えておけば１問は解ける。



class C
    def m1(value)
        p "引数は#{value}"
        100 + value
    end
end

module R1
    refine C do
        def m1
            super 50000
        end
    end
end

module R2
    refine C do
        def m1
            super 100
        end
    end
end

using R1
using R2 #=> R1で同盟のメソッドに対して上書きしているなら、後にusingしたR2の内容が上書きされる。
# R1の内容はsuperでは呼ばれない。

puts C.new.m1