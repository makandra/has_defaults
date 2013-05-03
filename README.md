has_defaults
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


Maintainer
----------

* Original version by Nando Vieira (<http://simplesideias.com.br>)
* Patches in this fork by Henning Koch of makandra (<http://www.makandra.de/>)
