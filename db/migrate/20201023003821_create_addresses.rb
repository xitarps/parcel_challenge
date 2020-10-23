class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :requester_zip_code
      t.string :state
      t.string :city
      t.string :street
      t.string :number
      t.references :requester, null: false, foreign_key: true

      t.timestamps
    end
  end
end
