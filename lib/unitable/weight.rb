# http://gwydir.demon.co.uk/jo/units/weight.htm
module Unit
  class Weight < Unit
    @base_unit = :grams
    
    def self.in_grams
      normalization_factor
    end
  end
  
end

Dir["#{File.dirname(__FILE__)}/weight/**.rb"].each {|f| require f}
