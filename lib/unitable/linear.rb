# http://gwydir.demon.co.uk/jo/units/length.htm
module Unit
  class Linear < Unit
    @base_unit = :millimeter
    
    def self.in_millimeters
      normalization_factor
    end
  end
  
end

Dir["#{File.dirname(__FILE__)}/linear/**.rb"].each {|f| require f}
