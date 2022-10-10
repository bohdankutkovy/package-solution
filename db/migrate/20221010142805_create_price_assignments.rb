class CreatePriceAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :price_assignments do |t|
      t.references :price, null: false, foreign_key: true
      t.references :municipality, null: false, foreign_key: true

      t.timestamps
    end

    add_index :price_assignments, %i[price_id municipality_id], unique: true
  end
end
