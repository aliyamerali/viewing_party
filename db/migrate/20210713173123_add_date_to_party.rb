class AddDateToParty < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :date, :string
  end
end
