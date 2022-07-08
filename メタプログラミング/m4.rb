class DebugCalled < BasicObject
    using ::Module.new { #=> using Module.new の中のrefineは他のファイルには一切影響を与えないらしい

        refine ::Object do
            def __apply__(name, *args)
                __send__(name, *args) #=> send が再定義された場合に備えて別名 __send__ も 用意されているらしい
            end
        end

        refine ::DebugCalled do
            def __apply__(name, *args)
                @target.__send__(name, *args)
            end
        end
    }

    def initialize(target)
        @target = target
    end

    # いずれかのメソッドが呼び出されたときに処理をフックする
    # 呼び出されたメソッドは @target へ委譲する
    def method_missing(name, *args)
        result = @target.__send__(name, *args)
    ensure #=> mapメソッドでは仮引数は使わずにナンバーパラメータ(_1)が使われている。暗黙的に第一引数を参照する。
        ::Kernel.puts "[debug called]: #{@target.__apply__(:inspect)}.#{name}(#{args.map { _1.__apply__(:inspect) }.join(", ")}) => #{result.inspect}"
        # inspectメソッドはオブジェクトや数値を見やすく整えてくれるだけのメソッドだから深く考えなくていい
    end

    module Refine
        refine Object do
            def debug
                DebugCalled.new(self)
            end
        end
    end
end


class C1
    def foo *name
        p "#{name}"
    end
end

p DebugCalled.new(C1.new).foo("はなおか","hello")
# p DebugCalled.new(C1.new).hoo

