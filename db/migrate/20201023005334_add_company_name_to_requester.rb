class AddCompanyNameToRequester < ActiveRecord::Migration[6.0]
  def change
    add_column :requesters, :company_name, :string, null: false
  end
end
