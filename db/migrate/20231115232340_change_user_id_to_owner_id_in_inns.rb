class ChangeUserIdToOwnerIdInInns < ActiveRecord::Migration[7.0]
  def change
    rename_column :inns, :user_id, :owner_id
  end
end
