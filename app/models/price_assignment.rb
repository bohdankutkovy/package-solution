# frozen_string_literal: true

class PriceAssignment < ApplicationRecord
  # Relations
  belongs_to :price, optional: false
  belongs_to :municipality, optional: false

  # Validations
  validates :municipality_id,
            :price_id,
            presence: true

  validates_uniqueness_of :price_id, scope: :municipality_id
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
