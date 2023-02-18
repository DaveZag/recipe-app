require 'rails_helper'

RSpec.describe Food, type: :model do
  subject { Food.new(name: 'Chicken meat', measurement_unit: 'kgs', price: 10.0) }
  before { subject.save }

  context 'validation tests' do
    it 'should return correct measurement_unit' do
      expect(subject.measurement_unit).to eq 'kgs'
    end

    it 'name should be valid' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should return Chicken meat' do
      expect(subject.name).to eq 'Chicken meat'
    end

    it ' should return the correct price' do
      expect(subject.price).to eq 10.0
    end
  end
end
