module Unit
  class NauticalMile < Linear
    # 1.85km
    @normalization_factor = 1.8532 * 1000 * 1000

  end
end
Unit::Nauticalmile = Unit::NauticalMile
