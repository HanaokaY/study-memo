module M
    def foo
        super
        puts "M#foo"
    end
end

class C2
    def foo
        puts "C2#foo"
    end
end

class C < C2
    def foo
        super
        puts "C#foo"
    end
    include M
end

# C.new.foo
# p C.superclass

# C2#foo
# M#foo
# C#foo

# この時の継承チェーンをイメージすればわかりやすい

# C < M < C2
# 上記のようになっているため、C.fooで実行されるsuperはMのfoo
# さらに、特異クラスのMの親はC2のため、Mのメソッド内のsuperはC2となる。


a = {
    4 => "a",
    2 => "c",
    3 => "b",
    1 => "d"
}

# p a.sort
# p a.sort{|a,b| b[1] <=> a[1]}

# シンボル
# p Symbol.all_symbols

# p :foo.id2name
# p :foo.to_s

# dir = Dir.open("/Users/hanaokayudai/Dropbox/")
# dir.close

# IOクラス これはFileクラスのスーパークラス
# p open("| ls").read.gsub(/\n/," ").split(" ").each{|file|puts file}

# io = open("study.txt")
# STDOUT.write("追加テキスト\n")
# io.readlines.each{|line|puts line.chomp}




mod = Module.new

mod.module_eval{EVAL_CONST = 100}

puts "EVAL_CONST is defined? #{mod.const_defined?(:EVAL_CONST, false)}"
puts "EVAL_CONST is defined? #{Object.const_defined?(:EVAL_CONST, false)}"

