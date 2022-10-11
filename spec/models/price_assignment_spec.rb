# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PriceAssignment do
  it 'validates the presence of municipality' do
    price_assignment = FactoryBot.build(:price_assignment, municipality: nil)

    expect(price_assignment).to be_invalid
  end

  it 'validates the presence of price' do
    price_assignment = FactoryBot.build(:price_assignment, price: nil)

    expect(price_assignment).to be_invalid
  end

  it 'validates uniqueness of price in scope of municipality' do
    price = FactoryBot.create(:price)
    municipality = FactoryBot.create(:municipality)
    price_assignment_1 = FactoryBot.create(:price_assignment, price: price, municipality: municipality)

    expect(price_assignment_1).to be_valid
    expect(price_assignment_1).to be_present

    price_assignment_2 = FactoryBot.build(:price_assignment, price: price, municipality: municipality)
    expect(price_assignment_2).to be_invalid
  end
end

# == Schema Information
#
# Table name: price_assignments
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  municipality_id :integer          not null
#  price_id        :integer          not null
#
# Indexes
#
#  index_price_assignments_on_municipality_id               (municipality_id)
#  index_price_assignments_on_price_id                      (price_id)
#  index_price_assignments_on_price_id_and_municipality_id  (price_id,municipality_id) UNIQUE
#
# Foreign Keys
#
#  municipality_id  (municipality_id => municipalities.id)
#  price_id         (price_id => prices.id)
#
