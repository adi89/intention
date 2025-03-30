class FixCategoryDesireRelationship < ActiveRecord::Migration[7.2]
  def change
    remove_column :categories, :desire_id, :integer
    add_reference :desires, :category, foreign_key: true
  end
end
