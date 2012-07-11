class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.boolean :published
      t.date :publication_date
      t.integer :num_of_hits
      t.references :company
      t.string :name

      t.timestamps
    end
    add_index :campaigns, :company_id
  end
end
