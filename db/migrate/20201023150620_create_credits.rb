class CreateCredits < ActiveRecord::Migration[6.0]
  def change
    create_table :credits do |t|
      t.decimal :parcel, precision: 10, scale: 12, default: '0.0', null: false
      t.decimal :tax, precision: 10, scale: 12, null: false
      t.integer :periods, null: false
      t.boolean :already_accepted, null: false, default: false
      t.decimal :loan, precision: 10, scale: 12, null: false
      t.references :requester, null: false, foreign_key: true

      t.timestamps
    end
  end
end
