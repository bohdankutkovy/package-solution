# frozen_string_literal: true

class Price < ApplicationRecord
  # Relations
  belongs_to :package, optional: false
  has_many :price_assignments, dependent: :destroy
  has_many :municipalities, through: :price_assignments

  # Validations
  validates :price_cents, presence: true

  # Scopes
  scope :newest, -> { order(created_at: :desc) }

  def self.current
    Price.newest.first
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
