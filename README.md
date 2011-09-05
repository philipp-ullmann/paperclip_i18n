Paperclip I18n
===

Is an extension for the [thoughtbot paperclip](https://github.com/thoughtbot/paperclip) plugin to i18n support to file upload.
Every language has a seperate file scope.

* Tested with Rails 3.1

# Installation Instruction

Add this line to your Gemfile

    gem 'paranoid_i18n'

Bundle update in your console:

    bundle update

You may want to run the generator for final touches (see next step).

## Generator

There's a generator which creates the basic model, migration & controller for you:

    rails g paperclip_i18n
    rake db:migrate

You have to specify the controller in your config/routes.rb

    resources :assets, :only=>[:show]

