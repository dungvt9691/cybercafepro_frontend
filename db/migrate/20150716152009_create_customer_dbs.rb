class CreateCustomerDbs < ActiveRecord::Migration
  def change
    create_table :customer_dbs do |t|
      t.string :ip
      t.string :cs_email

      t.timestamps null: false
    end
    add_index :customer_dbs, [:ip], :unique => true
  end
end
