# Only Rails LTS 3.2 will work together with Ruby 2.5.7. Therefore we patch the specs to simulate a Rails LTS 3.2
# instead of a vanilla Rails 3.2. Otherwise you would see an exception like below from the MySQL adapter:
#
# NoMethodError:
#   undefined method `visit_Integer' for #<ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter::BindSubstitution:0x000056424e26f368>
#   Did you mean?  visit_String
#   ./spec/has_defaults/active_record_ext_spec.rb:57:in `block (4 levels) in <top (required)>'
#

major_arel_gem_version = Gem::Version.new(Arel::VERSION).segments[0]
if RUBY_VERSION == '2.5.7' && major_arel_gem_version.between?(3, 6)
  # arel uses a visitor pattern, but does not know how to deal with Integers

  # https://github.com/rails/arel/blob/v3.0.3/lib/arel/visitors/depth_first.rb
  Arel::Visitors::DepthFirst.class_eval do
    private

    alias :visit_Integer :terminal
  end

  # https://github.com/rails/arel/blob/v3.0.3/lib/arel/visitors/dot.rb
  Arel::Visitors::Dot.class_eval do
    private

    alias :visit_Integer :visit_String
  end

  # https://github.com/rails/arel/blob/v3.0.3/lib/arel/visitors/to_sql.rb
  Arel::Visitors::ToSql.class_eval do
    private

    alias :visit_Integer :literal
  end
end
