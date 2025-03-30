class Addcategoriesdesires < ActiveRecord::Migration[7.2]
  def change
    create_table :categories_desires do |t|
      t.references :category, null: false, foreign_key: true
      t.references :desire, null: false, foreign_key: true

      t.timestamps
    end
    add_index :categories_desires, [:category_id, :desire_id], unique: true

    remove_column :desires, :category_id
  end
end
