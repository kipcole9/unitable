module Unit
  include Comparable
  
  class NormalizeError < RuntimeError; end
  class ConversionError < RuntimeError; end
  
  # Public API of a Unit
  class Unit < Numeric
    # Rounding precision for comparing two units
    EQUALITY_PRECISION = 5
    
    @normalization_factor = nil
    @base_unit = nil
    
    attr_accessor   :value
    attr_reader     :normalized_value, :base_unit
    
    delegate :to_i, :to_f, :to_d, :ceil, :floor, :round, :abs, to: :value
    
    def self.[](arg)
      new(arg)
    end
    
    def self.definition
      I18n.t("unit.#{self.unit_name}.definition", default: 'Undefined').gsub("\n",'')
    end
    
    def self.normalization_factor
      @normalization_factor
    end
    
    def self.available_units
      subclasses
    end
    
    def self.available_unit_types
      available_units.map{|c| c.name.split('::').last.underscore.singularize}
    end
    
    def initialize(arg)
      if arg.is_a? Hash
        @normalized_value = arg[:normalized]
        @value = denormalize_value
      elsif arg.class.superclass == self.class.superclass
        @normalized_value = arg.normalized_value
        @value = denormalize_value
      else
        @value = arg.to_f
        @normalized_value = normalize_value
      end
    end
    
    def +(other)
      if other.class.superclass == self.class.superclass
        self.class.new(normalized: self.normalized_value + other.normalized_value)
      else
        self.class.new(self.value + other)
      end
    end
    
    def -(other)
      if other.class.superclass == self.class.superclass
        self.class.new(normalized: self.normalized_value - other.normalized_value)
      else
        self.class.new(self.value - other)
      end
    end
    
    def /(other)
      if other.class.superclass == self.class.superclass
        self.class.new(normalized: self.normalized_value / other.normalized_value)
      else
        self.class.new(self.value / other)
      end
    end
    
    def *(other)
      if other.class.superclass == self.class.superclass
        self.class.new(normalized: self.normalized_value * other.normalized_value)
      else
        self.class.new(self.value * other)
      end
    end
    
    def **(other)
      self.class.new(self.value ** other)
    end
    
    def succ
      self.class.new(self.value + 1)
    end
    
    def <=>(other)
      if other.class.superclass == self.class.superclass
        self.normalized_value <=> other.normalized_value
      else
        self.value <=> other
      end
    end
    
    def ==(other)
      if other.class.superclass == self.class.superclass
        self.normalized_value.round(EQUALITY_PRECISION) == other.normalized_value.round(EQUALITY_PRECISION)
      else
        self.value == other
      end
    end
    
    def to_s(format = :short)
      name = self.class.name.split('::').last.downcase
      key = case format
      when :long
        "unit.#{name}.long"
      else
        "unit.#{name}.short"
      end
      "#{value.localize.to_s} #{I18n.t(key, count: self.value)}"
    end
    
    def inspect
      @value
    end
    
    def self.can_convert_to
      subclasses.map{|c| c.name.split('::').last.underscore.singularize}
    end
    
    def can_convert_to
      my_superclass = self.class.superclass 
      my_sibling_classes = my_superclass.subclasses - [self.class]
      my_sibling_classes.map{|c| c.name.split('::').last.underscore.singularize}
    end
    alias :available_units :can_convert_to
    
    def can_convert_to?(other)
      can_convert_to.include? other.to_s
    end

    def method_missing(method, args = nil, &block)
      if m = method.to_s.match(/(to|in)_(.*)/)
        convert(m[2])
      else
        super
      end
    end
    
  protected
  
    def convert(other_unit)
      other_unit = other_unit.singularize
      if can_convert_to.include? other_unit
        module_name = self.class.name.split('::')[0]
        "#{module_name}::#{other_unit.camelize}".constantize.new(normalized: self.normalized_value)
      else
        raise ConversionError, "Can't convert #{unit_name.underscore} to #{other_unit}"
      end
    end
    
    def self.unit_name
      name.split('::')[1].underscore
    end
    
    def unit_name
      self.class.unit_name
    end
    
    def normalize_value
      @value * self.class.normalization_factor
    end
    
    def denormalize_value
      @normalized_value / self.class.normalization_factor
    end

  end
end
