# frozen_string_literal: true

class MigrateOldPrices < ActiveRecord::Migration[7.0]
  def up
    puts 'Migrating old prices'
    Price.find_each(batch_size: 100) do |price|
      Municipality.all.each do |municipality|
        PriceAssignment.create(price: price, municipality: municipality)
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
