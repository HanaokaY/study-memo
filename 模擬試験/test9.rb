# class C
#     def self.m1
#       200
#     end
#   end
  
#   module R
#     refine C do #=> クラスメソッドをrefineしたいなら、C.singleton_classとしないといけない
#         p self #=> これは無名クラスとなる
#       def self.m1
#         100
#       end
#     end
#   end
  
#   using R

# #   puts C.m1



class Company
    include Comparable
    # extendはモジュールのインスタンスメソッドを特異メソッドとして追加します。
    # インスタンス変数からメソッドを参照することができなくなるので、エラーになります。
    attr_reader :id
    attr_accessor :name
    def initialize id, name
        @id = id
        @name = name
    end
    def to_s
        "#{id}:#{name}"
    end
    def <=> other
        self.id <=> other.id
        # other.id <=> self.id
    end
end

c1 = Company.new(3, 'Liberyfish').object_id
c2 = Company.new(2, 'Freefish').object_id
c3 = Company.new(1, 'Freedomfish').object_id
# p c1
# p c2
# p c3
# p c1.between?(c2, c3)
# p c2.between?(c3, c1)