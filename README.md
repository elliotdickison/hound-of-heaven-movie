Hound of Heaven Website

### Installation
* Run `gem install bundler`
* Download the [Heroku dev tools](https://devcenter.heroku.com/articles/heroku-command-line)
* Run `heroku git:clone -a houndofheaven`
* Run `bundle install` from the resulting directory

### Development
* `bundle exec rackup config.ru -p 3000` to start a dev server

### Deployment
* `git push heroku master` to push changes to Heroku
