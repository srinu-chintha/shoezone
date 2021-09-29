class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :brand
      t.string :model
      t.string :color
      t.float :size
      t.float :price
      t.text :description

      t.timestamps
    end
  end
end
