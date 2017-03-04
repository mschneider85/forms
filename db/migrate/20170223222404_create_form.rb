class CreateForm < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'

    create_table :forms, id: :uuid do |t|
      t.string :name
      t.string :slug, index: true
      t.jsonb :structure, null: false, default: '{}'

      t.timestamps
    end
  end
end
