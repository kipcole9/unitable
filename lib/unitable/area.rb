# http://gwydir.demon.co.uk/jo/units/area.htm
module Unit
  class Area < Unit
    @base_unit = :square_millimeters
    
    def self.in_square_millimeters
      normalization_factor
    end
  end
  
end

Dir["#{File.dirname(__FILE__)}/area/**.rb"].each {|f| require f}
