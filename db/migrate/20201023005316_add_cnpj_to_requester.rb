class AddCnpjToRequester < ActiveRecord::Migration[6.0]
  def change
    add_column :requesters, :cnpj, :string, null: false
  end
end
