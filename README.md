has_defaults [![Build Status](https://travis-ci.org/makandra/has_defaults.svg?branch=master)](https://travis-ci.org/makandra/has_defaults)
============

Default values for ActiveRecord models.

Installation
------------

In your `Gemfile`

    gem 'has_defaults'

Now run

    bundle install


Usage
-----

Add the method call `has_defaults` to your model.

	class Page < ActiveRecord::Base
	  has_defaults :title => "New page", :body => "Put your text here"
	end

Attributes will be set only if it's a new record and the attribute is blank.

Retrieve the default attribute with the `default_for` instance method:

	@page.default_for(:title)

You can pass Proc as attribute:

	has_defaults :expires_at => proc { Time.now }

You can override the default attributes as follow:

	Page.has_defaults_options = {:title => "Here's your new page", :body => "Write your page text"}


Development
-----------

There are tests in `spec`. We only accept PRs with tests. To run tests:

- Install Ruby 2.2.4
- Create a local test database `has_defaults_test` in both MySQL and PostgreSQL
- Copy `spec/support/database.sample.yml` to `spec/support/database.yml` and enter your local credentials for the test databases
- Install development dependencies using `bundle install`
- Run tests using `bundle exec rspec`

We recommend to test large changes against multiple versions of Ruby and multiple dependency sets. We provide some rake tasks to help with this:

- Install development dependencies using `bundle matrix:install`
- Run tests using `bundle matrix:spec`

Note that we have configured Github Actions to automatically run tests in all supported Ruby versions and dependency sets after each push. We will only merge pull requests with successful test runs.


Credits
-------

* Original version by Nando Vieira (<http://simplesideias.com.br>)
* Patches in this fork by makandra (<http://makandra.com/>)
