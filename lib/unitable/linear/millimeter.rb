module Unit
  class Millimeter < Linear
    @normalization_factor = 1.0

  end
end
Unit::MM = Unit::Millimeter
Unit::Mm = Unit::Millimeter
Unit::Millimetre = Unit::Millimeter

