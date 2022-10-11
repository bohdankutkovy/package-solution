# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Municipality do
  it 'can be assigned to multiple prices' do
    municipality = FactoryBot.create(:municipality)
    package      = FactoryBot.create(:package)
    price_1      = FactoryBot.create(:price, package: package)
    price_2      = FactoryBot.create(:price, package: package)

    municipality.prices = [price_1, price_2]

    expect(municipality.prices).to eq([price_1, price_2])
    expect(PriceAssignment.find_by(price: price_1, municipality: municipality)).not_to be_nil
    expect(PriceAssignment.find_by(price: price_2, municipality: municipality)).not_to be_nil
  end

  it 'validates the presence of code' do
    municipality = FactoryBot.build(:municipality, code: nil)

    expect(municipality).to be_invalid
    expect(municipality.errors[:code]).to be_present
  end

  it 'validates the presence of name' do
    municipality = FactoryBot.build(:municipality, name: nil)

    expect(municipality).to be_invalid
    expect(municipality.errors[:name]).to be_present
  end

  it 'validates uniqueness of code' do
    municipality_1 = FactoryBot.build(:municipality, code: '2222')
    expect(municipality_1.save).to be true

    municipality_2 = FactoryBot.build(:municipality, code: '2222')
    expect(municipality_2.save).to be false
    expect(municipality_2).to be_invalid
    expect(municipality_2.errors[:code]).to include('has already been taken')
  end
end

# == Schema Information
#
# Table name: municipalities
#
#  id         :integer          not null, primary key
#  code       :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_municipalities_on_code  (code) UNIQUE
#
