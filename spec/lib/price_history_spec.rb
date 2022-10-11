# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PriceHistory do
  # These tests cover feature request 2. Feel free to add more tests or change
  # the existing ones.

  it 'returns the pricing history for the provided year and package' do
    municipality_1 = FactoryBot.create(:municipality, name: 'Stockholm')
    municipality_2 = FactoryBot.create(:municipality, name: 'Göteborg')
    package        = FactoryBot.create(:package)

    travel_to Time.zone.local(2019) do
      # These should NOT be included
      UpdatePackagePrice.call(package: package, municipality: municipality_1, price_cents: 20_00)
      UpdatePackagePrice.call(package: package, municipality: municipality_2, price_cents: 30_00)
    end

    travel_to Time.zone.local(2020) do
      UpdatePackagePrice.call(package: package, municipality: municipality_1, price_cents: 30_00)
      UpdatePackagePrice.call(package: package, municipality: municipality_1, price_cents: 40_00)
      UpdatePackagePrice.call(package: package, municipality: municipality_2, price_cents: 100_00)
    end

    history = PriceHistory.call(package: package, year: 2020)
    expect(history).to eq(
      'Göteborg' => [100_00],
      'Stockholm' => [30_00, 40_00]
    )
  end

  it 'supports filtering on municipality' do
    package = FactoryBot.create(:package)
    municipality_1 = FactoryBot.create(:municipality, name: 'Stockholm')
    municipality_2 = FactoryBot.create(:municipality, name: 'Göteborg')

    travel_to Time.zone.local(2020) do
      UpdatePackagePrice.call(package: package, municipality: municipality_1, price_cents: 30_00)
      UpdatePackagePrice.call(package: package, municipality: municipality_1, price_cents: 40_00)
      UpdatePackagePrice.call(package: package, municipality: municipality_2, price_cents: 100_00)
    end

    history = PriceHistory.call(package: package, year: 2020, municipality: municipality_1)
    expect(history).to eq(
      'Stockholm' => [30_00, 40_00]
    )
  end

  it 'returns empty hash if filter is invalid' do
    package = FactoryBot.create(:package)
    municipality_1 = FactoryBot.create(:municipality, name: 'Stockholm')
    municipality_2 = FactoryBot.create(:municipality, name: 'Göteborg')
    municipality_3 = FactoryBot.create(:municipality, name: 'Uppsala')

    travel_to Time.zone.local(2020) do
      UpdatePackagePrice.call(package: package, municipality: municipality_1, price_cents: 30_00)
      UpdatePackagePrice.call(package: package, municipality: municipality_1, price_cents: 40_00)
      UpdatePackagePrice.call(package: package, municipality: municipality_2, price_cents: 100_00)
    end

    history = PriceHistory.call(package: package, year: 2020, municipality: municipality_3)
    expect(history).to eq({})
  end
end
