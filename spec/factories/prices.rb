# frozen_string_literal: true

FactoryBot.define do
  factory :price do
    package
    price_cents { rand(100_00..999_00) }
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
