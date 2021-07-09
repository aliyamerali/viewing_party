class ChangeUserToHost < ActiveRecord::Migration[5.2]
  def change
    rename_column :parties, :user_id, :host_id
  end
end
