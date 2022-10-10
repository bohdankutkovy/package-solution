# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Package do
  it 'validates the presence of name' do
    package = Package.new(name: nil)
    expect(package.validate).to eq(false)
    expect(package.errors[:name]).to be_present
  end

  it 'validates the presence of price_cents' do
    package = Package.new(price_cents: nil)
    expect(package.validate).to eq(false)
    expect(package.errors[:price_cents]).to be_present
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
