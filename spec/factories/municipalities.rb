# frozen_string_literal: true

FactoryBot.define do
  factory :municipality do
    code { srand.to_s.last(4) }
    name { 'Stockholm Municipality' }
  end
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
