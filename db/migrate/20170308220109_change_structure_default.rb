class ChangeStructureDefault < ActiveRecord::Migration[5.0]
  def up
    change_column_default :forms, :structure, {}
  end

  def down
    change_column_default :forms, :structure, '{}'
  end
end
