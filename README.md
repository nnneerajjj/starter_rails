# Starter Backend

```
  Designed and Built by

  _    _
 | \  | |
 | \\ | | ___  ___  _  __  ____      _
 | |\\| |/ _ \/ _ \| |/__|/ _  |    | |
 | | \  |  __/  __/|  /  | |_| | _  | |
 |_|  \_|\___/\___/|_|    \____|| |_| |
                                |_____|  

```

## Getting Started

These instructions will get you a copy of the project up and running on your
local machine for development and testing purposes.
See the [deployment](#deployment) section for notes on how to deploy the project
on a live system.

### Prerequisites

To run the Rails application, you will need to have the following software installed:

#### Ruby

Version 2.6.3 (set in [.ruby-version](.ruby-version))

##### GoRails Installation Guides

- [macOS](https://gorails.com/setup/osx)
  (installation via [rbenv](https://github.com/rbenv/rbenv))
- [Windows](https://gorails.com/setup/windows)
- [Ubuntu](https://gorails.com/setup/ubuntu)

#### Bundler

[Bundler](https://bundler.io/) is a tool for managing Ruby dependencies.

Install by running:

```
gem install bundler
```

#### PostgreSQL

We recommend installing version 9.6 or higher.

When setting up PostgreSQL for the first time, you will need to create a new
user. A commonly used username is `postgres`.

Take note of the username and password as they will be needed to configure the
Rails app. See the [database config](#database-config) section for details.

##### macOS Installation

We recommend either installing [Postgres.app](https://postgresapp.com/) or using Homebrew:

```
brew update
brew install postgresql
```

If you encounter errors while installing the `pg` gem (via `bundle install`),
you may need to make the PostgreSQL headers available to the build step by
exporting a `CONFIGURE_ARGS` variable and then running `gem install pg`.

If you installed Postgres.app, try the following:

```
export CONFIGURE_ARGS="with-pg-include=/Applications/Postgres.app/Contents/Versions/latest/include"
```

##### Windows Installation

1. Install [PostgreSQL for Windows](https://www.postgresql.org/download/windows/)
   (the actual .exe, not Linux Bash)
2. Create user and password for PostgreSQL
3. Install dependencies in Bash:  
   `sudo apt-get install postgresql-client-common postgresql-client libpq-dev`
4. Run a sanity check in Bash to verify that things are working:  
   `psql -p 5432 -h localhost -U postgres`
5. If you get a psql prompt, you're good to go

##### Linux Installation

See the [GoRails instructions for Ubuntu](https://gorails.com/setup/ubuntu/19.04#postgresql).

### Setup

Ensure you have installed all [prerequisites](#prerequisites) above and then:

1. Clone the repository
2. `cd` to project directory
3. Configure [database](#database-config)
4. Configure [environment variables](#environment-variables)
5. Run `bundle install` to install dependencies
6. Run `rails db:setup` to set up dev/test databases
7. Run `rails server` (or `rails s`) to start local server
8. Visit http://localhost:3005/api/v1 (base URL of API)
9. Visit http://localhost:3005/admin (admin panel)

#### Database Config

Open [`config/database.yml.example`](config/database.yml.example) to see an
example database configuration.

To configure Rails to connect to the database on your machine, copy and rename
`config/database.yml.example` to `config/database.yml`. (This file is added to
gitignore.)

If the example configuration does not work as is, it's likely that you need to
specify the username and password of your PostgreSQL user.
In the `development` and `test` sections, set the `username` and `password`
values to match your user.

##### Troubleshooting

By default, the database client uses a domain socket that doesn't need
configuration. Windows does not have domain sockets, so set the `host` to
`localhost` in the `development` and `test` sections when running on Windows.

Domain socket connection issues may also arise on macOS. If you encounter an
error like `PG::ConnectionBad: could not connect to server: No such file or directory`,
you can try setting the `host` option as mentioned above. Alternatively, you can try
[debugging issues with the PostgreSQL PID file](https://stackoverflow.com/a/21420719/956688).

#### Environment Variables

This project uses [Figaro](https://github.com/laserlemon/figaro) to manage
environment variables.
Open [`config/application.yml.example`](config/application.yml.example) to see
how to set environment variables.

To set up variables on your machine:

1. Copy and rename `config/application.yml.example` to `config/application.yml`
   (this file is added to gitignore)
2. Visit Heroku dashboard for [staging environment](https://dashboard.heroku.com/apps/rails-starter-backend-staging/settings)
   and copy variable values into `config/application.yml`
3. When adding new variables, add the variable to the required keys in
   [`config/initializers/figaro.rb`](config/initializers/figaro.rb)

## Starting Services

To start the Rails server on the default port of 3005, run the following:

```
rails s
```

Or, to run the server on a port other than the default (e.g. 5000):

```
rails s -p 5000
```

If you are developing/testing jobs using Active Job, start the job runner with:

```
rails jobs:work
```

## Testing

Our testing stack is composed of:

- [rspec-rails](https://github.com/rspec/rspec-rails):
  Unit and integration testing framework
- [Airborne](https://github.com/brooklynDev/airborne):
  API testing framework
- [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers):
  Testing matchers
- [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner):
  Database cleaning strategies to run between tests
- [factory_bot](https://github.com/thoughtbot/factory_bot):
  Ruby objects for test data
- [rspec-style-guide](https://github.com/reachlocal/rspec-style-guide):
  RSpec style guide

To run all tests, go to the root directory of the project and run:

```
bundle exec rspec
```

You can also use [guard](https://github.com/guard/guard) to run tests as files are changed:

```
bundle exec guard
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

This app can be easily deployed directly to [Heroku](https://www.heroku.com/home)
but also supports GitLab's
[Continuous Integration and Delivery (CI/CD)](https://about.gitlab.com/product/continuous-integration/)
features.

### Direct deployment via Heroku CLI and Git

To deploy this app directly to Heroku using Git:

1. Install [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)
2. [Deploy to Heroku with Git](https://devcenter.heroku.com/articles/git)
   1. Ensure you have committed your latest code
   2. Run `heroku create` to create a new app on Heroku
   3. Run `git push heroku master` to push the master branch  
      or `git push heroku yourbranch:master` to push a non-master branch
   4. Run `heroku open` to open the app in your browser

### GitHub Continuous Integration and Delivery

#TODO

#### CI/CD Environment Variables

Some of the jobs require certain
[environment variables](https://docs.gitlab.com/ee/ci/variables/README.html)
to be defined. These should be set in the GitLab UI under the **Variables**
section of the **CI/CD** settings of either a project or group.

- `HEROKU_API_KEY`  
  The `deploy` stage requires `HEROKU_API_KEY` to be defined for deploying to
  Heroku. It is recommended to set this at the **group** level so that it can
  be used by both the web and backend projects.
  Your Heroku API key can be retrieved from your
  [Heroku account](https://dashboard.heroku.com/account#api-key).
- `HEROKU_STAGING_APP_NAME`  
  The `deploy` stage requires `HEROKU_STAGING_APP_NAME` to be defined which
  specifies the name of the Heroku staging app to deploy to.
  This should be set at the **project** level since it is specific to backend.

#### Test Stage

The `test` stage runs every time new commits are pushed to a merge request in
GitLab. It includes the following jobs:

- __rubocop__  
  This job runs the `rubocop` command to check code style.
- __rspec__  
  This job runs the full test suite via `rspec`.
  Because the tests require a database, this job includes the `postgres` Docker service.
  Because the app requires certain [environment variables](#environment-variables)
  to be defined, this job uses the `application.yml.example` file to initialize
  the variables for use in the testing environment.

#### Deploy Stage

The `deploy` stage includes the `deploy_staging` job which uses
[dpl](https://github.com/travis-ci/dpl) to deploy the app to Heroku.
This job runs only upon commits to `master`.

The deployed app is intended to be the _staging_ app of a
[Heroku Pipeline](https://devcenter.heroku.com/articles/pipelines).
As such, this job is connected to the `staging`
[environment](https://docs.gitlab.com/ee/ci/environments.html) in GitLab.

## Active Storage Setup

Support for [Active Storage](https://edgeguides.rubyonrails.org/active_storage_overview.html)
is configured out-of-the-box, and Heroku provides some specific
[documentation](https://devcenter.heroku.com/articles/active-storage-on-heroku)
for using Active Storage on the platform.

By default, we rely on the [Bucketeer](https://elements.heroku.com/addons/bucketeer)
add-on for Heroku as the underlying S3 data storage provider.
To enable full support for
[direct uploads](https://edgeguides.rubyonrails.org/active_storage_overview.html#direct-uploads)
with Bucketeer, the CORS rules of the S3 bucket must be updated to allow both
`GET` and `PUT` methods.
The [Bucketeer documentation](https://devcenter.heroku.com/articles/bucketeer#using-with-the-aws-cli)
shows how to do this using the AWS CLI, but we've also created a Rake task that
makes it easier (`active_storage:update_cors` defined in
[`lib/tasks/active_storage.rake`](lib/tasks/active_storage.rake)).

To update the CORS rules for the Bucketeer bucket attached to a Heroku app,
run the task via the Heroku CLI:

```
heroku rake active_storage:update_cors
```

Remember that you can specify which Heroku app to run the command on by using
the `-a` or `-r` options if needed;
e.g. `-a starter-rails-backend-staging` or `-r staging`.

## User Authorization (Roles)

This application uses a single role based authorization with
[CanCanCan](https://github.com/CanCanCommunity/cancancan).
If you need multiple roles for a single user, we recommend that
you review the following links:

- [Role Based Authorization](https://github.com/CanCanCommunity/cancancan/wiki/Role-Based-Authorization)
- [Separate Role Model](https://github.com/CanCanCommunity/cancancan/wiki/Separate-Role-Model)
