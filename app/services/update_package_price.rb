# frozen_string_literal: true

class UpdatePackagePrice
  def self.call(package, new_price_cents, **_options)
    Package.transaction do
      # Add a pricing history record
      Price.create!(package: package, price_cents: package.price_cents)

      # TODO: NOT valid anymore, get rid of it
      # package.update!(price_cents: new_price_cents)
    end
  end
end
