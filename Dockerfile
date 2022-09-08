FROM ruby:2.6.6
ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
#yarnのセットアップ
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH /root/.yarn/bin:/root/.config/yarn/global/node_modules/.bin:$PATH
# 作業ディレクトリの作成、設定
RUN mkdir /app_name
ENV APP_ROOT /app_name
WORKDIR $APP_ROOT
# ホスト側（ローカル）のGemfileを追加する
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock
# Gemfileのbundle install
RUN bundle install
ADD . $APP_ROOT
# gem版yarnのuninstall rails6でエラーになるため
RUN gem uninstall yarn -aIx
#webpackerの設定
#RUN rails webpacker:install
