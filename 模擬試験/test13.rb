module Pre
    
end

module Inc
    
end

class C
    # include Inc
    # # prepend Pre
    # extend Pre
    require Inc
end

p C.singleton_class.ancestors
# includeとprependだと特異クラスの継承チェーンにはでてこない。つまり、クラスメソッドは取り込めていない。
# extendだと特異クラスの継承チェーンに出てくる。つまり、クラスメソッドとして取り込んでいる



