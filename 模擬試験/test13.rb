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