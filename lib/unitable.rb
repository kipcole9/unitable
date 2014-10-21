require "unitable/version"
require 'active_support/inflector' unless defined?(ActiveSupport::Inflector)
require "unitable/unitable"
require "unitable/linear"
require "unitable/area"
require "unitable/weight"

I18n.load_path += Dir.glob( File.dirname(__FILE__) + "/locales/**/*.{rb,yml}" ) 

module Unitable
  module Numeric
    # Include the units as methods on the numeric
    # classes
    def self.included(base)
      Unit::Unit.subclasses.each do |measure|
        measure.subclasses.each do |klass|
          unit = klass.name.split('::').last.underscore
          [Float, Fixnum].each do |n|
            n.send :define_method, unit, -> {klass[self]}
            n.send :define_method, unit.pluralize, -> {klass[self]}
          end
        end
      end
    end
  end
end
