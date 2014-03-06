class CreateUsersAddressesTable < ActiveRecord::Migration
  def change
  	create_table :users_addresses do |t|
		t.integer :user_id
		t.integer :address_id
	end
  end
end
