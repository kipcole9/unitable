module Unit
  class Meter < Linear
    @normalization_factor = 1000

  end
end
Unit::Metre = Unit::Meter
