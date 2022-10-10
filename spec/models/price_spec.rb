# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Price do
  it 'validates the presence of price_cents' do
    price = Price.new
    expect(price.validate).to eq(false)
    expect(price.errors[:price_cents]).to be_present
  end

  it 'validates the presence of package' do
    price = Price.new
    expect(price.validate).to eq(false)
    expect(price.errors[:package]).to be_present
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
