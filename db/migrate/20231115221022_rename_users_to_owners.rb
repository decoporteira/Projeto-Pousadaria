class RenameUsersToOwners < ActiveRecord::Migration[7.0]
  def change
    rename_table :users, :owners
  end
end
