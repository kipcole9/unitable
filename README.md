# Unitable

Unitable is a simple unit conversion gem.  This is a work in progress.  Linear measures and weights are somewhat complete, areas less so.  Other unit types remain to be implemented.

## Installation

Add this line to your application's Gemfile:

    gem 'unitable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install unitable

## Usage

Unit instances are created in the normal fashion, namespaced by the module Unit. For example:

```ruby
Unit::Foot.new(1)
Unit::Kilogram.new(1)
Unit::Acre.new(23)
```

As a convenience measure you can use the array syntax to specify new unit instances.  For example:

```ruby
Unit::Foot[1]
Unit::Kilogram[1]
Unit::Acre[23]
```

### Unit conversion

Units of similar type can be converted to each other by calling the appropriate to_* method on the instance.  For example, to_foot.  You can also use in_* methods such as in_base_distances.  The plural and singular forms are accepted (as determined by pluralize and singularize from the ActiveSupport gem.)

```ruby
Unit::Foot[1].to_fathom
=> 0.16655737704918033
```

You can determine what conversions are possible with can_convert_to and ask specifically if a conversion is possible with can_convert_to?

```ruby
x = Unit::Perch[1]
x.can_convert_to
 => ["base_distance", "bowling_lane", "cable", "chain", "cricket_pitch", "cubit", "fathom", "foot", "furlong", "inch", "kilometer", "league", "light_year", "london_bus", "meter", "micron", "mile", "millimeter", "nautical_mile", "pica", "pole", "rod", "shackle", "yard"] 
x.can_convert_to? :london_bus
 => true
```
You can also convert or create a new unit instance by passing a hash with a normalised value to the Unit instance initialiser.  To display how many millimeters in a chain:

```ruby
Unit::Millimeter[Unit::Chain[1]]
 => 20116.8
```

### Normalized Values

Each object uses a normalized form for comparison and arithmetic, including conversions.  Conversions are done in floating point which introduces a normal level of variance on conversion and comparison.  The normalised value is typically using a metric measure for convenience.  For example, all linear measure are normalised to millimeters, areas to square millimeters, weight to grams.

```ruby
Unit::BaseDistance[1].normalized_value
 => 27432.0
Unit::NauticalMile[normalized: 27432.0]
 => 0.014802503777250162 
```

### Arithmetic

Standard arithmetic operators '+', '-', '/', '*', '**' are implemented.  Standard ruby numeric methods of abs, ceil, floor and round are also implemented.

```ruby
Unit::NauticalMile[43.2] + Unit::Mile[8]
 => 50.147308439456076 
Unit::LightYear[1.6].round
 => 2 
Unit::NauticalMile[43.2].floor
 => 43 
```

### String output

Units implement the to_s function leverages the I18n gem to pluralize and internationalize the output.  Only english translations are provided (more are welcome).

```ruby
Unit::NauticalMile[43.2].to_s
 => "43.2 nm" 
Unit::NauticalMile[43.2].to_s(:long)
 => "43.2 nautical miles" 
```

### Converting to numeric types

To convert a Unit to a base numeric type you may call to_i, to_f and to_d on a unit.

### Unit comparison

Units can be compared to each other.  The comparison is done using the normalized value. Since values are floating point and equality is therefore not certain, equality (==) is done on a normalized value rounded to 5 decimal places.

```ruby
y = Unit::Foot[1]
 => 1 
y.normalized_value
 => 304.8 
x = Unit::Kilometer[0.000305]
 => 0.000305 
x.normalized_value
 =>  305.0
y.normalized_value
 => 304.8 
x == y
 => false 

y = Unit::Foot[1]
 => 1 
y.normalized_value
 => 304.8 
x = Unit::Kilometer[0.0003048]
 => 0.0003048 
x.normalized_value
 =>  304.8
y.normalized_value
 => 304.8 
x == y
 => true
```

### Syntactical sugar

If you plan to use these methods frequently and don't mind adding methods to Float and Fixnum classes, you can include convenience methods.  Each unit will be available as a methods on these classes.  And the conversion methods can then be applied.

```ruby
include Unitable::Numeric
 => Object 
x = 1.kilometer
 => 1
x.class
 => Unit::Kilometer 
1.kilometer.in_inches
 => 39370.078740157485 
1.london_bus.in_perches
 => 1.6662689891036349 
1.light_year.in_millimeters
 => 9.46073047258e+18 
```

### What units are available?

You can find out what Unit types are available by:

```ruby
x = Unit::Unit.available_units
 => [Unit::Linear, Unit::Area, Unit::Weight]
x.first.can_convert_to
 => ["base_distance", "bowling_lane", "cable", "chain", "cricket_pitch", "cubit", "fathom", "foot", "furlong", "inch", "kilometer", "league", "light_year", "london_bus", "meter", "micron", "mile", "millimeter", "nautical_mile", "perch", "pica", "pole", "rod", "shackle", "yard"] 
Unit::Area.can_convert_to
 => ["acre", "square_kilometer", "square_inch", "square_meter", "square_mile"] 
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/unitable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Tests

Change to the gem directory, then:

```ruby
bundle install # required only on first installation
rspec
```