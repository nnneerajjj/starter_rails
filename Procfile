web: bin/rails server -p $PORT -e $RAILS_ENV
release: bundle exec rails db:migrate
rpush: bundle exec rpush start -e $RACK_ENV -f
worker: rails jobs:work
