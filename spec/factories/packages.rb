# frozen_string_literal: true

FactoryBot.define do
  factory :package do
    name { 'TestarensKorv' }
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
