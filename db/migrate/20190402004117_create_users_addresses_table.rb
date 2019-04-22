class CreateUsersAddressesTable < ActiveRecord::Migration[5.2]
  def change
  	create_table :users_addresses do |t|
		t.integer :user_id
		t.integer :address_id
	end
  end
end
