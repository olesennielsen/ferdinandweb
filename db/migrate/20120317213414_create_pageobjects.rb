class CreatePageobjects < ActiveRecord::Migration
  def change
    create_table :pageobjects do |t|
      t.integer :x
      t.integer :y
      t.integer :object_type
      t.integer :color
      t.string :link
      t.string :textobject
      t.references :page

      t.timestamps
    end
    add_index :pageobjects, :page_id
  end
end
