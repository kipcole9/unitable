module Unit
  class Kilometer < Linear
    @normalization_factor = 1_000_000

  end
end
Unit::Km = Unit::Kilometer
Unit::KM = Unit::Kilometer
Unit::Kilometre = Unit::Kilometer

