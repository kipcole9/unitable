module Unit
  class Inch < Linear
    @normalization_factor = 25.4

    def to_s(format = :short)
      name = self.class.name.split('::').last.downcase
      case format
      when :long
        key = "unit.#{name}.long"
        "#{value.localize.to_s} #{I18n.t(key, count: self.value)}"
      else
        key = "unit.#{name}.short"
        "#{value.localize.to_s}#{I18n.t(key, count: self.value)}"
      end
    end
  end
end