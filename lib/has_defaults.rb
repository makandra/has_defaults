require 'has_defaults/active_record_ext'

ActiveRecord::Base.__send__(:extend, HasDefaults::ActiveRecordExt::ClassMethods)

