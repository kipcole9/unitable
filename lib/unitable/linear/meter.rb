module Unit
  class Meter < Linear
    @normalization_factor = 1000.0

  end
end
Unit::Metre = Unit::Meter
