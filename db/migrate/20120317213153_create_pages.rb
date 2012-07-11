class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :number
      t.references :campaign

      t.timestamps
    end
    add_index :pages, :campaign_id
  end
end
