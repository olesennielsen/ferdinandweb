class CompaniesUsers < ActiveRecord::Migration
  def change
    create_table :companies_users, :id => false do |t|
      t.references :company
      t.references :user

      t.timestamps
    end
    add_index :companies_users, :company_id
    add_index :companies_users, :user_id
  end
end
