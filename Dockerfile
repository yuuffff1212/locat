FROM ruby:3.0.1
ENV RAILS_ENV=production
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn
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