class CampaingsLocations < ActiveRecord::Migration
  def change
    create_table :campaigns_locations, :id => false do |t|
      t.references :campaign
      t.references :location

      t.timestamps
    end
    add_index :campaigns_locations, :campaign_id
    add_index :campaigns_locations, :location_id
  end
end
