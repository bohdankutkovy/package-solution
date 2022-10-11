# frozen_string_literal: true

class Municipality < ApplicationRecord
  # Relations
  has_many :price_assignments, dependent: :destroy
  has_many :prices, through: :price_assignments

  # Validations
  validates :code, :name, presence: true
  validates :code, uniqueness: true
end

# == Schema Information
#
# Table name: municipalities
#
#  id         :integer          not null, primary key
#  code       :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_municipalities_on_code  (code) UNIQUE
#
