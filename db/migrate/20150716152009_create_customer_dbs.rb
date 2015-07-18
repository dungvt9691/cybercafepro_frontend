class CreateCustomerDbs < ActiveRecord::Migration
  def change
    create_table :customer_dbs do |t|
      t.string :ip
      t.string :cs_id

      t.timestamps null: false
    end
  end
end
