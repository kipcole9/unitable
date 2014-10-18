# http://gwydir.demon.co.uk/jo/units/area.htm
module Unit
  class Area < Unit
    
  end
  
end

Dir["#{File.dirname(__FILE__)}/area/**.rb"].each {|f| require f}
