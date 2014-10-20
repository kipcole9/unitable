require "unitable/version"
require 'active_support/inflector' unless defined?(ActiveSupport::Inflector)
require "unitable/unitable"
require "unitable/linear"
require "unitable/area"

I18n.load_path += Dir.glob( File.dirname(__FILE__) + "/locales/**/*.{rb,yml}" ) 

module Unitable

  
end
