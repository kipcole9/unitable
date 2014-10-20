require 'spec_helper'

describe Unitable do
  it 'has a version number' do
    expect(Unitable::VERSION).not_to be nil
  end

  it 'knows 1 km in miles' do
    expect(Unit::Kilometer[1]).to eq(Unit::Mile[0.621371192237334])
  end
end
