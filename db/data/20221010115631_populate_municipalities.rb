# frozen_string_literal: true

class PopulateMunicipalities < ActiveRecord::Migration[7.0]
  def up
    puts 'Populating municipalities list'
    municipalities = YAML.load_file(Rails.root.join('import/municipalities.yaml'))

    Municipality.create(municipalities)
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
