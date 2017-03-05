class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'

    create_table :users, id: :uuid do |t|
      t.citext :email, null: false
      t.citext :username
      t.string :login_token
      t.datetime :token_generated_at

      t.timestamps

      t.index :email, unique: true
    end
  end
end
