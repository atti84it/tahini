require 'spec_helper'

describe Unit, "#new_from_string" do
  it "parses the string and returns a Unit object" do
    u = Unit.new_from_string 'l'
    u.physical_type.should eq(Unit::VOLUME)

    u = Unit.new_from_string 'g'
    u.physical_type.should eq(Unit::WEIGHT)

    u = Unit.new_from_string 'kg'
    u.physical_type.should eq(Unit::WEIGHT)

    FactoryGirl.create :taza
    u = Unit.new_from_string 'taza'
    u.physical_type.should eq(Unit::VOLUME)
  end

  it "returns factor for metric conversions" do
    u = Unit.new_from_string 'kg'
    u.is_metric?.should be_true
    u.is_base?.should be_false
    u.factor_for('kg').should eq(1)
    u.factor_for('g').should eq(1000)

    u = Unit.new_from_string 'hg'
    u.is_metric?.should be_true
    u.is_base?.should be_false
    u.factor_for('g').should eq(100)
    expect{u.factor_for 'l'}.to raise_error(SpecificWeightRequired)
    expect{u.factor_for 'ml'}.to raise_error(SpecificWeightRequired)
    FactoryGirl.create :taza
    expect{u.factor_for 'taza'}.to raise_error(SpecificWeightRequired)

    u = Unit.new_from_string 'hg'
    u.factor_for('kg').should eq(0.1)
    
    u = Unit.new_from_string 'taza'
    u.physical_type.should eq(Unit::VOLUME)
    u.is_metric?.should be_false
    u.is_base?.should be_false    

    u = Unit.new_from_string 'l'
    u.factor_for('taza').should eq(5)

    u = Unit.new_from_string 'taza'
    u.factor_for('l').should eq(0.2)

    u = Unit.new_from_string 'taza'
    u.factor_for('cl').should eq(20)
    
    FactoryGirl.create :tbsp
    u = Unit.new_from_string 'taza'
    u.factor_for('tbsp').should be_within(0.01).of(13.52)
  end
end
