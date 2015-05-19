require 'spec_helper'

describe Unitable do
  it 'has a version number' do
    expect(Unitable::VERSION).not_to be nil
  end

  it 'knows 1 km in miles' do
    expect(Unit::Kilometer[1]).to eq(Unit::Mile[0.621371192237334])
  end
  
  it 'should work with max and min' do
    expect([Unit::Metre[10], 50].max).to eq(50)
    expect([100, Unit::Metre[50]].max).to eq(100)
  end    
end
