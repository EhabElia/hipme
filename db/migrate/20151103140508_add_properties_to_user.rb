class AddPropertiesToUser < ActiveRecord::Migration
  def change
    add_column :users, :country, :string
    add_column :users, :city, :string
    add_column :users, :zip, :integer
    add_column :users, :street, :string
    add_column :users, :size, :string
  end
end
