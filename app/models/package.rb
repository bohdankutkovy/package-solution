# frozen_string_literal: true

class Package < ApplicationRecord
  # Relations
  has_many :prices, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: true

  def price_for(municipality)
    municipality.prices.where(package_id: id).latest
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
