FROM ruby:2.7

# このディレクトリはなんでもいい
# Docker内部の作業場所を指定
WORKDIR /var/www

COPY ./src /var/www

RUN bundle config --local set path 'vendor/bundle'
RUN bundle install

CMD ["bundle", "exec", "ruby", "app.rb"]
