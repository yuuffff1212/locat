#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /locat/tmp/pids/server.pid

#bundle exec rails db:create
#bundle exec rails db:migrate
#bundle exec rails db:seed
#bundle exec rails webpacker:compile
#bundle exec rails assets:precompile
bundle exec rake assets:precompile

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
