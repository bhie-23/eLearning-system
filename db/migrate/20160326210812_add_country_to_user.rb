class AddCountryToUser < ActiveRecord::Migration
  def change
    add_column :users, :country, :string, default: "Russia"
  end
end
