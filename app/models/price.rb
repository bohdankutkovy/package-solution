# frozen_string_literal: true

class Price < ApplicationRecord
  belongs_to :package, optional: false

  validates :price_cents, presence: true
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
