# http://gwydir.demon.co.uk/jo/units/weight.htm
module Unit
  class Weight < Unit

  end
  
end

Dir["#{File.dirname(__FILE__)}/weight/**.rb"].each {|f| require f}
