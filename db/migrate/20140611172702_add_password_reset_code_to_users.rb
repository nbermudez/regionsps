class AddPasswordResetCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_reset_code, :string, :limit => 40
  end
end
