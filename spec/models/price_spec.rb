# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Price do
  it 'can be assigned to multiple municipalities' do
    price          = FactoryBot.create(:price)
    municipality_1 = FactoryBot.create(:municipality)
    municipality_2 = FactoryBot.create(:municipality, name: 'Lund Municipality')

    price.municipalities = [municipality_1, municipality_2]

    expect(price.municipalities).to eq([municipality_1, municipality_2])
    expect(PriceAssignment.find_by(price: price, municipality: municipality_1)).not_to be_nil
    expect(PriceAssignment.find_by(price: price, municipality: municipality_2)).not_to be_nil
  end

  it 'invokes termination of associated price_assignment object' do
    price            = FactoryBot.create(:price)
    price_assignment = FactoryBot.create(:price_assignment, price: price)

    expect { price.destroy }.to change { PriceAssignment.count }.from(1).to(0)
  end

  it 'validates the presence of price_cents' do
    price = FactoryBot.build(:price, price_cents: nil)

    expect(price).to be_invalid
    expect(price.errors[:price_cents]).to be_present
  end

  it 'validates the presence of package' do
    price = FactoryBot.build(:price, package: nil)

    expect(price).to be_invalid
    expect(price.errors[:package]).to be_present
  end

  it 'returns prices in descending created_at order' do
    package = FactoryBot.create(:package)
    price_1 = FactoryBot.create(:price, package: package, created_at: Time.now - 10.minutes)
    price_2 = FactoryBot.create(:price, package: package, created_at: Time.now - 5.minutes)
    price_3 = FactoryBot.create(:price, package: package, created_at: Time.now)

    expect(Price.ordered_by_creation_date).to eq([price_3, price_2, price_1])
  end

  it 'returns the latest price' do
    package = FactoryBot.create(:package)
    price_1 = FactoryBot.create(:price, package: package, created_at: Time.now - 10.minutes)
    price_2 = FactoryBot.create(:price, package: package, created_at: Time.now - 5.minutes)
    price_3 = FactoryBot.create(:price, package: package, created_at: Time.now)

    expect(Price.latest).to eq(price_3)
  end
end

# == Schema Information
#
# Table name: prices
#
#  id          :integer          not null, primary key
#  price_cents :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  package_id  :integer          not null
#
# Indexes
#
#  index_prices_on_package_id  (package_id)
#
# Foreign Keys
#
#  package_id  (package_id => packages.id)
#
