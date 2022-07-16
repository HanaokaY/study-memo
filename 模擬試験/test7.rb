characters = ["a", "b", "c"]

# characters.each do |chr|
#   chr.freeze
# end
# characters.map &:freeze
upcased = (characters.map &:freeze).map &:upcase
# upcased = characters.map do |chr|
#   chr.upcase #=> これは単純にupcaseは非破壊的メソッドでupcase!は破壊的メソッドだかららしい
# end

# p upcased


# Procはcallまたは[]で呼び出すことができる



class Ca
    CONST = "001"
end

class Cb
    CONST = "010"
end

class Cc
    CONST = "011"
end

class Cd
    CONST = "100"
end

module M1
    class C0 < Ca
        class C1 < Cc
            class C2 < Cd
                p CONST #=> まずはレキシカルを探索、なければ継承チェーンを探索。

                class C2 < Cb
                end
            end
        end
    end
end
# Rubyは定数の参照はレキシカルに決定されますが、この問題ではレキシカルスコープに定数はありません。
# レキシカルスコープに定数がない場合は、スーパークラスの探索を行います。

