class AddDesirePriorityDefault < ActiveRecord::Migration[7.2]
  def change
    change_column :desires, :priority, :integer, :default => 0
  end
end
