FROM ruby:3.0.1
ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
apt-get install nodejs

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn

RUN mkdir /locat-app
WORKDIR /locat-app

COPY Gemfile /locat-app/Gemfile
COPY Gemfile.lock /locat-app/Gemfile.lock

RUN gem install bundler:2.2.24
RUN bundle install

ADD . /locat-app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Nginxと通信を行うための準備
RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids
VOLUME /locat-app/public
VOLUME /locat-app/tmp

#RUN yarn install --check-files
#RUN SECRET_KEY_BASE=placeholder bundle exec rails assets:precompile

CMD bash -c "rm -f tmp/pids/server.pid && bundle exec puma -C config/puma.rb"