FROM ruby:3.0.1

ENV LANG C.UTF-8
ENV RAILS_ENV=production
ENV NODE_ENV=production

RUN apt-get update -qq \
   && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g yarn

WORKDIR /locat
COPY . /locat
RUN gem install bundler
RUN bundle install
RUN yarn install
EXPOSE 3000

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Nginxと通信を行うための準備
RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids
VOLUME /locat-app/public
VOLUME /locat-app/tmp

CMD bash -c "rm -f tmp/pids/server.pid && bundle exec pumactl start"
