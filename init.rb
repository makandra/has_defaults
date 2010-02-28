require "has_defaults"

ActiveRecord::Base.__send__(:include, SimplesIdeias::Acts::Defaults)
