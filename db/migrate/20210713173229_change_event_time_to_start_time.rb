class ChangeEventTimeToStartTime < ActiveRecord::Migration[5.2]
  def change
    def self.up
      rename_column :parties, :event_time, :start_time
    end
  end
end
