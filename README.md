# Manybots Gmail Madpizza Agent

manybots-gmail-madpizza is a Manybots Agent that finds [Madpizza.pt](http://www.madpizza.pt) order confirmation emails in your Manybots account, parses them and transform them to well structured Meal orders.

As a result, you can use visualizations like Meal Money (available within your Manybots installation) to figure out how much money you're spending at Madpizza.

This agent requires that you use an email observer like [manybots-gmail](https://github.com/manybots/manybots-gmail) to get emails into your Manybots account.

## Installation instructions

### Setup the gem

You need the latest version of Manybots Local running on your system. Open your Terminal and `cd` into its' directory.

First, require the gem: edit your `Botfile`, add the following, and run `bundle install`

```
gem 'manybots-gmail-madpizza', :git => 'git://github.com/manybots/manybots-gmail-madpizza.git'
```

Second, run the manybots-gmail-madpizza install generator (mind the underscore):

```
rails g manybots_gmail_madpizza:install
```

Finaly, migrate the database:

```
bundle exec rake db:migrate
```

### Restart and go!

Restart your server and you'll see the Manybots Madpizza Agent in your `/apps` catalogue. 

Go to the app to start the agent, and take care of your diet!
