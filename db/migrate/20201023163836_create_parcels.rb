class CreateParcels < ActiveRecord::Migration[6.0]
  def change
    create_table :parcels do |t|
      t.integer :position, null: false
      t.decimal :value, precision: 10, scale: 12, null: false
      t.date :expiring_date, null: false
      t.boolean :paid, null: false, default: false
      t.references :credit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
