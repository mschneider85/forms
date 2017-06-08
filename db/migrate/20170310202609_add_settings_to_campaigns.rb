class AddSettingsToCampaigns < ActiveRecord::Migration[5.0]
  def change
    remove_column :campaigns, :locale, :integer, null: false, default: 0
    add_column :campaigns, :settings, :jsonb, null: false, default: {}
    add_index :campaigns, :settings, using: :gin
  end
end
