# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Package do
  it 'has multiple prices' do
    package = FactoryBot.create(:package)

    FactoryBot.create(:price, package: package)
    FactoryBot.create(:price, package: package)

    expect(package.prices.count).to eq(2)
  end

  it 'validates the presence of name' do
    package = FactoryBot.build(:package, name: nil)

    expect(package).to be_invalid
    expect(package.errors[:name]).to be_present
  end

  it 'validates uniqueness of name' do
    package_1 = FactoryBot.build(:package)
    expect(package_1.save).to be true

    package_2 = FactoryBot.build(:package)
    expect(package_2.save).to be false
    expect(package_2).to be_invalid
    expect(package_2.errors[:name]).to include('has already been taken')
  end

  it 'returns last set price' do
    package      = FactoryBot.create(:package)
    price_1      = FactoryBot.create(:price, package: package)
    price_2      = FactoryBot.create(:price, package: package)
    municipality = FactoryBot.create(:municipality)

    FactoryBot.create(:price_assignment, price: price_1, municipality: municipality)
    FactoryBot.create(:price_assignment, price: price_2, municipality: municipality)

    expect(package.price_for(municipality)).to eq price_2
  end
end

# == Schema Information
#
# Table name: packages
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_packages_on_name  (name) UNIQUE
#
