# http://gwydir.demon.co.uk/jo/units/length.htm
module Unit
  class Linear < Unit

  end
  
end

Dir["#{File.dirname(__FILE__)}/linear/**.rb"].each {|f| require f}
