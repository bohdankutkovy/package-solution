# frozen_string_literal: true

class CreateMunicipalities < ActiveRecord::Migration[7.0]
  def change
    create_table :municipalities do |t|
      t.string :code, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :municipalities, :code, unique: true
  end
end
