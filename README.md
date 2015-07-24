#CoffeShop

A WepApp to keep track of your small kiosk at work / your sports club / … based on Ruby on Rails and Metro-UI
* touch friendly
* focus on efficiency - buy your stuff fast
* per user accounts
* keep track of each user's balance
* keep track of the inventory
* set thresholds to get a warning if stock is running low
* …

__Beware: it's > 3 years old!__

## Run local on Ubuntu (quick 'n easy without RVM)

install necessary packages

	$ sudo apt-get install curl nodejs libmysqlclient-dev sqlite3 ruby-railties bundler

setup requirements

	$ cd /path/to/local/railsapp
	$ bundle install

run server

	$ rails server -e development

in a different console setup and seed DB

	$ rake db:schema:load && rake db:seed

visit http://localhost:3000