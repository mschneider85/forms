class CreateCampaign < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns, id: :uuid do |t|
      t.string :name
      t.citext :path
      t.integer :locale, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.timestamps
    end

    create_table :campaigns_users, id: :uuid do |t|
      t.belongs_to :campaign, type: :uuid, null: false, index: true
      t.belongs_to :user, type: :uuid, null: false, index: true
      t.integer :role, null: false, default: 0
      t.timestamps
    end
  end
end
