test ||= 10
p test # => 10

# sample = 20
sample ||= 'sample'
p sample # => 20

sample_txt ||= 'sample'
p sample_txt # => "sample"

# 省略しないで書くとこんな感じになる。
# test || (test = 1)