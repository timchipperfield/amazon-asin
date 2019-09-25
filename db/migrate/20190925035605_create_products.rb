class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :asin
      t.float :rank
      t.string :category
      t.string :title

      t.timestamps
    end
  end
end
