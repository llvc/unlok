class CreateAuthenticationTokens < ActiveRecord::Migration
  def change
    create_table :authentication_tokens do |t|
      t.string :auth_token, unique: true
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
