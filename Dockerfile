FROM ruby:2.6.6
ENV LANG C.UTF-8
RUN apt-get update -qq && \
  apt-get install -y apt-utils \
  build-essential \
  libpq-dev \
  nodejs \
  vim \
  default-mysql-client 
# 作業ディレクトリの作成、設定
WORKDIR /app
# ホスト側（ローカル）のGemfileを追加する
ADD Gemfile .
ADD Gemfile.lock .
# Gemfileのbundle install
RUN bundle install
ADD . /app
EXPOSE 3000
