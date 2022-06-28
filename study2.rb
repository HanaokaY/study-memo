# retry

# a = 0
# begin
#     b = 1 / a
# rescue ZeroDivisionError
#     a += 1
#     retry
# ensure
#     p b
# end


# catchとthrow

def bar
    catch(:calc) do 
        throw :calc, "コレは元はthrowの引数"
    end
end

# p bar
# :calcはラベルと言って、catchとthrowをペアとして認識させる。
# throwにはラベルの他にも引数をもたせることができて、それは
# catchの戻り値となる。

