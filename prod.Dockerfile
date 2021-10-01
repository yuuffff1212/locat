FROM ruby:3.0.1
ENV LANG C.UTF-8
ENV RAILS_ENV=production

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev yarn

RUN apt-get install -y nodejs npm
RUN npm install n -g
RUN n 14.17.6

#RUN mkdir /locat-app
WORKDIR /locat-app
COPY Gemfile /locat-app/Gemfile
COPY Gemfile.lock /locat-app/Gemfile.lock

RUN gem install bundler -v 2.2.24
RUN bundle install
COPY . /locat
RUN yarn install
#ADD . /locat-app
#RUN yarn install --check-files
#RUN bundle exec rails webpacker:compile
#RUN bundle exec rails assets:precompile

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
#RUN chmod 755 /locat-app/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
# Nginxと通信を行うための準備
RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids
VOLUME /locat-app/public
VOLUME /locat-app/tmp

#RUN bundle exec rake webpacker:install:vue

CMD bash -c "rm -f tmp/pids/server.pid && bundle exec pumactl start"
