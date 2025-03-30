class CreateDesires < ActiveRecord::Migration[7.2]
  def change
    create_table :desires do |t|
      t.text :body
      t.integer :priority

      t.timestamps
    end
  end
end
