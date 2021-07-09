class ChangeUserToGuest < ActiveRecord::Migration[5.2]
  def change
    rename_column :invitations, :user_id, :guest_id
  end
end
