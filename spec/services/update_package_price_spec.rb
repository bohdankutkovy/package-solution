# frozen_string_literal: true

require 'spec_helper'

RSpec.describe UpdatePackagePrice do
  it 'updates the current price of the provided package' do
    package      = FactoryBot.create(:package)
    municipality = FactoryBot.create(:municipality)

    expect(package.price_for(municipality)).to be_nil

    UpdatePackagePrice.call(package: package, municipality: municipality, price_cents: 200_00)

    expect(package.reload.price_for(municipality).price_cents).to eq(200_00)
  end

  it 'only updates the passed package price' do
    municipality = FactoryBot.create(:municipality)
    package_1    = FactoryBot.create(:package)

    package_2 = FactoryBot.create(:package, name: 'Salty Lakrits')
    price     = FactoryBot.create(:price, package: package_2)
    FactoryBot.create(:price_assignment, municipality: municipality, price: price)

    expect do
      UpdatePackagePrice.call(package: package_1, municipality: municipality, price_cents: 200_00)
    end.not_to change {
      package_2.reload.price_for(municipality).price_cents
    }
  end

  it 'stores the old price of the provided package in its price history' do
    municipality = FactoryBot.create(:municipality)
    package      = FactoryBot.create(:package)
    old_price    = FactoryBot.create(:price, package: package, price_cents: 100_00)
    FactoryBot.create(:price_assignment, municipality: municipality, price: old_price)
    expect(package.prices.count).to eq(1)

    UpdatePackagePrice.call(package: package, municipality: municipality, price_cents: 200_00)
    expect(package.reload.prices.count).to eq(2)
    expect(package.prices.first.price_cents).to eq(old_price.price_cents)
  end

  # This tests covers feature request 1. Feel free to add more tests or change
  # the existing one.

  it 'supports adding a price for a specific municipality' do
    municipality = FactoryBot.create(:municipality)
    package      = FactoryBot.create(:package)

    UpdatePackagePrice.call(package: package, municipality: municipality, price_cents: 200_00)

    expect(package.price_for(municipality).price_cents).to eq(200_00)
  end
end
