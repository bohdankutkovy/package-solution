# frozen_string_literal: true

class UpdatePackagePrice
  def self.call(package:, municipality:, price_cents:)
    ActiveRecord::Base.transaction do
      # Add a pricing history record
      price = Price.create!(package: package, price_cents: price_cents)

      # Connect price with municipality
      PriceAssignment.create!(price: price, municipality: municipality)
    end
  end
end
