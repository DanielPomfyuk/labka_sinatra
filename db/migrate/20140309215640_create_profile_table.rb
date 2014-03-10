class CreateProfileTable < ActiveRecord::Migration
    def change
	  	create_table :profiles do |t|
	        t.string :gender
	        t.string :location
	        t.string :interest
	        t.integer :user_id
	  	end
    end
end
