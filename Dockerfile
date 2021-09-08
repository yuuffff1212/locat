FROM ruby:3.0.1
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev yarn
RUN apt-get install -y nodejs npm
RUN npm install n -g
RUN n 14.17.6

WORKDIR /locat
COPY Gemfile /locat/Gemfile
COPY Gemfile.lock /locat/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /locat
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
VOLUME /locat/public
VOLUME /locat/tmp
CMD ["rails", "server", "-b", "0.0.0.0"]
