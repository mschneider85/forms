class FieldSettingForm
  include ActiveModel::Model
  include ColumnAccessors

  column :id, :string
  column :type, :string
  column :label, :string
  column :required, :boolean

  column :placeholder, :string
  column :default_value, :string

  column :checked, :boolean

  validates :id, :type, :label, presence: true
end
