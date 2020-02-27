class AddTwitterToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :text
    add_column :users, :oauth_token, :string
  end
end
