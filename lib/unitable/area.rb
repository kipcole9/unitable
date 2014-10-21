# http://gwydir.demon.co.uk/jo/units/area.htm
module Unit
  class Area < Unit
    # @normalization_factor is in square millimeters
  end
  
end

Dir["#{File.dirname(__FILE__)}/area/**.rb"].each {|f| require f}
